import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hostel_mangement/res/colors.dart';
import 'package:hostel_mangement/res/components/edit_screen_components.dart';
import 'package:hostel_mangement/res/widgets/button.dart';
import 'package:hostel_mangement/user/views_models/profile/profile_model.dart';

class EditScreen extends StatelessWidget {
  const EditScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
        title: const Text('Edit '),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: StreamBuilder<DocumentSnapshot>(
          stream: profileModel.fetchUserDetails(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || !snapshot.data!.exists) {
              return const Center(child: Text('User not found'));
            }

            var userData = snapshot.data!.data() as Map<String, dynamic>;
            var name = userData['name'];
            var imageUrl = userData['imageUrl'];

            var pass = userData['password'];

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Circular profile image
                        profileModel.selectedImage.value != null
                            ? CircleAvatar(
                                radius: 70.0,
                                backgroundImage: FileImage(
                                    profileModel.selectedImage.value!),
                              )
                            : CircleAvatar(
                                radius: 70.0,
                                backgroundImage: NetworkImage('$imageUrl'),
                              ),

                        // Edit icon overlay
                        Positioned(
                          bottom: 0,
                          right: 10,
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.bluegrey,
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.edit,
                                size: 18,
                                color: Colors.white,
                              ),
                              onPressed: () async {
                                await profileModel.pickImage();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Display user name
                  EditScreenComponent(
                    controller: profileModel.nameController,
                    title: 'Username',
                    hintText: name,
                    icon: Icons.person,
                  ),

                  // Apply button
                  const SizedBox(height: 50),
                  Button(
                    ontap: () async {
                      await profileModel.updateImageAndName(
                        profileModel.selectedImage.value??imageUrl,
                        profileModel.nameController.text,
                      );
                    },
                    text: 'Apply',
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
