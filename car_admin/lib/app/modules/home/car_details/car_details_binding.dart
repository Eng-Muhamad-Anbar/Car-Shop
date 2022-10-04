import 'package:car_admin/app/core/repo/home_repo.dart';
import 'package:car_admin/app/core/services/storage_service.dart';
import 'package:car_admin/app/modules/home/car_details/car_details_controller.dart';
import 'package:get/get.dart';

class CarDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CarDetailsController(
        homeRepo: Get.find<HomeRepo>(),
        storageService: Get.find<StorageService>()));
  }
}
