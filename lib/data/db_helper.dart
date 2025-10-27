import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DBHelper {
  // Singleton
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  static Database? _db;

  // Getter para la base de datos
  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  // Inicializa la base de datos
  Future<Database> _initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'dbcocktail.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  // Crea la tabla tragos
  Future _onCreate(Database db, int version) async {
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
  }

  // Obtener todos los tragos
  Future<List<Map<String, dynamic>>> getAllTragos() async {
    final db = await database;
    return await db.query('tragos');
  }

  // Insertar un trago
  Future<int> insertTrago(Map<String, dynamic> trago) async {
    final db = await database;
    return await db.insert('tragos', trago);
  }

  // Actualizar un trago
  Future<int> updateTrago(Map<String, dynamic> trago) async {
    final db = await database;
    return await db.update(
      'tragos',
      trago,
      where: 'id = ?',
      whereArgs: [trago['id']],
    );
  }

  // Eliminar un trago
  Future<int> deleteTrago(int id) async {
    final db = await database;
    return await db.delete(
      'tragos',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
