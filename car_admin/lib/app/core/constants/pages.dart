import 'package:car_admin/app/modules/auth/register/register_binding.dart';
import 'package:car_admin/app/modules/auth/register/register_view.dart';
import 'package:car_admin/app/modules/auth/wrapper/wrapper_binding.dart';
import 'package:car_admin/app/modules/auth/wrapper/wrapper_view.dart';
import 'package:car_admin/app/modules/home/add_car/add_car_view.dart';
import 'package:car_admin/app/modules/home/car_details/car_details_binding.dart';
import 'package:car_admin/app/modules/home/car_details/car_details_view.dart';
import 'package:car_admin/app/modules/home/cars/cars-binding.dart';
import 'package:car_admin/app/modules/home/cars/cars_view.dart';
import 'package:car_admin/app/modules/home/profile/profile_binding.dart';
import 'package:car_admin/app/modules/home/profile/profile_view.dart';
import 'package:get/get.dart';

import '../../modules/auth/login/login_binding.dart';
import '../../modules/auth/login/login_view.dart';
import '../../modules/home/add_car/add_car_binding.dart';
import '../../modules/home/filter/filter_binding.dart';
import '../../modules/home/filter/filter_view.dart';

List<GetPage> appPages = [
  GetPage(
      name: "/wrapper",
      page: () => const WrapperView(),
      binding: WrapperBinding()),
  GetPage(
      name: "/register",
      page: () => RegisterView(),
      binding: Registerbinding()),
  GetPage(name: "/login", page: () => LoginView(), binding: LoginBinding()),
  GetPage(name: "/cars", page: () => const CarsView(), binding: CarsBinding()),
  GetPage(
      name: "/carDetails",
      page: () => const CarDetailsView(),
      binding: CarDetailsBinding()),
  GetPage(name: "/addCar", page: () => AddCarView(), binding: AddCarBinding()),
  GetPage(
      name: "/profile", page: () => ProfileView(), binding: ProfileBinding()),
  GetPage(name: "/filter", page: () => FilterView(), binding: FilterBinding())
];
