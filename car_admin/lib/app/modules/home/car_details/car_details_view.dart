import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'car_details_controller.dart';

class CarDetailsView extends GetView<CarDetailsController> {
  const CarDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: GetBuilder<CarDetailsController>(
            id: "CarButtonState",
            builder: (_) {
              switch (controller.carButtonState) {
                case CarButtonState.add:
                  return ElevatedButton(
                      onPressed: () {
                        controller.addToCart();
                      },
                      child: const Text("Add To Cart"));

                case CarButtonState.willRemove:
                  return ElevatedButton(
                      onPressed: () {
                        controller.removeFromCart();
                      },
                      child: const Text("Remove From Cart"));
                case CarButtonState.loading:
                  return const ElevatedButton(
                      onPressed: null, child: CircularProgressIndicator());
              }
            }),
        body: ListView(
          children: [_carImages(), _designSmoothPageIndicator(), _carInfo()],
        ));
  }

  Widget _carImages() {
    return Stack(children: [
      SizedBox(
        height: 300,
        child: PageView(
          controller: controller.pageController,
          children: controller.car.carImages
              .map((imgItem) => Stack(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: CachedNetworkImage(
                          fit: BoxFit.fill,
                          imageUrl: imgItem,
                          placeholder: (context, url) => const SizedBox(
                              height: 20,
                              width: 20,
                              child:
                                  Center(child: CircularProgressIndicator())),
                          errorWidget: (context, url, error) =>
                              const Center(child: Icon(Icons.error)),
                        ),
                      ),
                      Container(
                        height: 300,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Colors.black87, Colors.transparent],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter)),
                      ),
                    ],
                  ))
              .toList(),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(
          left: 20,
          top: 30,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                Get.back();
              },
              child: const Icon(
                Icons.arrow_back_ios_outlined,
                color: Colors.white,
              ),
            ),
            const Text(
              "Car Details",
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
            const SizedBox(
              width: 25,
            )
          ],
        ),
      )
    ]);
  }

  Widget _designSmoothPageIndicator() {
    return Center(
      child: SmoothPageIndicator(
          controller: controller.pageController, // PageController
          count: controller.car.carImages.length,
          effect: const SlideEffect(
              dotHeight: 8, dotWidth: 8), // your preferred effect
          onDotClicked: (index) {
            controller.pageController.animateToPage(index,
                duration: const Duration(milliseconds: 500),
                curve: Curves.ease);
          }),
    );
  }

  Widget _carInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                controller.car.model,
                style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
              Text(
                controller.car.price,
                style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                controller.car.brand,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              Text(
                controller.car.category,
                style: const TextStyle(
                  fontSize: 18,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            children: [
              const Text(
                "Year Of Manufacture   ",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
              Text(
                controller.car.yom,
                style: const TextStyle(
                  fontSize: 18,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            children: [
              const Text(
                "Color  ",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
              Text(
                controller.car.color,
                style: const TextStyle(
                  fontSize: 18,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          const Text(
            "Description  ",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            controller.car.description,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}