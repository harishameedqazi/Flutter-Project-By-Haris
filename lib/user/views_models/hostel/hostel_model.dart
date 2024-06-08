import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hostel_mangement/res/const/firebase_const.dart';
import 'package:hostel_mangement/res/widgets/utils.dart';
import 'package:hostel_mangement/services/firebase/booking_hostel_service.dart';
import 'package:hostel_mangement/services/firebase/favriouite_service.dart';
import 'package:image_picker/image_picker.dart';

class HostelModel extends GetxController {
  Rx<File?> selectedImage = Rx<File?>(null);

  var showDetails = false.obs;
  BookingHostel bookingHostel = BookingHostel();
  Favrourite favourite = Favrourite();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();
  var clinicController = TextEditingController();
  var ageController = TextEditingController();
  var roomNOController = TextEditingController();

  final selected = 'Single Bed'.obs;
  final hostelselect = 'Boys'.obs;
  var isLoading = false.obs;
  List<String> roomCategories = ['Single Bed', 'Double Bed', 'Other'];
  List<String> hostelCategories = ['Boys', 'Girls'];

  var isFavourite = false.obs;

  void setSelected(String value) {
    selected.value = value;
  }

  void hostelSelected(String value) {
    hostelselect.value = value;
  }

  Stream<List<Map<String, dynamic>>> fetchHostelsStream() {
    return firestore
        .collection(hostelsCollection)
        .snapshots()
        .map<List<Map<String, dynamic>>>((snapshot) {
      return snapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  Stream<List<Map<String, dynamic>>> fetchServiceStream() {
    return firestore
        .collection(serviceCollection)
        .snapshots()
        .map<List<Map<String, dynamic>>>((snapshot) {
      return snapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  Future<void> toggleFavourite(String hostelId) async {
    if (isFavourite.value) {
      await favourite.removeFavoriteHostel(hostelId);
    } else {
      await favourite.addFavoriteHostel(hostelId);
    }
    isFavourite.toggle();
  }

  Future<void> checkFavouriteStatus(String hostelId) async {
    isFavourite.value = await favourite.isFavoriteHostel(hostelId);
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      selectedImage.value = File(pickedImage.path);
    }
  }

  Future<void> bookingHostelRequest({
    // Add new booking-related fields
    required String guestName,
    required String guestPhone,
    required String guestAddress,
    required String clinic,
    required String age,
    required String hostelName,
    required String hostelId,
    required String adminId,
    required String roomNo,
    required String price,
    // required String token,
  }) async {
    try {
      isLoading(true);
      // Check if the current user ID is already present in the studentsCollection
      final CollectionReference students =
          firestore.collection(studentsCollection);
      final currentUserBooking = await students
          .where('studentId', isEqualTo: auth.currentUser!.uid)
          .get();
      String? token = await firebaseMessaging.getToken();
      if (currentUserBooking.docs.isNotEmpty) {
        // The current user has already booked a hostel
        Utils.flutterToast('You have already booked a hostel');
        return;
      } else {
        bookingHostel
            .bookingHostel(
                guestName: guestName,
                guestPhone: guestPhone,
                guestAddress: guestAddress,
                cinic: clinic,
                age: age,
                hostelName: hostelName,
                hostelId: hostelId,
                adminId: adminId,
                guestImage: selectedImage.value!,
                price: price,
                token: token!,
                roomNo: roomNo)
            .then((value) {
          Utils.sucessToast('Booking Request successfully');
        });
        isLoading(false);
        nameController.clear();
        phoneController.clear();
        addressController.clear();
        ageController.clear();
        clinicController.clear();
        roomNOController.clear();
        selectedImage.value = null;
        Get.back();
      }
    } on TimeoutException {
      Utils.flutterToast('Failed to book the hostel. Please try again.');
      isLoading(false);
    } on SignalException {
      Utils.flutterToast('Failed to book the hostel. Please try again.');

      isLoading(false);
    } catch (e) {
      print('Error adding hostel to Firestore: $e');
      Utils.flutterToast('Failed to add the hostel. Please try again.');
      isLoading(false);
    } finally {
      isLoading(false);
    }
  }
}
