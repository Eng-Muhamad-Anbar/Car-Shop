import 'dart:developer';

import 'package:car_admin/app/core/widgets/custom_text_field.dart';
import 'package:car_admin/app/modules/home/profile/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widgets/state_button.dart';
import '../cars/cars_controller.dart';

class ProfileView extends GetView<ProfileController> {
  ProfileView({Key? key}) : super(key: key);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isChanged = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: GetBuilder<ProfileController>(
          id: "ProfileView",
          builder: (context) {
            switch (controller.widgetState) {
              case WidgetState.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );

              case WidgetState.error:
                return Center(
                  child: ElevatedButton(
                      onPressed: controller.getUserById,
                      child: const Text("Try Again")),
                );

              default:
                return Form(
                  key: formKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: ListView(
                    padding: const EdgeInsets.all(20),
                    children: [
                      CustomTextField(
                          controller: controller.fullNameController,
                          showBorder: true,
                          myValidator: (text) {
                            if (text == null || text.isEmpty) {
                              return "Full name is required";
                            } else if (text.length > 20) {
                              return "Fullname must be less than 20 char";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (text) {},
                          myLabel: "Full Name",
                          hint: "full name"),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextField(
                          showBorder: true,
                          myValidator: (text) {
                            if (text == null || text.isEmpty) {
                              return "User Name is required";
                            } else if (text.length > 20) {
                              return "User Name must be less than 20 char";
                            } else {
                              return null;
                            }
                          },
                          controller: controller.userNameController,
                          myLabel: "User Name",
                          hint: "Please enter your user name",
                          onChanged: (_) {}),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextField(
                          showBorder: true,
                          myValidator: (text) {
                            if (text == null || text.isEmpty) {
                              return "Password is required";
                            } else if (text.length < 6) {
                              return "Password must be longer than 6 chars";
                            } else {
                              return null;
                            }
                          },
                          controller: controller.passwordController,
                          myLabel: "Password",
                          hint: "Please enter a new password",
                          myObscureText: true,
                          onChanged: (_) {}),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextField(
                          showBorder: true,
                          textInputType: TextInputType.phone,
                          myValidator: (text) {
                            if (text == null || text.isEmpty) {
                              return "Phone Number is required";
                            } else {
                              return null;
                            }
                          },
                          controller: controller.phoneNumberController,
                          myLabel: "Phone Number",
                          hint: "Please enter your phone Number",
                          onChanged: (_) {}),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextField(
                          showBorder: true,
                          myValidator: (text) {
                            {
                              if (text == null || text.isEmpty) {
                                return "City is required";
                              } else {
                                return null;
                              }
                            }
                          },
                          controller: controller.cityController,
                          myLabel: "City",
                          hint: "Please enter your city",
                          onChanged: (_) {}),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                          width: 150,
                          height: 50,
                          child: GetBuilder<ProfileController>(
                              id: "updateUserInfo",
                              builder: (_) {
                                return StateButton(
                                    onPressed: () {
                                      isChanged = true;
                                      if (formKey.currentState!.validate()) {
                                        controller.updateUserInfo();
                                      } else {
                                        log("Error from validate");
                                      }
                                    },
                                    isLoading: controller.widgetState ==
                                        WidgetState.loading,
                                    text: "Update Info");
                              })),
                      const SizedBox(
                        height: 20,
                      ),
                      GetBuilder<ProfileController>(
                          id: "Logout",
                          builder: (_) {
                            return StateButton(
                                onPressed: () {
                                  controller.logout();
                                },
                                isLoading: controller.widgetState ==
                                    WidgetState.loading,
                                text: "Logout");
                          }),
                    ],
                  ),
                );
            }
          }),
    );
  }
}
