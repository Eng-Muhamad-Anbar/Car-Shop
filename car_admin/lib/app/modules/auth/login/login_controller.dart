// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:car_admin/app/core/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:car_admin/app/core/repo/auth_repo.dart';

import '../../../core/models/user_model.dart';
import '../../../core/services/error_handler.dart';

class LoginController extends GetxController {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final StorageService storageService;
  final AuthRepo authRepo;
  bool isLoading = false;
  String? error;
  LoginController({required this.authRepo, required this.storageService});
  Future<void> login() async {
    try {
      error = null;
      isLoading = true;
      update(["ElevatedButton", "TextError"]);
      User user = await authRepo.login(
          username: userNameController.text, password: passwordController.text);
      log(user.toString());
      await storageService.saveUser(user);
      Get.offAllNamed("/cars");
      isLoading = false;
      update(["ElevatedButton"]);
    } on ExceptionHandler catch (e) {
      log("Error is $e");
      isLoading = false;
      error = e.error;
      update(["ElevatedButton", "TextError"]);
    }
  }

  void goToRegister() {
    Get.offNamed("/register");
  }
}
