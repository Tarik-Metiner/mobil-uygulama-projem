import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLiteService {
  Database? _db;

  Future<Database> get database async {
    if (kIsWeb) {
      throw Exception("Web SQLite desteklenmiyor");
    }

    if (_db != null) return _db!;

    final path = join(await getDatabasesPath(), 'kullanici.db');

    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE kullanicilar(
            id INTEGER PRIMARY KEY,
            adsoyad TEXT,
            email TEXT,
            fotograf TEXT
          )
        ''');

        await db.insert("kullanicilar", {
          "id": 1,
          "adsoyad": "Muhammed Tarik Metiner",
          "email": "030123054@std.izu.edu.tr",
          "fotograf":
              "https://sbnrqkgntlsyiknmsgds.supabase.co/storage/v1/object/public/resimler/o8mz9znC.jpg"
        });
      },
    );

    return _db!;
  }

  Future<Map<String, dynamic>> getUser() async {
    try {
      if (kIsWeb) {
        return {
          "id": 1,
          "adsoyad": "Muhammed Tarik Metiner",
          "email": "030123054@std.izu.edu.tr",
          "fotograf":
              "https://sbnrqkgntlsyiknmsgds.supabase.co/storage/v1/object/public/resimler/o8mz9znC.jpg"
        };
      }

      final db = await database;

      final result = await db.query(
        "kullanicilar",
        where: "id = ?",
        whereArgs: [1],
      );

      if (result.isNotEmpty) return result.first;

      return {
        "adsoyad": "Kullanici",
        "email": "",
        "fotograf": ""
      };
    } catch (e) {
      return {
        "adsoyad": "Kullanici",
        "email": "",
        "fotograf": ""
      };
    }
  }
}