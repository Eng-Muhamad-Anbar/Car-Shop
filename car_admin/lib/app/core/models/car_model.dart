import 'dart:developer';

String img =
    'https://cdn.pixabay.com/photo/2018/07/12/16/05/bmw-3533813__340.jpg';

class Car {
  final String id;
  final String brand;
  final String model;
  final String yom;
  final String color;
  final String price;
  final String category;
  final String description;
  final String mainImage;
  final List<String> carImages;
  Car(
      {required this.id,
      required this.brand,
      required this.model,
      required this.yom,
      required this.color,
      required this.price,
      required this.category,
      required this.description,
      required this.mainImage,
      required this.carImages});
  factory Car.fromMap(dynamic json) => Car(
      id: json["id"] ?? "",
      brand: json["brand"],
      model: json["model"],
      yom: json["yom"],
      color: json["color"],
      price: json["price"],
      category: json["category"],
      description: json["description"],
      mainImage: json["image"] /*img*/,
      carImages: json["images"] == null
          ? []
          : List<String>.from(json["images"].map((img) =>
              img.toString()))); /*json["carImages"] ?? [img, img, img, img]);*/
/*String img =
    'https://cdn.pixabay.com/photo/2018/07/12/16/05/bmw-3533813__340.jpg';*/
  Map<String, dynamic> toMap() => {
        "brand": brand,
        "model": model,
        "yom": yom,
        "color": color,
        "price": price,
        "category": category,
        "description": description,
        "image": mainImage,
        "id": id
      };
  static List<Car> carList(List<dynamic> data) {
    return data.map((car) => Car.fromMap(car)).toList();
  }
}
