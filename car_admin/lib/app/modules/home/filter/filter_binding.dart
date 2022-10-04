import 'package:get/get.dart';

import '../../../core/repo/home_repo.dart';
import 'filter_controller.dart';

class FilterBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(FilterController(
      homeRepo: Get.find<HomeRepo>(),
    ));
  }
}
