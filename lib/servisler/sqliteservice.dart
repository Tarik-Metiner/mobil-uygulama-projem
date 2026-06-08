import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class SQLiteService {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    sqfliteFfiInit();

    _database = await databaseFactoryFfi.openDatabase(
      'kullanici.db',
      options: OpenDatabaseOptions(
        version: 4,
        onCreate: _onCreate,
        onOpen: _onOpen,
      ),
    );

    return _database!;
  }

  
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE kullanicilar(
        id INTEGER PRIMARY KEY,
        adsoyad TEXT,
        email TEXT
      )
    ''');

    await db.insert("kullanicilar", {
      "id": 1,
      "adsoyad": "Muhammed Tarik Metiner",
      "email": "030123054@std.izu.edu.tr",
    });
  }

  
  Future<void> _onOpen(Database db) async {
    final result = await db.query(
      "kullanicilar",
      where: "id = ?",
      whereArgs: [1],
    );

    if (result.isEmpty) {
      await db.insert("kullanicilar", {
        "id": 1,
        "adsoyad": "Muhammed Tarik Metiner",
        "email": "030123054@std.izu.edu.tr",
      });
    }
  }

  
  Future<Map<String, dynamic>?> getUser() async {
    final db = await database;

    final result = await db.query(
      "kullanicilar",
      where: "id = ?",
      whereArgs: [1],
    );

    return result.isNotEmpty ? result.first : null;
  }

  
  Future<void> updateUser({
    required String adSoyad,
    required String email,
  }) async {
    final db = await database;

    await db.update(
      "kullanicilar",
      {
        "adsoyad": adSoyad,
        "email": email,
      },
      where: "id = ?",
      whereArgs: [1],
    );
  }
}