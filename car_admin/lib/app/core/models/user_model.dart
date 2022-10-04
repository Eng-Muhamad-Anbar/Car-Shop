// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:car_admin/app/core/models/car_model.dart';

class User {
  User(
      {required this.id,
      required this.username,
      required this.fullName,
      required this.city,
      required this.phone,
      required this.cars});
  final String id;
  final String username;
  final String fullName;
  final String city;
  final String phone;
  final List<Car> cars;
  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        fullName: json["full_name"],
        city: json["city"],
        phone: json["phone"],
        cars: json["cars"] == null ? [] : Car.carList(json["cars"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "full_name": fullName,
        "city": city,
        "phone": phone,
        "cars": cars.map((x) => x.toMap()).toList(),
      };

  @override
  String toString() {
    String text = '''
      "id" : $id,
      "username": $username,
      "full_name": $fullName,
      "city": $city,
      "phone": $phone,
      "cars": $cars,
    ''';
    return text;
  }

  User copyWith({
    String? username,
    String? fullName,
    String? city,
    String? phone,
  }) {
    return User(
        id: id,
        username: username ?? this.username,
        fullName: fullName ?? this.fullName,
        city: city ?? this.city,
        phone: phone ?? this.phone,
        cars: cars);
  }
}
