import '../../model/barang.dart';
import '../dao/barang_dao.dart';

abstract class BarangRepo {
  Future<List<Barang>> ambilSemua();
  Future<int> tambah(Barang barang);
  Future<int> ubah(Barang barang);
  Future<int> hapus(int id);
}

class BarangRepoImpl implements BarangRepo {
  final BarangDao _dao;

  BarangRepoImpl(this._dao);

  @override
  Future<int> hapus(int id) async {
    return await _dao.hapus(id);
  }

  @override
  Future<int> ubah(Barang barang) async {
    return await _dao.ubah(barang);
  }

  @override
  Future<int> tambah(Barang barang) async {
    return await _dao.tambah(barang);
  }

  @override
  Future<List<Barang>> ambilSemua() async {
    return await _dao.ambilSemua();
  }
}
