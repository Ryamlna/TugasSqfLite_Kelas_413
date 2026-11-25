import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/repo/barang_repo.dart';
import '../../model/barang.dart';

class BarangController extends GetxController {
  final BarangRepo repo;

  BarangController(this.repo);

  final daftarBarang = <Barang>[].obs;

  @override
  void onInit() {
    super.onInit();
    muatData();
  }

  Future<void> muatData() async {
    try {
      daftarBarang.value = await repo.ambilSemua();
    } catch (e) {
      Get.snackbar('Error', 'Gagal memuat data: $e',
          backgroundColor: Colors.red);
    }
  }

  Future<void> tambahBarang(Barang barang) async {
    try {
      await repo.tambah(barang);
      await muatData();
      Get.snackbar('Sukses', 'Barang ${barang.nama} berhasil ditambahkan');
    } catch (e) {
      Get.snackbar('Error', 'Gagal menambah: $e', backgroundColor: Colors.red);
    }
  }

  Future<void> ubahBarang(Barang barang) async {
    try {
      await repo.ubah(barang);
      await muatData();
      Get.snackbar('Sukses', 'Barang ${barang.nama} berhasil diubah');
    } catch (e) {
      Get.snackbar('Error', 'Gagal mengubah: $e', backgroundColor: Colors.red);
    }
  }

  Future<void> hapusBarang(Barang barang) async {
    try {
      await repo.hapus(barang.id!);
      await muatData();
      Get.snackbar('Sukses', 'Barang ${barang.nama} berhasil dihapus');
    } catch (e) {
      Get.snackbar('Error', 'Gagal menghapus: $e',
          backgroundColor: Colors.red);
    }
  }
}
