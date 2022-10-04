import 'dart:developer';

import 'package:car_admin/app/modules/auth/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widgets/custom_text_field.dart';
import '../../../core/widgets/state_button.dart';
import '../../../core/widgets/welcome_widget.dart';

class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isChanged = false;
  @override
  Widget build(BuildContext context) {
    log("build");
    return Scaffold(
        appBar: AppBar(
          title: const Text("Login"),
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
                      children: const [
                        Text(
                          "Login",
                          style: TextStyle(
                              fontSize: 35,
                              color: Colors.black,
                              fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomTextField(
                      controller: controller.userNameController,
                      myLabel: "User Name",
                      hint: "Please enter your user name",
                      myValidator: (text) {
                        if (text == null || text.isEmpty) {
                          return "User Name is required";
                        } else if (text.length > 20) {
                          return "User Name must be less than 20 char";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (_) {
                        if (isChanged) {
                          formKey.currentState!.validate();
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                      controller: controller.passwordController,
                      myLabel: "Password",
                      hint: "Please enter your password",
                      myValidator: (text) {
                        if (text == null || text.isEmpty) {
                          return "Password is required";
                        } else if (text.length < 6) {
                          return "Password must be longer than 6 chars";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (_) {
                        if (isChanged) {
                          formKey.currentState!.validate();
                        }
                      },
                      myObscureText: true,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    GetBuilder<LoginController>(
                        id: "ElevatedButton",
                        builder: (_) {
                          log("ElevatedButton");
                          return SizedBox(
                              width: 150,
                              height: 50,
                              child: StateButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      controller.login();
                                    } else {
                                      log("Error from validate");
                                    }
                                  },
                                  isLoading: controller.isLoading,
                                  text: "Login"));
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    GetBuilder<LoginController>(
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
                        const Text("Don't have an account?"),
                        TextButton(
                            onPressed: () {
                              controller.goToRegister();
                            },
                            child: const Text("Register",
                                style: TextStyle(color: Color(0xff185ADB))))
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
