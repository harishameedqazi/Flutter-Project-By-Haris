import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hostel_mangement/res/const/firebase_const.dart';
import 'package:hostel_mangement/res/widgets/utils.dart';
import 'package:hostel_mangement/services/firebase/account_service.dart';
import 'package:image_picker/image_picker.dart';

class ProfileModel extends GetxController {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  AccountServices accountServices = AccountServices();
  var isLoading = false.obs;
  var imagePath = ''.obs;
  var imageUrls = ''.obs;
  var name1 = ''.obs;
  Rx<File?> selectedImage = Rx<File?>(null);

  Future<void> getUserImageandName() async {
    try {
      isLoading.value = true;

      // Use the AccountServices to get user details
      Map<String, dynamic> userDetails = await accountServices.getUserDetails();

      // Extracting user image and name from userDetails
      imageUrls.value = userDetails['imageUrl'] ?? '';
      name1.value = userDetails['name'] ?? '';
    } catch (error) {
      Utils.flutterToast(error.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> fetchUserDetails() {
    var currentUser = auth.currentUser;
    return firestore
        .collection(usersCollection)
        .doc(currentUser?.uid)
        .snapshots();
  }

  Future<void> updateImageAndName(String imageUrl, String name) async {
    try {
      await accountServices.updateImageAndName(imageUrl, name).then((value) {
        print(name);

        Utils.sucessToast('Profile Updated Successfully');
      });
      nameController.clear();
    } catch (e) {
      Utils.flutterToast(e.toString());
    }
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      selectedImage.value = File(pickedImage.path);
    }
  }

  Future<void> updatePassword() async {
    try {
   
        if (newPasswordController.text == confirmPasswordController.text) {
          await accountServices
              .updatePassword(confirmPasswordController.text)
              .then((value) {
            print(confirmPasswordController.text);

            Utils.sucessToast('Passowrd Updated Successfully');
          });
          currentPasswordController.clear();
          newPasswordController.clear();
          confirmPasswordController.clear();
          Get.back();
        } else {
          Utils.flutterToast('Password not matched');
        }
      
    } catch (e) {
      Utils.flutterToast(e.toString());
    }
  }
}
