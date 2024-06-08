import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hostel_mangement/main.dart';
import 'package:hostel_mangement/res/colors.dart';
import 'package:hostel_mangement/res/components/edit_screen_components.dart';
import 'package:hostel_mangement/res/widgets/button.dart';
import 'package:hostel_mangement/res/widgets/utils.dart';
import 'package:hostel_mangement/user/views/auth/login_screen.dart';
import 'package:hostel_mangement/user/views_models/auth/auth_model.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    AuthModel authModel = Get.put(AuthModel());

    return Scaffold(
        backgroundColor: AppColors.white,
        body: Stack(
          children: [
            Container(
              height: size.height * .3,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color(0xffB81736),
                  Color(0xff281537),
                ]),
              ),
              child: const Padding(
                padding: EdgeInsets.only(top: 60.0, left: 22),
                child: Text(
                  'Create Your\nAccount',
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
                            controller: authModel.nameController,
                            title: 'Name ',
                            hintText: 'Name',
                            icon: Icons.person),
                        const SizedBox(
                          height: 10,
                        ),
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
                            icon: Icons.lock,
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
                        Obx(
                          () => EditScreenComponent(
                            obscureText: authModel.obscureText1.value,
                            controller: authModel.conformPassController,
                            title: 'Confirm Password ',
                            hintText: 'Confirm Password',
                            icon: Icons.lock,
                            suffixIcon: IconButton(
                              onPressed: () {
                                authModel.obscureText1.value =
                                    !authModel.obscureText1.value;
                              },
                              icon: authModel.obscureText1.value
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
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Room Category',
                                style: TextStyle(
                                  color: AppColors.bluegrey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: 100,
                                child: Obx(
                                  () => DropdownButton<String>(
                                    isExpanded: true,
                                    hint: const Text('User Type'),
                                    onChanged: (newValue) {
                                      authModel
                                          .setSelected(newValue.toString());
                                    },
                                    value: authModel.userType.value,
                                    items: authModel.usercategory
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              )
                            ]),
                        const SizedBox(
                          height: 10,
                        ),
                        Obx(
                          () => Button(
                            ontap: () {
                              // if (authModel.pasController.text.isNotEmpty &&
                              //     authModel
                              //         .conformPassController.text.isNotEmpty &&
                              //     authModel.emailController.text.isNotEmpty &&
                              //     authModel.nameController.text.isNotEmpty) {
                              if (authModel.pasController.text !=
                                  authModel.conformPassController.text) {
                                // Show a message indicating that the password and confirm password do not match
                                Utils.flutterToast(
                                    'Password and Confirm Password do not match');
                              } else {
                                // Passwords match, proceed with sign up
                                authModel.signUp(
                                  email: authModel.emailController.text,
                                  password: authModel.pasController.text,
                                );
                                // authModel.conformPassController.clear();
                                // authModel.emailController.clear();
                                // authModel.pasController.clear();
                                // authModel.nameController.clear();
                                // authModel.obscureText.value = true;
                              }
                              // } else {
                              //   Utils.flutterToast(
                              //       'Please fill all the fields');
                              // }
                            },
                            text: 'Sign Up',
                            isLoading: authModel.isLoading.value,
                            width: 500,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
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
                                "Already have an Account?",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(() => const LoginScreen());
                                  authModel.conformPassController.clear();
                                  authModel.emailController.clear();
                                  authModel.pasController.clear();
                                  authModel.nameController.clear();
                                  authModel.obscureText.value = true;
                                },
                                child: const Text(
                                  "Sign In",
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
