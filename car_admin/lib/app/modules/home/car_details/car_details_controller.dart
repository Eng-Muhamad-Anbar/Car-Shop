import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/models/car_model.dart';
import '../../../core/models/user_model.dart';
import '../../../core/repo/home_repo.dart';
import '../../../core/services/error_handler.dart';
import '../../../core/services/storage_service.dart';

class CarDetailsController extends GetxController {
  CarDetailsController({required this.homeRepo, required this.storageService});
  PageController pageController = PageController();
  HomeRepo homeRepo;
  StorageService storageService;
  late Car car;
  CarButtonState carButtonState = CarButtonState.add;

  @override
  void onInit() {
    car = Get.arguments["car"] as Car;
    bool isExists = storageService.checkCarInUserCarsById(car.id);
    log(isExists.toString());
    if (isExists) {
      carButtonState = CarButtonState.willRemove;
    } else {
      carButtonState = CarButtonState.add;
    }
    log(car.toString());
    //isAdded();
    super.onInit();
  }

  // before removing from cart
  /*void isAdded() {
    User user = storageService.getUser()!;
    for (int i = 0; i < user.cars.length; i++) {
      if (user.cars[i].id == car.id) {
        carButtonState = CarButtonState.willRemove;
      }
    }
  }*/

  Future<void> addToCart() async {
    try {
      carButtonState = CarButtonState.loading;
      update(["CarButtonState"]);
      log("Start adding car");
      User user = storageService.getUser()!;
      log(user.cars.length.toString());
      log(user.cars.toString());
      log("the User ${user.id} car ${car.model} its id is: ${car.id}");
      List<String> carsIds = [car.id];
      for (int i = 0; i < user.cars.length; i++) {
        Car currentCar = user.cars[i];
        carsIds.add(currentCar.id);
      }

      await homeRepo.patchUserCars(userId: user.id, userCarsId: carsIds);
      user.cars.add(car);
      await storageService.saveUser(user);
      log(user.cars.length.toString());
      log(user.cars.toString());
      log(carsIds.toString());
      log("Done adding car");
      carButtonState = CarButtonState.willRemove;
    } on ExceptionHandler catch (e) {
      log(e.error);
      Get.snackbar(e.error, "",
          duration: const Duration(seconds: 3),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.blue,
          colorText: Colors.white,
          titleText: Text(
            e.error,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ));

      carButtonState = CarButtonState.add;
    }
    update(["CarButtonState"]);
  }

  Future<void> removeFromCart() async {
    try {
      carButtonState = CarButtonState.loading;
      update(["CarButtonState"]);
      log("Start removing car");
      User user = storageService.getUser()!;
      log(user.cars.length.toString());
      log("the User ${user.id} car ${car.model} its id is: ${car.id}");
      List<String> carsIds = [];
      for (int i = 0; i < user.cars.length; i++) {
        Car currentCar = user.cars[i];
        if (currentCar.id != car.id) {
          carsIds.add(currentCar.id);
        }
      }
      log("user cached car ids: ${carsIds.length}");
      await homeRepo.patchUserCars(userId: user.id, userCarsId: carsIds);
      log(user.cars.length.toString());
      user.cars.removeWhere((currentCar) => currentCar.id == car.id);
      // for (int i = 0; i < user.cars.length; i++) {
      //   Car currentCar = user.cars[i];
      //   if (currentCar.id == car.id) {
      //     user.cars.remove(car);
      //   }
      // }
      await storageService.saveUser(user);
      log(user.cars.length.toString());

      log("removing car Done");
      carButtonState = CarButtonState.add;
      update(["CarButtonState"]);
    } on ExceptionHandler catch (e) {
      log(e.error);
      Get.snackbar(e.error, "",
          duration: const Duration(seconds: 3),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.blue,
          colorText: Colors.white,
          titleText: Text(
            e.error,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ));
      carButtonState = CarButtonState.willRemove;
      update(["CarButtonState"]);
    }
  }
}

enum CarButtonState { add, willRemove, loading }
