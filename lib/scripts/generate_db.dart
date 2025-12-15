import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sqlite3/sqlite3.dart';

/// Script para generar la BD de cócteles desde la API de TheCocktailDB
/// Ejecutar con: dart run lib/scripts/generate_db.dart
/// Esto creará assets/db/dbcocktail.db con todos los cócteles

const String apiBaseUrl = 'https://www.thecocktaildb.com/api/json/v1/1';
const String outputPath = 'assets/db/dbcocktail.db';

Future<List<Map<String, dynamic>>> _getAllCocktails() async {
  final List<Map<String, dynamic>> allCocktails = [];

  // Descargar cócteles por letra (A-Z)
  for (int i = 0; i < 26; i++) {
    final String letter = String.fromCharCode(65 + i); // A-Z
    try {
      final response = await http.get(
        Uri.parse('$apiBaseUrl/search.php?f=$letter'),
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final drinks = jsonData['drinks'] as List?;

        if (drinks != null && drinks.isNotEmpty) {
          for (var drink in drinks) {
            final cocktail = _mapDrinkToCocktail(drink);
            if (cocktail != null) {
              allCocktails.add(cocktail);
            }
          }
          print('  [$letter] ${drinks.length} cócteles descargados');
        }
      }
    } catch (e) {
      print('  ⚠️  Error descargando letra $letter: $e');
      continue;
    }

    // Delay para no saturar la API
    await Future.delayed(const Duration(milliseconds: 300));
  }

  return allCocktails;
}

/// Mapea un drink de la API al schema local
Map<String, dynamic>? _mapDrinkToCocktail(Map<String, dynamic> drink) {
  try {
    final String nombre = drink['strDrink'] ?? 'Unknown';
    final String? descripcion = drink['strTags'] ?? drink['strCategory'];

    // Extraer ingredientes y medidas
    final List<String> ingredientes = [];
    for (int i = 1; i <= 15; i++) {
      final ingrediente = drink['strIngredient$i'];
      final medida = drink['strMeasure$i'];

      if (ingrediente != null && ingrediente.toString().isNotEmpty) {
        final ingredient = ingrediente.toString().trim();
        final measure = medida != null ? medida.toString().trim() : '';

        if (measure.isNotEmpty) {
          ingredientes.add('$measure $ingredient');
        } else {
          ingredientes.add(ingredient);
        }
      }
    }

    final String ingredientesStr = ingredientes.join('\n');
    if (ingredientesStr.isEmpty) return null;

    final String? preparacion = drink['strInstructions'];
    final String categoria = drink['strCategory'] ?? 'Otro';
    final String tipoAlcohol = drink['strAlcoholic'] ?? 'Con Alcohol';

    final List<String> tags = [];
    tags.add(categoria);
    tags.add(tipoAlcohol);
    if (descripcion != null && descripcion.isNotEmpty) {
      tags.addAll(descripcion.split(',').map((t) => t.trim()));
    }

    return {
      'nombre': nombre,
      'descripcion': descripcion ?? '',
      'ingredientes': ingredientesStr,
      'preparacion': preparacion ?? '',
      'decoracion': '',
      'tags': tags.join(','),
    };
  } catch (e) {
    return null;
  }
}

void main() async {
  try {
    print('=== Generador de BD de Cócteles ===\n');
    print('Descargando cócteles de TheCocktailDB API...');
    print('Esto puede tardar 10-20 minutos...\n');

    // Descargar todos los cócteles
    final cocktails = await _getAllCocktails();
    print('\n✓ Descarga completada: ${cocktails.length} cócteles\n');

    if (cocktails.isEmpty) {
      print('❌ Error: No se descargaron cócteles');
      exit(1);
    }

    // Crear directorio assets/db si no existe
    final assetsDir = Directory('assets/db');
    if (!assetsDir.existsSync()) {
      assetsDir.createSync(recursive: true);
      print('✓ Directorio assets/db creado\n');
    }

    // Eliminar BD anterior si existe
    final dbFile = File(outputPath);
    if (dbFile.existsSync()) {
      dbFile.deleteSync();
      print('✓ BD anterior eliminada\n');
    }

    // Crear y llenar BD
    print('Creando base de datos...');
    final db = sqlite3.open(outputPath);

    db.execute('''
      CREATE TABLE tragos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nombre TEXT UNIQUE,
        descripcion TEXT,
        ingredientes TEXT,
        preparacion TEXT,
        decoracion TEXT,
        tags TEXT
      )
    ''');

    print('Insertando ${cocktails.length} cócteles...');
    int inserted = 0;
    int skipped = 0;

    for (var cocktail in cocktails) {
      try {
        db.prepare('''
          INSERT INTO tragos (nombre, descripcion, ingredientes, preparacion, decoracion, tags)
          VALUES (?, ?, ?, ?, ?, ?)
        ''').execute([
          cocktail['nombre'],
          cocktail['descripcion'],
          cocktail['ingredientes'],
          cocktail['preparacion'],
          cocktail['decoracion'],
          cocktail['tags'],
        ]);
        inserted++;
        if (inserted % 100 == 0) {
          print('  $inserted cócteles insertados...');
        }
      } catch (e) {
        skipped++;
      }
    }

    db.dispose();

    print('\n✓ Base de datos creada exitosamente en: $outputPath');
    print('  - Cócteles insertados: $inserted');
    print('  - Cócteles omitidos (duplicados): $skipped');
    print('\n¡Listo! Ahora ejecuta: flutter run\n');
  } catch (e) {
    print('\n❌ Error: $e');
    exit(1);
  }
}
