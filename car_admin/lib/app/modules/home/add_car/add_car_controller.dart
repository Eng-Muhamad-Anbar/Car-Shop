// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:car_admin/app/core/models/car_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:car_admin/app/core/repo/home_repo.dart';

import '../../../core/services/error_handler.dart';

class AddCarController extends GetxController {
  TextEditingController hexColorController = TextEditingController();
  TextEditingController yomController = TextEditingController();

  DateTime? selectedDate;

  bool isLoading = false;
  Map<String, dynamic> addSendData = {};
  HomeRepo homeRepo;
  AddCarController({
    required this.homeRepo,
  });

  // Determining YOM from DatePicker
  Future<void> selectDate(BuildContext context) async {
    selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000, 0),
        lastDate: DateTime.now().add(const Duration(days: 365)));
    update(["YomBuilder"]);
    if (selectedDate == null) {
      yomController.text = "";
      log(yomController.text);
    } else {
      yomController.text = selectedDate!.year.toString();
      log(yomController.text);
    }
  }

  // Determining one image from imagePicker
  Future<void> addMainImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result != null) {
      PlatformFile file = result.files.first;
      String url = await homeRepo.uploadFile(file: file);
      log("image url : $url");
      addSendData['main_image'] = url;
    }
  }

  // Determining Multiple images from imagePicker
  Future<void> addMultiImages() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: true);
    if (result != null) {
      List<PlatformFile> files = result.files;
      List<String> urls = [];
      for (PlatformFile file in files) {
        String url = await homeRepo.uploadFile(file: file);
        urls.add(url);
      }

      addSendData['other_image'] = urls;
    }
  }

  Future<void> addCar() async {
    try {
      log(addSendData.toString());
      log(hexColorController.text);
      isLoading = true;
      update(['add-car-loading']);

      Car addedCar = await homeRepo.addCar(
          carBrand: addSendData['brand'],
          carModel: addSendData['model'],
          carYOM: yomController.text,
          carPrice: addSendData['price'],
          carCategory: addSendData['category'],
          carDescription: addSendData['description'],
          carColor: hexColorController.text,
          carMainImage: addSendData['main_image'],
          carImages: addSendData['other_image']);
      log(addedCar.toString());
      isLoading = false;
      update(['add-car-loading']);
    } on ExceptionHandler catch (e) {
      print("Error is $e");
      isLoading = false;
      update(['add-car-loading']);
    }
  }
}
