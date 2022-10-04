import 'dart:developer';

import 'package:car_admin/app/core/models/car_model.dart';
import 'package:get_storage/get_storage.dart';

import '../models/user_model.dart';

class StorageService {
  static final GetStorage userBox = GetStorage();
  static String appUserKey = "appUser";

  Future<void> saveUser(User user) async {
    var jsonUser = user.toJson();
    await userBox.write(appUserKey, jsonUser);
  }

  User? getUser() {
    var jsonUser = userBox.read(appUserKey);
    log(jsonUser.toString());
    if (jsonUser == null) {
      return null;
    } else {
      return User.fromMap(jsonUser);
    }
  }

  // Check if car exists in users' cars by car id
  bool checkCarInUserCarsById(String id) {
    var jsonUser = userBox.read(appUserKey);
    if (jsonUser == null) return false;
    User user = User.fromMap(jsonUser);
    for (Car car in user.cars) {
      if (car.id == id) return true;
    }
    return false;
  }

  Future<void> removeUser() async {
    await userBox.remove(appUserKey);
  }
}
