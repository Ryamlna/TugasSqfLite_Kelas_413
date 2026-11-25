import 'package:flutter_application_1/model/barang.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Barang bisa dikonversi ke map dan kembali', () {
    const barang = Barang(id: 1, nama: 'Pensil', stok: 10);

    final hasil = Barang.fromMap(barang.toMap());

    expect(hasil.id, 1);
    expect(hasil.nama, 'Pensil');
    expect(hasil.stok, 10);
  });
}
