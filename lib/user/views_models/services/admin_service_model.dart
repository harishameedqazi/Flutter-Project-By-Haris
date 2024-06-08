import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hostel_mangement/res/const/firebase_const.dart';
import 'package:hostel_mangement/res/widgets/utils.dart';
import 'package:hostel_mangement/services/firebase/add_services.dart';
import 'package:image_picker/image_picker.dart';

class AdminServiceController extends GetxController {
  AddServiceDetails addServiceDetails = AddServiceDetails();
  var isLoading = false.obs;
  TextEditingController addressController = TextEditingController();
  TextEditingController serviceNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  final List<RoomImage> roomImages = List.generate(
    5,
    (index) => RoomImage('Room ${index + 1}'),
  );
  Rx<File?> selectedImage = Rx<File?>(null);
  var services = <Map<String, dynamic>>[].obs;



  

  Stream<List<Map<String, dynamic>>> fetchHostelsStream() {
    var currentUser = auth.currentUser;
    return firestore
        .collection(serviceCollection)
        .where('serviceadminId', isEqualTo: currentUser?.uid)
        .snapshots()
        .map<List<Map<String, dynamic>>>((snapshot) {
      return snapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      selectedImage.value = File(pickedImage.path);
    }
  }

  Future<void> getImageFromGallery(int index) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      roomImages[index].image.value = File(pickedImage.path);
    }
  }

  Future<void> addServiceToFirestore() async {
    try {
      isLoading(true);
      List<String> roomImagesUrls = [];
      for (RoomImage roomImage in roomImages) {
        if (roomImage.image.value != null) {
          roomImagesUrls.add(roomImage.image.value!.path);
        }
      }

      await addServiceDetails.addServiceToFirestore(
        serviceName: serviceNameController.text,
        address: addressController.text,
        description: descriptionController.text,
        phoneNo: phoneController.text,
        serviceImage: selectedImage.value?.path ?? '',
        serviceImageList: roomImagesUrls,
      );

      Utils.sucessToast('Service added successfully');
      isLoading(false);

      Get.back();
    } on TimeoutException {
      Utils.flutterToast('Failed to add the service. Please try again.');
      isLoading(false);
    } on SignalException {
      Utils.flutterToast('Failed to add the service. Please try again.');

      isLoading(false);
    } catch (e) {
      print('Error adding service to Firestore: $e');
      Utils.flutterToast('Failed to add the service. Please try again.');
      isLoading(false);
    } finally {
      isLoading(false);
    }
  }
}

class RoomImage {
  final String name;
  final Rx<File?> image = Rx<File?>(null);

  RoomImage(this.name);
}
