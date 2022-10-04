import 'dart:developer';

import 'package:get/get.dart';

import 'package:car_admin/app/core/services/storage_service.dart';

import '../../../core/models/user_model.dart';

class WrapperController extends GetxController {
  final StorageService storageService;
  WrapperController({
    required this.storageService,
  });
  void getUserLastState() async {
    User? user = await Future.value(storageService.getUser());

    if (user != null) {
      Get.offAllNamed("/cars");
      log(user.toString());
    } else {
      Get.offAllNamed("/login");
      log("user is null");
    }
  }

  @override
  void onInit() {
    getUserLastState();
    log("getUserLastState");
    super.onInit();
  }
}
