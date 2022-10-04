// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:car_admin/app/core/services/error_handler.dart';
import 'package:car_admin/app/modules/home/cars/cars_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:car_admin/app/core/models/filter_model.dart';
import 'package:car_admin/app/core/repo/home_repo.dart';

import '../../../core/models/car_model.dart';

class FilterController extends GetxController {
  late FilterModel filterModel;
  HomeRepo homeRepo;
  List<Car> filteredCars = [];
  WidgetState widgetState = WidgetState.loading;
  FilterController({
    required this.homeRepo,
  });
  @override
  void onInit() {
    filter();
  }

  Future<void> filter() async {
    filterModel = Get.arguments["filterData"] as FilterModel;
    try {
      widgetState = WidgetState.loading;
      update(["FilterView"]);
      log("starting filter");
      filteredCars = await homeRepo.filterCars(skip: 0, filter: filterModel);
      widgetState = filteredCars.isEmpty ? WidgetState.empty : WidgetState.done;
      log("filter Done");
    } on ExceptionHandler catch (e) {
      Get.snackbar(
        e.error,
        "",
        duration: const Duration(seconds: 3),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blue,
        colorText: Colors.white,
      );
    }
    update(["FilterView"]);
  }
}
