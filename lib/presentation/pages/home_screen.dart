import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/barang.dart';
import '../controller/barang_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BarangController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _tampilkanForm(controller),
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8),
            child: Text('LIST BARANG'),
          ),
          Expanded(
            child: Obx(() {
              final data = controller.daftarBarang;

              if (data.isEmpty) {
                return const Center(child: Text('Data Belum Ada'));
              }

              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (_, i) => _itemBarang(controller, data[i]),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _itemBarang(BarangController controller, Barang barang) {
    return Card(
      child: ListTile(
        title: Text(barang.nama),
        subtitle: Text('Stok Barang ${barang.stok}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: () => _tampilkanForm(controller, barang: barang),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _tampilkanKonfirmasiHapus(controller, barang),
            ),
          ],
        ),
      ),
    );
  }

  void _tampilkanForm(BarangController controller, {Barang? barang}) {
    final kunciForm = GlobalKey<FormState>();
    final inputNama = TextEditingController(text: barang?.nama);
    final inputStok = TextEditingController(text: barang?.stok.toString());
    final modeUbah = barang != null;

    void simpan() {
      if (!kunciForm.currentState!.validate()) return;

      final dataBaru = Barang(
        id: barang?.id,
        nama: inputNama.text.trim(),
        stok: int.parse(inputStok.text.trim()),
      );

      Get.back();
      modeUbah
          ? controller.ubahBarang(dataBaru)
          : controller.tambahBarang(dataBaru);
    }

    Get.dialog(
      AlertDialog(
        title: Text(modeUbah ? 'Ubah Barang' : 'Tambah Barang'),
        content: Form(
          key: kunciForm,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: inputNama,
                decoration: const InputDecoration(labelText: 'Nama Barang'),
                validator: (nilai) {
                  if (nilai == null || nilai.trim().isEmpty) {
                    return 'Nama wajib diisi';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: inputStok,
                decoration: const InputDecoration(labelText: 'Stok'),
                keyboardType: TextInputType.number,
                validator: (nilai) {
                  final teks = nilai?.trim() ?? '';
                  if (teks.isEmpty) return 'Stok wajib diisi';
                  if (int.tryParse(teks) == null) return 'Stok harus angka';
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: Get.back, child: const Text('Batal')),
          ElevatedButton(
            onPressed: simpan,
            child: Text(modeUbah ? 'Simpan' : 'Tambah'),
          ),
        ],
      ),
    );
  }

  void _tampilkanKonfirmasiHapus(BarangController controller, Barang barang) {
    Get.dialog(
      AlertDialog(
        title: const Text('Hapus Barang'),
        content: Text('Yakin ingin menghapus "${barang.nama}"?'),
        actions: [
          TextButton(onPressed: Get.back, child: const Text('Batal')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Get.back();
              controller.hapusBarang(barang);
            },
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }
}
