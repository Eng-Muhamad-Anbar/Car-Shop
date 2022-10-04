import 'package:car_admin/app/core/services/storage_service.dart';
import 'package:car_admin/app/modules/auth/wrapper/wrapper_controller.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class WrapperBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
        Dio(
          (BaseOptions(sendTimeout: 5000, receiveTimeout: 10000)),
        ),
        permanent: true);

    Get.put(StorageService(), permanent: true);
    Get.put(WrapperController(storageService: Get.find<StorageService>()));
  }
}
