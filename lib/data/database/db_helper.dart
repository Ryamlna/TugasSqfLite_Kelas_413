import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static const String namaDb = 'barang.db';
  static const String namaTabel = 'barang';
  static const int versiDb = 1;

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _bukaDatabase();
    return _database!;
  }

  Future<Database> _bukaDatabase() async {
    final folder = await getDatabasesPath();
    final lokasi = join(folder, namaDb);

    return await openDatabase(
      lokasi,
      version: versiDb,
      onCreate: _buatTabel,
    );
  }

  Future<void> _buatTabel(Database db, int versi) async {
    await db.execute(
      'CREATE TABLE $namaTabel ('
      'id INTEGER PRIMARY KEY AUTOINCREMENT, '
      'nama TEXT NOT NULL, '
      'stok INTEGER NOT NULL)',
    );
  }
}
