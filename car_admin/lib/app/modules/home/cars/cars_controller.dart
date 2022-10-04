import 'dart:developer';

import 'package:car_admin/app/core/constants/categories.dart';
import 'package:car_admin/app/core/models/filter_model.dart';
import 'package:car_admin/app/core/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/models/car_model.dart';
import '../../../core/repo/home_repo.dart';
import '../../../core/services/error_handler.dart';

class CarsController extends GetxController {
  ScrollController scrollController = ScrollController();
  TextEditingController brandController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  WidgetState widgetState = WidgetState.loading;
  int skip = 0;
  HomeRepo homeRepo;
  List<Car> cars = [];
  late User user;
  RangeValues priceRangeValues = const RangeValues(10000, 50000);
  DateTime? selectedDate;
  List<String> selectedCategories = [];
  CarsController({
    required this.homeRepo,
  });
  Future<void> getCars([bool isLoadingMore = false]) async {
    try {
      if (isLoadingMore) {
        widgetState = WidgetState.loadingMore;
      } else {
        widgetState = WidgetState.loading;
        skip = 0;
        cars.clear();
      }

      update(["carsGetBuilder"]);

      List<Car> tempCars = await homeRepo.getCars(
        skip: skip,
      );
      cars.addAll(tempCars);
      if (tempCars.isEmpty) {
        widgetState = WidgetState.noMoreData;
        Get.snackbar(
          "No More Data",
          "",
          duration: const Duration(seconds: 3),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.blue,
          colorText: Colors.white,
        );
      } else {
        cars.isEmpty
            ? widgetState = WidgetState.empty
            : widgetState = WidgetState.done;
      }
      skip++;
    } on ExceptionHandler catch (e) {
      if (isLoadingMore) {
        widgetState = WidgetState.done;
      } else {
        widgetState = WidgetState.error;
      }
      Get.snackbar(
        e.error,
        "",
        duration: const Duration(seconds: 3),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blue,
        colorText: Colors.white,
      );
    }
    update(["carsGetBuilder"]);
  }

  void carsPagination() {
    if (widgetState != WidgetState.loadingMore &&
        widgetState != WidgetState.noMoreData) {
      getCars(true);
    }
  }

  void changePriceSlider(RangeValues value) {
    priceRangeValues = value;
    update(["filterSlider"]);
  }

  void goToFilter() {
    FilterModel filterModel = FilterModel(
      carBrand: brandController.text,
      carModel: modelController.text,
      carStartPrice: priceRangeValues.start.toString(),
      carEndPrice: priceRangeValues.end.toString(),
      carCategories: selectedCategories,
      carYOM: selectedDate == null ? null : selectedDate!.year.toString(),
    );
    log(filterModel.toString());
    Get.back();
    Get.toNamed("/filter", arguments: {"filterData": filterModel});
    resetFilter();
  }

  Future<void> selectDate(BuildContext context) async {
    selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000, 0),
        lastDate: DateTime.now().add(const Duration(days: 365)));
    update(["YomBuilder"]);
  }

  void selectFilterCategory(int index) {
    bool isSelected = isCategorySelected(index);
    if (isSelected == true) {
      selectedCategories.remove(categories[index]);
    } else {
      selectedCategories.add(categories[index]);
    }

    update(["FilterCategory"]);
  }

  bool isCategorySelected(int index) {
    return selectedCategories.contains(categories[index]);
  }

  void resetFilter() {
    brandController = TextEditingController();
    selectedDate = null;
    modelController = TextEditingController();
    selectedCategories.clear();
    priceRangeValues = const RangeValues(10000, 50000);
  }

  @override
  void onInit() {
    getCars();
    super.onInit();
  }
}

enum WidgetState { loading, error, empty, done, loadingMore, noMoreData }
