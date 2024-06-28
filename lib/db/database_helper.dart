import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:path/path.dart';
import 'package:sembast/sembast.dart' as sembast;
import 'package:sembast_web/sembast_web.dart';
import 'dart:io' show Platform;
import '../models/surat.dart';
import 'package:flutter/foundation.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static sqflite.Database? _database;
  static sembast.DatabaseFactory? _dbFactory;
  static sembast.Database? _sembastDatabase;
  static final sembast.StoreRef<int, Map<String, dynamic>> store = sembast.intMapStoreFactory.store('surat');

  Future<dynamic> get database async {
    if (kIsWeb) {
      return await _initSembastDatabase();
    } else {
      if (_database != null) return _database!;
      _database = await _initDatabase();
      return _database!;
    }
  }

  Future<sqflite.Database> _initDatabase() async {
    String path = join(await sqflite.getDatabasesPath(), 'surat.db');
    print("Database path: $path");
    return await sqflite.openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<sembast.Database> _initSembastDatabase() async {
    if (_sembastDatabase != null) return _sembastDatabase!;
    _dbFactory = databaseFactoryWeb;
    _sembastDatabase = await _dbFactory!.openDatabase('surat.db');
    return _sembastDatabase!;
  }

  Future<void> _onCreate(sqflite.Database db, int version) async {
    print("Creating database table");
    await db.execute('''
      CREATE TABLE surat(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nama TEXT NOT NULL,
        jabatan TEXT NOT NULL,
        perusahaan TEXT NOT NULL,
        namaPenerima TEXT NOT NULL,
        jabatanPenerima TEXT NOT NULL,
        namaMahasiswa TEXT NOT NULL,
        nim TEXT NOT NULL,
        kelas TEXT NOT NULL,
        namaUniv TEXT NOT NULL,
        perihalIzin TEXT NOT NULL,
        izinMulai TEXT NOT NULL,
        izinSelesai TEXT NOT NULL,
        tempatTerbit TEXT NOT NULL,
        tanggalTerbit TEXT NOT NULL,
        uploadTTD TEXT NOT NULL
      )
    ''');
  }

  Future<void> insertSurat(Surat surat) async {
    final db = await database;
    if (kIsWeb) {
      int key = await store.add(db, surat.toMap());
      surat.id = key; // Update the surat object with the generated key
    } else {
      await db.insert('surat', surat.toMap(), conflictAlgorithm: sqflite.ConflictAlgorithm.replace);
    }
    print("Inserted surat: ${surat.toMap()}");
  }

  Future<List<Surat>> getSuratList() async {
    final db = await database;
    if (kIsWeb) {
      final snapshots = await store.find(db);
      print("Retrieved surat list: $snapshots");
      return snapshots.map((snapshot) {
        final surat = Surat.fromMap(snapshot.value);
        surat.id = snapshot.key; // Assign the key to the surat ID
        return surat;
      }).toList();
    } else {
      final List<Map<String, dynamic>> maps = await db.query('surat');
      print("Retrieved surat list: $maps");
      return List.generate(maps.length, (i) => Surat.fromMap(maps[i]));
    }
  }

  Future<void> updateSurat(Surat surat) async {
    final db = await database;
    if (kIsWeb) {
      final finder = sembast.Finder(filter: sembast.Filter.byKey(surat.id));
      await store.update(db, surat.toMap(), finder: finder);
    } else {
      await db.update('surat', surat.toMap(), where: 'id = ?', whereArgs: [surat.id]);
    }
    print("Updated surat: ${surat.toMap()}");
  }

  Future<void> deleteSurat(int id) async {
    final db = await database;
    if (kIsWeb) {
      final finder = sembast.Finder(filter: sembast.Filter.byKey(id));
      await store.delete(db, finder: finder);
    } else {
      await db.delete('surat', where: 'id = ?', whereArgs: [id]);
    }
    print("Deleted surat with id: $id");
  }
}
