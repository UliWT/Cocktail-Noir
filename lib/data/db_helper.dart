import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart'; // para rootBundle
import 'dart:io';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    try {
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      String path = join(documentsDirectory.path, 'dbcocktail.db');

      print('Ruta de BD: $path');
      print('¿Existe archivo? ${File(path).existsSync()}');

      // Cargar bytes del asset a un archivo temporal para poder inspeccionarlo
      print('Cargando asset de DB para comparación...');
      final ByteData assetData = await rootBundle.load('assets/db/dbcocktail.db');
      final List<int> assetBytes = assetData.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final tempPath = join(tempDir.path, 'asset_dbcocktail_tmp.db');
      await File(tempPath).writeAsBytes(assetBytes, flush: true);

      Future<int> _countRows(String dbPath) async {
        Database tmp = await openDatabase(dbPath);
        try {
          final res = await tmp.rawQuery('SELECT COUNT(*) as c FROM tragos');
          if (res.isNotEmpty) {
            final v = res.first.values.first;
            if (v is int) return v;
            if (v is int?) return v ?? 0;
            if (v is BigInt) return v.toInt();
            return int.tryParse(v.toString()) ?? 0;
          }
          return 0;
        } catch (_) {
          return 0;
        } finally {
          await tmp.close();
        }
      }

      Future<int> _getUserVersion(String dbPath) async {
        try {
          Database tmp = await openDatabase(dbPath);
          try {
            final res = await tmp.rawQuery('PRAGMA user_version');
            if (res.isNotEmpty) {
              final v = res.first.values.first;
              return int.tryParse(v.toString()) ?? 0;
            }
          } finally {
            await tmp.close();
          }
        } catch (_) {}
        return 0;
      }

      final int assetCount = await _countRows(tempPath);
      print('Filas en asset DB (tragos): $assetCount');

      bool shouldCopy = false;

      if (!File(path).existsSync()) {
        print('No existe DB en dispositivo -> se copiará la asset');
        shouldCopy = true;
      } else {
        final int deviceCount = await _countRows(path);
        print('Filas en device DB (tragos): $deviceCount');

        if (assetCount > 0 && deviceCount == 0) {
          print('Asset tiene datos y device está vacío -> se copiará la asset');
          shouldCopy = true;
        } else {
          final int assetVer = await _getUserVersion(tempPath);
          final int deviceVer = await _getUserVersion(path);
          print('user_version asset=$assetVer device=$deviceVer');
          if (assetVer > deviceVer) {
            print('Asset DB es más reciente (user_version mayor) -> se copiará');
            shouldCopy = true;
          }
        }
      }

      if (shouldCopy) {
        // Asegurar directorio
        final f = File(path);
        if (f.existsSync()) await f.delete();
        await f.writeAsBytes(assetBytes, flush: true);
        print('DB copiada desde asset a $path');
      } else {
        print('No se copiará la asset; se usará la copy existente en dispositivo');
      }

      // Limpiar temporal
      try {
        final tmpF = File(tempPath);
        if (tmpF.existsSync()) await tmpF.delete();
      } catch (_) {}

      // Abrimos la DB ya con los datos
      return await openDatabase(path, version: 1);
    } catch (e) {
      print('Error inicializando BD: $e');
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getAllTragos() async {
    try {
      final db = await database;
      final result = await db.query('tragos');
      print("Se cargaron ${result.length} tragos desde la base de datos");
      return result;
    } catch (e) {
      print('Error cargando tragos: $e');
      return [];
    }
  }

  /// Método de ayuda para debug: lista tablas, estructura de `tragos`, conteo y primeras filas
  Future<void> debugDump() async {
    try {
      final db = await database;

      // Listar tablas en sqlite_master
      final tables = await db.rawQuery("SELECT name, type FROM sqlite_master WHERE type IN ('table','view') ORDER BY name");
      print('Tablas en la BD: ${tables.length}');
      for (final t in tables) {
        print(' - ${t['type']}: ${t['name']}');
      }

      // Información de columnas de la tabla `tragos`
      final tableInfo = await db.rawQuery("PRAGMA table_info('tragos')");
      print('Columnas en tabla tragos: ${tableInfo.length}');
      for (final col in tableInfo) {
        print(' - ${col['name']} (${col['type']}) pk=${col['pk']} notnull=${col['notnull']}');
      }

      // Conteo y primeras filas
      final countRes = await db.rawQuery('SELECT COUNT(*) as c FROM tragos');
      final count = (countRes.isNotEmpty && countRes.first.containsKey('c')) ? countRes.first['c'] : null;
      print('Conteo de filas en tragos: $count');

      final rows = await db.rawQuery('SELECT * FROM tragos LIMIT 5');
      print('Primeras filas (hasta 5): ${rows.length}');
      for (var r in rows) {
        print(' - fila: $r');
      }
    } catch (e) {
      print('Error en debugDump: $e');
    }
  }


  Future<int> insertTrago(Map<String, dynamic> trago) async {
    final db = await database;
    return await db.insert('tragos', trago);
  }

  Future<int> updateTrago(Map<String, dynamic> trago) async {
    final db = await database;
    return await db.update(
      'tragos',
      trago,
      where: 'id = ?',
      whereArgs: [trago['id']],
    );
  }

  Future<int> deleteTrago(int id) async {
    final db = await database;
    return await db.delete(
      'tragos',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
