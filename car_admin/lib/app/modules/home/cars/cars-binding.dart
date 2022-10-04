import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../core/repo/home_repo.dart';
import 'cars_controller.dart';

class CarsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeRepo(dio: Get.find<Dio>()));
    Get.put(CarsController(homeRepo: Get.find<HomeRepo>()));
  }
}
