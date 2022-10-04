import 'dart:developer';

import 'package:dio/dio.dart';

import '../models/user_model.dart';
import '../services/error_handler.dart';

String baseUrl = "https://cars-mysql-backend.herokuapp.com";

class AuthRepo {
  final Dio dio;
  AuthRepo(this.dio);
  Future<User> login(
      {required String username, required String password}) async {
    try {
      var response = await dio.post("$baseUrl/user/login",
          data: {"username": username, "password": password});
      User user = User.fromMap(response.data);
      return user;
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 404) {
          throw ExceptionHandler("User not found");
        } else if (e.response!.statusCode == 409) {
          throw ExceptionHandler("Wrong Password");
        }
      }
    }
    throw ExceptionHandler("Unknown Error");
  }

  Future<User> register(
      {required String fullName,
      required String userName,
      required String password,
      required String phoneNumber,
      required String city}) async {
    try {
      var response = await dio.post("$baseUrl/user/register", data: {
        "full_name": fullName,
        "username": userName,
        "password": password,
        "city": city,
        "phone": phoneNumber
      });
      log(response.data.toString());
      User user = User.fromMap(response.data);
      return user;
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 400) {
          throw ExceptionHandler("User Already Exist");
        }
      }
    }
    throw ExceptionHandler("Unknown Error");
  }
}
