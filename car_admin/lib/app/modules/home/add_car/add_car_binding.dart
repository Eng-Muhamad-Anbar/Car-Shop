import 'package:car_admin/app/core/repo/home_repo.dart';
import 'package:get/get.dart';

import 'add_car_controller.dart';

class AddCarBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AddCarController(homeRepo: Get.find<HomeRepo>()));
  }
}
