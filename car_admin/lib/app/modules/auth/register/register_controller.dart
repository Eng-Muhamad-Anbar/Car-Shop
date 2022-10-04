import 'dart:developer';

import 'package:car_admin/app/core/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/models/user_model.dart';
import '../../../core/repo/auth_repo.dart';
import '../../../core/services/error_handler.dart';

class RegisterController extends GetxController {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  final AuthRepo authRepo;
  final StorageService storageService;
  bool isLoading = false;
  String? error;
  RegisterController({required this.authRepo, required this.storageService});
  Future<void> register() async {
    try {
      error = null;
      isLoading = true;
      update(["RegisterButton", "TextError"]);
      User user = await authRepo.register(
          fullName: fullNameController.text,
          userName: userNameController.text,
          password: passwordController.text,
          phoneNumber: phoneNumberController.text,
          city: cityController.text);
      log(user.toString());
      await storageService.saveUser(user);
      Get.offAllNamed("/cars");
      isLoading = false;
      update(["RegisterButton"]);
    } on ExceptionHandler catch (e) {
      log("Error is $e");
      isLoading = false;
      error = e.error;
      update(["RegisterButton", "TextError"]);
    }
  }

  void goToLogin() {
    Get.offNamed("/login");
  }
}
