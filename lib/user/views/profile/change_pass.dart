import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hostel_mangement/res/colors.dart';
import 'package:hostel_mangement/res/components/edit_screen_components.dart';
import 'package:hostel_mangement/res/widgets/button.dart';
import 'package:hostel_mangement/user/views_models/profile/profile_model.dart';

class ChangePasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final ProfileModel controller = Get.put(ProfileModel());
    final profileModel = Get.find<ProfileModel>();

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Container(
            width: 120,
            height: 100,
            decoration: BoxDecoration(
                color: AppColors.white.withOpacity(.3),
                border: Border.all(color: Colors.black.withOpacity(0.1)),
                borderRadius: BorderRadius.circular(10)),
            child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back,
                color: AppColors.green,
              ),
            ),
          ),
        ),
        centerTitle: true,
        title: Text('Change Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EditScreenComponent(
                controller: profileModel.newPasswordController,
                title: 'New Password ',
                hintText: '******',
                icon: Icons.lock),
            EditScreenComponent(
                controller: profileModel.confirmPasswordController,
                title: 'Confirm Password ',
                hintText: '******',
                icon: Icons.lock),

            //  Apply button
            const SizedBox(
              height: 50,
            ),
            Button(
              ontap: () {
                profileModel.updatePassword();
              },
              text: 'Apply',
            )
          ],
        ),
      ),
    );
  }
}
