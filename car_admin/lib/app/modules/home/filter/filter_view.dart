import 'package:car_admin/app/core/widgets/card_of_car.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../cars/cars_controller.dart';
import 'filter_controller.dart';

class FilterView extends GetView<FilterController> {
  const FilterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Filtered Cars"),
          centerTitle: true,
        ),
        body: GetBuilder<FilterController>(
            id: "FilterView",
            builder: (_) {
              switch (controller.widgetState) {
                case WidgetState.loading:
                  return const Center(child: CircularProgressIndicator());

                case WidgetState.error:
                  return Center(
                      child: ElevatedButton(
                          onPressed: controller.filter,
                          child: const Text("Try Again")));

                case WidgetState.empty:
                  return const Center(
                    child: Text("No cars"),
                  );
                default:
                  return ListView.separated(
                      padding: const EdgeInsets.all(20),
                      itemBuilder: (context, index) {
                        return CardOfCar(car: controller.filteredCars[index]);
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 15,
                        );
                      },
                      itemCount: controller.filteredCars.length);
              }
            }));
  }
}
/*ListView.separated(
            itemBuilder: itemBuilder,
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 15,
              );
            },
            itemCount: controller.filteredCars.length)*/ 