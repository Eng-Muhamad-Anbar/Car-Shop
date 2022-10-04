import 'dart:developer';

import 'package:car_admin/app/core/constants/categories.dart';
import 'package:car_admin/app/core/widgets/card_of_car.dart';
import 'package:car_admin/app/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'cars_controller.dart';

class CarsView extends GetView<CarsController> {
  const CarsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed("/addCar"),
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text(
          "Cars",
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              showBottomSheet(context);
            },
            icon: const Icon(
              Icons.filter_alt,
              color: Colors.white,
            )),
        actions: [
          IconButton(
              onPressed: () => Get.toNamed("/profile"),
              icon: const Icon(
                Icons.person,
                color: Colors.white,
              ))
        ],
      ),
      body: _carsWidget(context),
    );
  }

  Widget _carsWidget(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      child: GetBuilder<CarsController>(
          id: "carsGetBuilder",
          builder: (_) {
            switch (controller.widgetState) {
              case WidgetState.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case WidgetState.error:
                return Center(
                  child: ElevatedButton(
                      onPressed: controller.getCars,
                      child: const Text("Try Again")),
                );
              case WidgetState.empty:
                return const Center(
                  child: Text("No Cars"),
                );
              default:
                return SizedBox(
                  height: MediaQuery.of(context).size.height - 233,
                  child: NotificationListener(
                    onNotification: (t) {
                      //log("Pixels: ${controller.scrollController.position.pixels}");
                      if (t is ScrollEndNotification) {
                        if (controller.scrollController.position.pixels ==
                            controller
                                .scrollController.position.maxScrollExtent) {
                          log("maxScrollExtent");
                          controller.carsPagination();
                        }
                      }
                      return true;
                    },
                    child: ListView.separated(
                      controller: controller.scrollController,
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 15,
                        );
                      },
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      itemCount: controller.cars.length + 1,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                        log(index.toString());
                        if (index == controller.cars.length) {
                          if (controller.widgetState ==
                              WidgetState.loadingMore) {
                            return const Center(
                              child: SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: CircularProgressIndicator()),
                            );
                          } else {
                            return const Center(
                                child: SizedBox(
                              height: 30,
                              width: 30,
                            ));
                          }
                        } else {
                          return CardOfCar(
                            car: controller.cars[index],
                          );
                        }
                      },
                    ),
                  ),
                );
            }
          }),
    );
  }

  void showBottomSheet(BuildContext context) {
    Get.bottomSheet(
        Container(
          padding: const EdgeInsets.all(20),
          color: Colors.white,
          height: MediaQuery.of(context).size.height * 0.6,
          width: double.infinity,
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: CustomTextField(
                      onChanged: (text) => null,
                      myLabel: "Brand",
                      hint: "Brand",
                      controller: controller.brandController,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: InkWell(
                      onTap: () {
                        controller.selectDate(context);
                      },
                      child: GetBuilder<CarsController>(
                          id: "YomBuilder",
                          builder: (_) {
                            return CustomTextField(
                              disabled: true,
                              controller: TextEditingController(
                                text: controller.selectedDate == null
                                    ? null
                                    : controller.selectedDate!.year.toString(),
                              ),
                              hint: "Yom",
                              onChanged: (text) {},
                              myLabel: "YearOfManufacture",
                            );
                          }),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                onChanged: (text) => null,
                myLabel: "Model",
                hint: "Model",
                controller: controller.modelController,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Price",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              GetBuilder<CarsController>(
                  id: "filterSlider",
                  builder: (_) {
                    return RangeSlider(
                      values: controller.priceRangeValues,
                      onChanged: (value) {
                        controller.changePriceSlider(value);
                      },
                      min: 1000,
                      max: 100000,
                      divisions: 50,
                      labels: RangeLabels(
                          controller.priceRangeValues.start.toString(),
                          controller.priceRangeValues.end.toString()),
                    );
                  }),
              const SizedBox(height: 10),
              const Text(
                "Category",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 200,
                child: GetBuilder<CarsController>(
                    id: "FilterCategory",
                    builder: (_) {
                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 2.5,
                                crossAxisCount: 3,
                                mainAxisSpacing: 20,
                                crossAxisSpacing: 20),
                        itemBuilder: (_, index) => ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: controller.isCategorySelected(index)
                                    ? Colors.blue
                                    : Colors.grey),
                            onPressed: () {
                              controller.selectFilterCategory(index);
                            },
                            child: Text(categories[index])),
                        itemCount: categories.length,
                      );
                    }),
              ),
              ElevatedButton(
                  onPressed: () {
                    controller.goToFilter();
                  },
                  child: const Text("Filter"))
            ],
          ),
        ),
        isScrollControlled: true,
        enableDrag: true);
  }
}
