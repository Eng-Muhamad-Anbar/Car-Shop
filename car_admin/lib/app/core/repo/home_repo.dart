import 'dart:developer';

import 'package:car_admin/app/core/models/filter_model.dart';
import 'package:car_admin/app/core/models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';

import '../models/car_model.dart';
import '../services/error_handler.dart';

class HomeRepo {
  final Dio dio;
  String baseUrl = "https://cars-mysql-backend.herokuapp.com";

  HomeRepo({
    required this.dio,
  });
  Future<List<Car>> getCars({
    required int skip,
  }) async {
    try {
      Map<String, dynamic>? queryParameters = {
        "skip": skip * 5,
        "take": 5,
      };
      log(queryParameters.toString(), name: "Start getting the cars");

      Response response = await dio.get('$baseUrl/car/category',
          queryParameters: queryParameters);
      log("Response:${response.data}");
      return Car.carList(response.data);
    } catch (e) {
      log(e.toString());
      throw ExceptionHandler("Can't get the cars");
    }
  }

  Future<void> patchUserCars(
      {required String userId, required List<String> userCarsId}) async {
    try {
      log("Start patching userCars");
      await dio.patch("$baseUrl/user/$userId/cars", data: {"cars": userCarsId});
      log("Done patching userCars");
    } catch (e) {
      throw ExceptionHandler("Cannot add car to user");
    }
  }

  Future<Car> addCar(
      {required String carBrand,
      required String carModel,
      required String carYOM,
      required String carPrice,
      required String carCategory,
      required String carDescription,
      required String carColor,
      required String carMainImage,
      required List<String> carImages}) async {
    try {
      log(carCategory);
      Response response = await dio.post('$baseUrl/car', data: {
        "brand": carBrand,
        "model": carModel,
        "yom": carYOM,
        "color": carColor,
        "price": carPrice,
        "category": carCategory,
        "description": carDescription,
        "image": carMainImage,
        "images": carImages
      });
      log(response.data.toString());
      Car carAdded = Car.fromMap(response.data);
      return carAdded;
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 400) {
          throw ExceptionHandler("Car Already Exist");
        }
      }
    }
    throw ExceptionHandler("Unknown Error");
  }

  Future<String> uploadFile({required PlatformFile file}) async {
    try {
      final FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(file.path!,
            filename: file.path!
                .split('/')
                .last), // storage/0/m.png=> [storage,0,m.png]
      });
      final Response response = await dio.post(
        'https://api.hala-technology.com/students-and-teachers/file/uploadFile',
        data: formData,
      );
      return response.data['urls'][0];
    } catch (e) {
      throw ExceptionHandler(e.toString());
    }
  }

  Future<User> getUserById({required String userId}) async {
    try {
      Response response = await dio.get("$baseUrl/user/$userId");
      User user = User.fromMap(response.data);
      return user;
    } catch (error) {
      log(error.toString());
      throw ExceptionHandler("Can't get the User");
    }
  }

  Future<void> updateUserInfo({
    required String userId,
    String? fullName,
    String? userName,
    String? password,
    String? city,
    String? phone,
  }) async {
    try {
      log("start updateUser");
      Map userInfo = {
        "full_name": fullName,
        "username": userName,
        "password": password,
        "city": city,
        "phone": phone
      };
      log(userInfo.toString());
      userInfo.removeWhere((key, value) => value == null);
      await dio.patch("$baseUrl/user/$userId", data: userInfo);
      log("done updateUser");
    } catch (error) {
      log(error.toString());
      throw ExceptionHandler("Can't update the User");
    }
  }

  Future<List<Car>> filterCars(
      {required int skip, required FilterModel filter}) async {
    try {
      Map<String, dynamic>? queryParameters = {
        "skip": skip * 10,
        "take": 10,
        "brand": filter.carBrand,
        "model": filter.carModel,
        "yom": filter.carYOM,
        "startPrice": filter.carStartPrice,
        "endPrice": filter.carEndPrice,
        "category": filter.carCategories
      };
      log(queryParameters.toString(), name: "Start getting the cars");
      queryParameters.removeWhere((key, value) => value == null || value == "");
      Response response = await dio.get('$baseUrl/car/filter',
          queryParameters: queryParameters);
      log("Response:${response.data}");
      return Car.carList(response.data);
    } catch (e) {
      log(e.toString());
      throw ExceptionHandler("Can't get the cars");
    }
  }
}
