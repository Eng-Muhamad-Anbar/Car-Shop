// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:car_admin/app/core/models/user_model.dart';
import 'package:car_admin/app/core/services/error_handler.dart';
import 'package:car_admin/app/core/services/storage_service.dart';
import 'package:car_admin/app/modules/home/cars/cars_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:car_admin/app/core/repo/home_repo.dart';

class ProfileController extends GetxController {
  late TextEditingController fullNameController;
  late TextEditingController userNameController;
  TextEditingController passwordController = TextEditingController();
  late TextEditingController phoneNumberController;
  late TextEditingController cityController;
  final HomeRepo homeRepo;
  final StorageService storageService;
  late User userFromLocalDB;
  late User user;
  WidgetState widgetState = WidgetState.loading;
  ProfileController({required this.homeRepo, required this.storageService});

  Future<void> getUserById() async {
    try {
      widgetState = WidgetState.loading;
      update(["ProfileView"]);
      userFromLocalDB = storageService.getUser()!;
      user = await homeRepo.getUserById(userId: userFromLocalDB.id);
      widgetState = WidgetState.done;
      fullNameController = TextEditingController(text: user.fullName);
      userNameController = TextEditingController(text: user.username);

      phoneNumberController = TextEditingController(text: user.phone);
      cityController = TextEditingController(text: user.city);
    } on ExceptionHandler catch (e) {
      widgetState = WidgetState.error;
      Get.snackbar(
        e.error,
        "",
        duration: const Duration(seconds: 3),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blue,
        colorText: Colors.white,
      );
    }
    update(["ProfileView"]);
  }

  Future<void> updateUserInfo() async {
    try {
      widgetState = WidgetState.loading;
      update(["updateUserInfo"]);
      await homeRepo.updateUserInfo(
          userId: user.id,
          fullName: fullNameController.text,
          userName: userNameController.text,
          password: passwordController.text,
          city: cityController.text,
          phone: phoneNumberController.text);
      widgetState = WidgetState.done;
      storageService.saveUser(user.copyWith(
          username: userNameController.text,
          fullName: fullNameController.text,
          city: cityController.text,
          phone: phoneNumberController.text));
      Get.snackbar(
        "User Info Updated !",
        "",
        duration: const Duration(seconds: 3),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blue,
        colorText: Colors.white,
      );
    } on ExceptionHandler catch (e) {
      widgetState = WidgetState.error;
      log(e.error);
      Get.snackbar(
        e.error,
        "",
        duration: const Duration(seconds: 3),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blue,
        colorText: Colors.white,
      );
    }
    update(["updateUserInfo"]);
  }

  Future<void> logout() async {
    widgetState = WidgetState.loading;
    update(["Logout"]);
    await storageService.removeUser();
    Get.offAllNamed("/wrapper");
  }

  @override
  void onInit() {
    getUserById();
    super.onInit();
  }
}
