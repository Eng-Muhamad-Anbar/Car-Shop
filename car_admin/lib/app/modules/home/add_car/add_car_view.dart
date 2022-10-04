import 'dart:developer';

import 'package:car_admin/app/core/widgets/category_dropdown.dart';
import 'package:car_admin/app/core/widgets/description_text_field.dart';
import 'package:car_admin/app/core/widgets/state_button.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../core/widgets/custom_text_field.dart';
import 'add_car_controller.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class AddCarView extends GetView<AddCarController> {
  AddCarView({Key? key}) : super(key: key);

  static String selectedColor = "";

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void chooseColor(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ColorPicker(
                  //hexInputBar: true,
                  hexInputController: controller.hexColorController,
                  pickerColor: Colors.blueAccent,
                  onColorChanged: (_) {}),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Apply Color",
                    style: TextStyle(color: Colors.blue),
                  ))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: GetBuilder<AddCarController>(
          id: 'add-car-loading',
          builder: (_) => StateButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  if (controller.hexColorController.text.isEmpty) {
                    Get.snackbar('color is required.', "",
                        duration: const Duration(seconds: 3),
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.blue,
                        colorText: Colors.white,
                        titleText: const Text(
                          "color is required.",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ));
                    return;
                  }
                  if (controller.addSendData['main_image'] == null) {
                    Get.snackbar('main image is required.', "",
                        duration: const Duration(seconds: 3),
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.blue,
                        colorText: Colors.white,
                        titleText: const Text(
                          "main image is required.",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ));
                    return;
                  }
                  if (controller.addSendData['other_image'] == null) {
                    Get.snackbar('Other images are required.', "",
                        duration: const Duration(seconds: 3),
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.blue,
                        colorText: Colors.white,
                        titleText: const Text(
                          "Other images are required.",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ));
                    return;
                  }

                  controller.addCar();
                }
              },
              isLoading: controller.isLoading,
              text: "Add Car"),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        appBar: AppBar(
          leading: IconButton(
              onPressed: (() => Get.back()),
              icon: const Icon(Icons.arrow_back_ios_outlined,
                  color: Colors.white)),
          title: const Text(
            "Add Car",
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.disabled,
            child: ListView(children: [
              CustomTextField(
                  myValidator: (value) {
                    if (value == null || value.isEmpty) {
                      return "this field is required .";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    controller.addSendData['brand'] = value;
                  },
                  myLabel: "Car Brand",
                  hint: "car brand"),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: CustomTextField(
                        myValidator: (value) {
                          if (value == null || value.isEmpty) {
                            return "this field is required .";
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) =>
                            controller.addSendData['model'] = value,
                        myLabel: "Car Model",
                        hint: "car model"),
                  ),
                  const Expanded(child: SizedBox()),
                  Expanded(
                    flex: 6,
                    child: InkWell(
                      onTap: () {
                        controller.selectDate(context);
                      },
                      child: GetBuilder<AddCarController>(
                        id: "YomBuilder",
                        builder: (_) {
                          log(controller.yomController.text);
                          return CustomTextField(
                              myValidator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "this field is required .";
                                } else {
                                  return null;
                                }
                              },
                              disabled: true,
                              controller: controller.yomController,
                              onChanged: (value) {},
                              myLabel: "Year Of Manufacture",
                              hint: "YOM");
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: CustomTextField(
                        myValidator: (value) {
                          if (value == null || value.isEmpty) {
                            return "this field is required .";
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) =>
                            controller.addSendData['price'] = value,
                        myLabel: "Car Price",
                        hint: "car price"),
                  ),
                  const Expanded(child: SizedBox()),
                  Expanded(
                    flex: 6,
                    child: CategoryDropdown(
                      myValidator: (value) {
                        if (value == null || value.isEmpty) {
                          return "this field is required .";
                        } else {
                          return null;
                        }
                      },
                      myLabel: "Car Category",
                      hint: "car category",
                      onChanged: (value) =>
                          controller.addSendData['category'] = value,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              DescriptionTextField(
                  myValidator: (value) {
                    if (value == null || value.isEmpty) {
                      return "this field is required .";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) =>
                      controller.addSendData['description'] = value,
                  myLabel: "Description",
                  hint: "Description"),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Container(
                      height: 60,
                      child: ElevatedButton(
                          onPressed: () {
                            chooseColor(context);
                          },
                          child: const Text("Choose Color")),
                    ),
                  ),
                  Expanded(child: SizedBox()),
                  Expanded(
                    flex: 5,
                    child: Container(
                      height: 60,
                      child: ElevatedButton(
                          onPressed: controller.addMainImage,
                          child: const Text("Add Main Image")),
                    ),
                  ),
                  Expanded(child: SizedBox()),
                  Expanded(
                    flex: 5,
                    child: Container(
                      height: 60,
                      child: ElevatedButton(
                          onPressed: controller.addMultiImages,
                          child: const Text("Add Other Images")),
                    ),
                  ),
                ],
              )
            ]),
          ),
        ));
  }
}
