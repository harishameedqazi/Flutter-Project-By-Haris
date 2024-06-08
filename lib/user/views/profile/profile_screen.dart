import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hostel_mangement/res/components/profile_component.dart';
import 'package:hostel_mangement/user/views/auth/login_screen.dart';
import 'package:hostel_mangement/user/views/profile/change_pass.dart';
import 'package:hostel_mangement/user/views/profile/edit_screen.dart';
import 'package:hostel_mangement/user/views_models/profile/profile_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final ProfileModel profileModel = Get.put(ProfileModel());
    profileModel.getUserImageandName();
    return Scaffold(
      appBar: AppBar(
          // actions: [
          //   Container(
          //     decoration: BoxDecoration(
          //         color: AppColors.white.withOpacity(.3),
          //         border: Border.all(color: Colors.black.withOpacity(0.1)),
          //         borderRadius: BorderRadius.circular(10)),
          //     child: IconButton(
          //       onPressed: () {},
          //       icon: Icon(
          //         Icons.notifications_none,
          //         color: AppColors.green,
          //       ),
          //     ),
          //   ),
          //   const SizedBox(
          //     width: 10,
          //   ),
          // ],
          ),
      body: Column(
        children: [
//  profile image
          InkWell(
            onTap: () async {
              print(profileModel.name1.value);
            },
            child: Obx(
              () => Stack(
                children: [
                  profileModel.imageUrls.value.isNotEmpty
                      ? CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: size.width * .2,
                          backgroundImage:
                              NetworkImage(profileModel.imageUrls.value),
                        )
                      : CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: size.width * .2,
                          backgroundImage: const NetworkImage(
                              'https://static-00.iconduck.com/assets.00/profile-circle-icon-2048x2048-cqe5466q.png'),
                        ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            profileModel.name1.value,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          //  edit profile
          ProfileComponent(
              onTap: () {
                Get.to(() => const EditScreen());
              },
              icon: Icons.person,
              title: 'Edit Profile'),
          ProfileComponent(
              onTap: () {
                Get.to(ChangePasswordScreen());
              },
              icon: Icons.person,
              title: 'Change Password'),

          ProfileComponent(
              onTap: () {
                Get.offAll(() => const LoginScreen());
              },
              icon: Icons.logout,
              title: 'Logout'),
        ],
      ),
    );
  }
}
