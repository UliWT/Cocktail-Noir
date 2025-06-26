import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
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
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'dbcocktail.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE tragos (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nombre TEXT,
            descripcion TEXT,
            ingredientes TEXT,
            preparacion TEXT,
            decoracion TEXT,
            tags TEXT
          )
        ''');
      },
    );
  }

  Future<List<Map<String, dynamic>>> getAllTragos() async {
    final db = await database;
    return await db.query('tragos');
  }

  // Opcional: función para insertar tragos (puede servir para precargar)
  Future<int> insertTrago(Map<String, dynamic> trago) async {
    final db = await database;
    return await db.insert('tragos', trago);
  }
}
