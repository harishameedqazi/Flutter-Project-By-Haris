import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hostel_mangement/main.dart';
import 'package:hostel_mangement/res/colors.dart';
import 'package:hostel_mangement/res/components/edit_screen_components.dart';
import 'package:hostel_mangement/res/widgets/button.dart';
import 'package:hostel_mangement/user/views_models/auth/auth_model.dart';

import 'signup_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthModel authModel = Get.put(AuthModel());
    size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: AppColors.white,
        body: Stack(
          children: [
            Container(
              height: size.height * .3,
              width: double.infinity,
              decoration: const BoxDecoration(gradient: AppColors.gradient),
              child: const Padding(
                padding: EdgeInsets.only(top: 60.0, left: 22),
                child: Text(
                  'Hello\nSign in!',
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 200.0),
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.only(
                    top: 20.0,
                  ),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40)),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18.0, right: 18),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        EditScreenComponent(
                            controller: authModel.emailController,
                            title: 'Email ',
                            hintText: 'Email',
                            icon: Icons.email),
                        const SizedBox(
                          height: 10,
                        ),
                        Obx(
                          () => EditScreenComponent(
                            obscureText: authModel.obscureText.value,
                            controller: authModel.pasController,
                            title: 'Password ',
                            hintText: 'Password',
                            icon: Icons.email,
                            suffixIcon: IconButton(
                              onPressed: () {
                                authModel.obscureText.value =
                                    !authModel.obscureText.value;
                              },
                              icon: authModel.obscureText.value
                                  ? const Icon(
                                      Icons.visibility_off,
                                      color: Colors.grey,
                                    )
                                  : const Icon(
                                      Icons.visibility,
                                      color: Colors.grey,
                                    ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Color(0xff281537),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 70,
                        ),
                        Obx(
                          () => Button(
                            isLoading: authModel.isLoading.value,
                            ontap: () {
                              authModel.signIn(
                                email: authModel.emailController.text,
                                pass: authModel.pasController.text,
                              );
                            },
                            text: 'Sign In',
                            width: 500,
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Divider(
                                color: Colors.black,
                                height: 1.0,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                'OR',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: Colors.black,
                                height: 1.0,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                "Don't have account?",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(() => const SignUpScreen());
                                  authModel.emailController.clear();
                                  authModel.pasController.clear();
                                  authModel.obscureText.value = true;
                                },
                                child: const Text(
                                  "Sign up",
                                  style: TextStyle(

                                      ///done login page
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                      color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
