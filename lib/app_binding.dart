import 'package:get/get.dart';
import 'data/dao/barang_dao.dart';
import 'data/database/db_helper.dart';
import 'data/repo/barang_repo.dart';
import 'presentation/controller/barang_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    final dbHelper = DbHelper();
    final dao = BarangDao(dbHelper);
    final BarangRepo repo = BarangRepoImpl(dao);

    Get.put(dbHelper);
    Get.put(dao);
    Get.put<BarangRepo>(repo);
    Get.put(BarangController(repo));
  }
}
