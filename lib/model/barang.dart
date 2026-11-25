class Barang {
  final int? id;
  final String nama;
  final int stok;

  const Barang({this.id, required this.nama, required this.stok});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'stok': stok,
    };
  }

  factory Barang.fromMap(Map<String, dynamic> map) {
    return Barang(
      id: map['id'] as int?,
      nama: map['nama'] as String,
      stok: map['stok'] as int,
    );
  }
}
