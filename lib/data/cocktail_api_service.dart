import 'package:http/http.dart' as http;
import 'dart:convert';

class CocktailApiService {
  static const String baseUrl = 'https://www.thecocktaildb.com/api/json/v1/1';

  /// Obtiene todos los cócteles disponibles desde TheCocktailDB.
  /// Retorna una lista de mapas con los datos de cada cóctel.
  static Future<List<Map<String, dynamic>>> getAllCocktails() async {
    try {
      print('Iniciando descarga de cócteles desde TheCocktailDB...');
      final List<Map<String, dynamic>> allCocktails = [];

      // Obtener todas las bebidas por letra (A-Z)
      for (int i = 0; i < 26; i++) {
        final String letter = String.fromCharCode(65 + i); // A-Z
        print('Descargando cócteles que empiezan con: $letter');

        try {
          final response = await http.get(
            Uri.parse('$baseUrl/search.php?f=$letter'),
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
            }
          }
        } catch (e) {
          print('Error descargando letra $letter: $e');
          continue;
        }

        // Pequeño delay para no saturar la API
        await Future.delayed(const Duration(milliseconds: 200));
      }

      print('Descarga completada. Total de cócteles: ${allCocktails.length}');
      return allCocktails;
    } catch (e) {
      print('Error en getAllCocktails: $e');
      rethrow;
    }
  }

  /// Mapea un objeto drink de TheCocktailDB al schema local de tragos
  static Map<String, dynamic>? _mapDrinkToCocktail(Map<String, dynamic> drink) {
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
      if (ingredientesStr.isEmpty) return null; // No agregar tragos sin ingredientes

      final String? preparacion = drink['strInstructions'];
      final String? decoracion = null; // TheCocktailDB no tiene este campo específico
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
        'decoracion': decoracion ?? '',
        'tags': tags.join(','),
      };
    } catch (e) {
      print('Error mapeando drink: $e');
      return null;
    }
  }

  /// Obtiene un cóctel específico por nombre (para búsqueda individual)
  static Future<Map<String, dynamic>?> getCocktailByName(String name) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/search.php?s=${Uri.encodeComponent(name)}'),
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final drinks = jsonData['drinks'] as List?;

        if (drinks != null && drinks.isNotEmpty) {
          return _mapDrinkToCocktail(drinks.first);
        }
      }
      return null;
    } catch (e) {
      print('Error en getCocktailByName: $e');
      return null;
    }
  }

  /// Obtiene cócteles por ingrediente
  static Future<List<Map<String, dynamic>>> getCocktailsByIngredient(
      String ingredient) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/filter.php?i=${Uri.encodeComponent(ingredient)}'),
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final drinks = jsonData['drinks'] as List?;

        if (drinks != null && drinks.isNotEmpty) {
          final List<Map<String, dynamic>> result = [];
          for (var drink in drinks) {
            final cocktail = _mapDrinkToCocktail(drink);
            if (cocktail != null) {
              result.add(cocktail);
            }
          }
          return result;
        }
      }
      return [];
    } catch (e) {
      print('Error en getCocktailsByIngredient: $e');
      return [];
    }
  }
}
