import '../../model/barang.dart';
import '../database/db_helper.dart';

class BarangDao {
  final DbHelper dbHelper;

  BarangDao(this.dbHelper);

  Future<List<Barang>> ambilSemua() async {
    final db = await dbHelper.database;
    final hasil = await db.query(DbHelper.namaTabel, orderBy: 'id DESC');
    return [for (final baris in hasil) Barang.fromMap(baris)];
  }

  Future<int> tambah(Barang barang) async {
    final db = await dbHelper.database;
    return await db.insert(DbHelper.namaTabel, barang.toMap());
  }

  Future<int> ubah(Barang barang) async {
    final db = await dbHelper.database;
    return await db.update(
      DbHelper.namaTabel,
      barang.toMap(),
      where: 'id = ?',
      whereArgs: [barang.id],
    );
  }

  Future<int> hapus(int id) async {
    final db = await dbHelper.database;
    return await db.delete(
      DbHelper.namaTabel,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
