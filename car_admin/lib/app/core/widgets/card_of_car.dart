import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_admin/app/core/models/car_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardOfCar extends StatelessWidget {
  CardOfCar({Key? key, required this.car}) : super(key: key);
  Car car;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed("/carDetails", arguments: {"car": car});
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: double.infinity,
          height: 150,
          color: const Color(0xffefefef),
          child: Row(
            children: [
              SizedBox(
                width: 150,
                height: 150,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedNetworkImage(
                      imageUrl: car.mainImage,
                      fit: BoxFit.fill,
                      placeholder: (context, url) => const SizedBox(
                          width: 20,
                          height: 20,
                          child: Center(child: CircularProgressIndicator())),
                      errorWidget: (context, url, error) =>
                          const Center(child: Icon(Icons.error)),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        car.model,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      Text(
                        car.brand,
                        style: const TextStyle(fontSize: 17),
                      )
                    ],
                  ),
                  const SizedBox(height: 7),
                  Text(car.description),
                  const SizedBox(height: 7),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        car.price,
                        style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      Text(
                        car.yom,
                        style: TextStyle(fontSize: 17),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
