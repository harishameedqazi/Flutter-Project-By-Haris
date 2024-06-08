import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hostel_mangement/res/const/firebase_const.dart';
import 'package:hostel_mangement/res/widgets/utils.dart';
import 'package:hostel_mangement/services/firebase/admin_hostel_service.dart';
import 'package:image_picker/image_picker.dart';

class AdminHostelController extends GetxController {
  AdminHostelDetails addHostelDetails = AdminHostelDetails();

  TextEditingController addressController = TextEditingController();
  TextEditingController hostelIdController = TextEditingController();
  TextEditingController hostelnameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController roomController = TextEditingController();
  TextEditingController availableRoomsController = TextEditingController();
  TextEditingController availableBedsController = TextEditingController();

  final List<RoomImage> roomImages = List.generate(
    5,
    (index) => RoomImage('Room ${index + 1}'),
  );
  Rx<File?> selectedImage = Rx<File?>(null);
  var isLoading = false.obs;
  var hostels = <Map<String, dynamic>>[].obs;

  Stream<List<Map<String, dynamic>>> fetchHostelsStream() {
    var currentUser = auth.currentUser;
    return firestore
        .collection(hostelsCollection)
        .where('userId', isEqualTo: currentUser?.uid)
        .snapshots()
        .map<List<Map<String, dynamic>>>((snapshot) {
      return snapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  Stream<List<Map<String, dynamic>>> fetchRoomsStream(
      {String? hostelId, required String? userid}) {
    return firestore
        .collection(roomsCollection)
        .where('userId', isEqualTo: userid)
        .where('hostelId', isEqualTo: hostelId)
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

  Future<void> addHostelToFirestore({
    required String hostelName,
    required String address,
    required String description,
    required String phoneNo,
    required String totalRoomsAvailable,
    required String hostelCategory,
    required String hostelId,
    required String availableRooms,

  }) async {
    try {
      isLoading(true);
String ? token= await firebaseMessaging.getToken();

      final existingRooms = await firestore
          .collection(roomsCollection)
          .where('userId', isEqualTo: auth.currentUser!.uid)
          .where('hostelId', isEqualTo: hostelId)
          .get();
      print(existingRooms);
      if (existingRooms.docs.isNotEmpty) {
        Utils.flutterToast(
            'Hostel ID already exists for this hostel. Please choose a different Room ID.');
        isLoading(false);
        return;
      } else {
        List<String> roomImagesUrls = [];
        for (RoomImage roomImage in roomImages) {
          if (roomImage.image.value != null) {
            roomImagesUrls.add(roomImage.image.value!.path);
          }
        }
        await addHostelDetails.addHostelToFirestore(
          hostelName: hostelName,
          address: address,
          description: description,
          phoneNo: phoneNo,
          totalRoomsAvailable: totalRoomsAvailable,
          hostelCategory: hostelCategory,
          roomImages: roomImagesUrls,
          availableRooms: availableRooms,
          hostelImage: selectedImage.value?.path ?? '',
          hostelId: hostelId,
          token:token!
        );

        Utils.sucessToast('Hostel added successfully');
        isLoading(false);
        Get.back();
        hostelnameController.clear();
        addressController.clear();
        descriptionController.clear();
        phoneController.clear();
      }
    } on TimeoutException {
      Utils.flutterToast('Failed to add the service. Please try again.');
      isLoading(false);
    } on SignalException {
      Utils.flutterToast('Failed to add the service. Please try again.');

      isLoading(false);
    } catch (e) {
      Utils.flutterToast('Failed to add the hostel. Please try again.');
      isLoading(false);
    } finally {
      isLoading(
          false); // Close loading indicator regardless of success or failure
    }
  }

  // add rooms
  Future<void> addroomsToFirestore({
    required String roomId,
    required String description,
    required String price,
    required String totalBeds,
    required String hostelId,
    required String availableBeds,
  }) async {
    try {
      isLoading(true);
      // Check if the room ID already exists for the given hostel
      final existingRooms = await firestore
          .collection(roomsCollection)
          .where('userId', isEqualTo: auth.currentUser!.uid)
          .where('hostelId', isEqualTo: hostelId)
          .where('roomNo', isEqualTo: roomId)
          .get();
      print('Room id exist');
      if (existingRooms.docs.isNotEmpty) {
        Utils.flutterToast(
            'Room ID already exists for this hostel. Please choose a different Room ID.');
        isLoading(false);
        return;
      } else {
        List<String> roomImagesUrls = [];
        for (RoomImage roomImage in roomImages) {
          if (roomImage.image.value != null) {
            roomImagesUrls.add(roomImage.image.value!.path);
          }
        }

        await addHostelDetails.addRoomsToFirestore(
          description: description,
          roomImages: roomImagesUrls,
          hostelImage: selectedImage.value?.path ?? '',
          hostelId: hostelId,
          roomId: roomId,
          price: price,
          totalBeds: totalBeds,
          availableBeds: availableBeds,
        );

        Utils.sucessToast('Room added successfully');
        isLoading(false);
        Get.back();
        hostelnameController.clear();
        descriptionController.clear();
        phoneController.clear();
        priceController.clear();
      }
    } on TimeoutException {
      Utils.flutterToast('Failed to add the Room. Please try again.');
      isLoading(false);
    } on SignalException {
      Utils.flutterToast('Failed to add the Room. Please try again.');

      isLoading(false);
    } catch (e) {
      Utils.flutterToast('Failed to add the Room. Please try again.');
      isLoading(false);
    } finally {
      isLoading(
          false); // Close loading indicator regardless of success or failure
    }
  }

  @override
  void onInit() {
    super.onInit();
    hostels.bindStream(fetchHostelsStream());
  }

  @override
  void onClose() {
    super.onClose();
    addressController.dispose();
    hostelnameController.dispose();
    descriptionController.dispose();
    phoneController.dispose();
    roomController.dispose();
    priceController.dispose();
  }

  Future<void> deleteHostel(String hostelId) async {
    try {
      addHostelDetails.deleteHostel(hostelId);
      Get.back();
    } catch (e) {
      if (kDebugMode) {
        print("Error deleting hostel $e");
      }
      Utils.flutterToast('Error deleting hostel $e');
    }
  }

  Future<void> deleteHostelRoom(String hostelId, String roomNo) async {
    try {
      addHostelDetails.deleteHostelRooms(hostelId, roomNo);
      Get.back();
    } catch (e) {
      if (kDebugMode) {
        print("Error deleting Room $e");
      }
      Utils.flutterToast('Error deleting Room $e');
    }
  }
}

class RoomImage {
  final String name;
  final Rx<File?> image = Rx<File?>(null);

  RoomImage(this.name);
}
