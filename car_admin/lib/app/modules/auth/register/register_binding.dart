import 'package:car_admin/app/core/repo/auth_repo.dart';
import 'package:car_admin/app/core/services/storage_service.dart';
import 'package:car_admin/app/modules/auth/register/register_controller.dart';
import 'package:get/get.dart';

class Registerbinding extends Bindings {
  @override
  void dependencies() {
    Get.put(RegisterController(
        authRepo: Get.find<AuthRepo>(),
        storageService: Get.find<StorageService>()));
  }
}
