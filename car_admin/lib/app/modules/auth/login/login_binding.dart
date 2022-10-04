import 'package:car_admin/app/core/repo/auth_repo.dart';
import 'package:car_admin/app/core/services/storage_service.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

import 'login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthRepo(Get.find<Dio>()), permanent: true);
    Get.put(LoginController(
        authRepo: Get.find<AuthRepo>(),
        storageService: Get.find<StorageService>()));
  }
}
