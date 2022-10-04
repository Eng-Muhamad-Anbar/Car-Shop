import 'dart:developer';

import 'package:car_admin/app/core/widgets/custom_text_field.dart';
import 'package:car_admin/app/core/widgets/state_button.dart';
import 'package:car_admin/app/core/widgets/welcome_widget.dart';
import 'package:car_admin/app/modules/auth/register/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterView extends GetView<RegisterController> {
  RegisterView({Key? key}) : super(key: key);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isChanged = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
      ),
      body: ListView(
        children: [
          const WelcomeWidget(),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: Column(
                children: [
                  Row(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Text(
                        "SignUp",
                        style: TextStyle(
                            fontSize: 35,
                            color: Colors.black,
                            fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  CustomTextField(
                    myValidator: (text) {
                      if (text == null || text.isEmpty) {
                        return "Full name is required";
                      } else if (text.length > 20) {
                        return "Fullname must be less than 20 char";
                      } else {
                        return null;
                      }
                    },
                    controller: controller.fullNameController,
                    myLabel: "Full Name",
                    hint: "Please enter your full name",
                    onChanged: (_) {
                      if (isChanged == true) {
                        formKey.currentState!.validate();
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
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
                    onChanged: (_) {
                      if (isChanged == true) {
                        formKey.currentState!.validate();
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
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
                      hint: "Please enter your password",
                      myObscureText: true,
                      onChanged: (_) {
                        if (isChanged == true) {
                          formKey.currentState!.validate();
                        }
                      }),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
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
                      onChanged: (_) {
                        if (isChanged == true) {
                          formKey.currentState!.validate();
                        }
                      }),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
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
                      onChanged: (_) {
                        if (isChanged == true) {
                          formKey.currentState!.validate();
                        }
                      }),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                      width: 150,
                      height: 50,
                      child: GetBuilder<RegisterController>(
                          id: "RegisterButton",
                          builder: (_) {
                            return StateButton(
                                onPressed: () {
                                  isChanged = true;
                                  if (formKey.currentState!.validate()) {
                                    controller.register();
                                  } else {
                                    log("Error from validate");
                                  }
                                },
                                isLoading: controller.isLoading,
                                text: "SignUp");
                          })),
                  GetBuilder<RegisterController>(
                      id: "TextError",
                      builder: (_) {
                        log("Text");
                        return Text(
                          controller.error ?? "",
                          style: const TextStyle(
                              color: Color.fromARGB(255, 228, 4, 4)),
                        );
                      }),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account?"),
                      TextButton(
                          onPressed: controller.goToLogin,
                          child: const Text("login",
                              style: TextStyle(color: Color(0xff185ADB))))
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
