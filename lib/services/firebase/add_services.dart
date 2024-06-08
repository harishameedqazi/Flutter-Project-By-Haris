import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hostel_mangement/res/const/firebase_const.dart';
import 'package:hostel_mangement/services/firebase/firebase_storage.dart';

class AddServiceDetails {
  Future<void> addServiceToFirestore({
    required String serviceName,
    required String address,
    required String description,
    required String phoneNo,
    required String serviceImage,
    required List<String> serviceImageList,
  }) async {
    try {
      final CollectionReference services =
          firestore.collection(serviceCollection);

      String? imageUrl;
      if (serviceImage.isNotEmpty) {
        imageUrl = await FirebaseStorageService.uploadImage(
          File(serviceImage),
          'service_images',
        );
      }

      List<String> imageUrls = [];
      for (String image in serviceImageList) {
        if (image.isNotEmpty) {
          String? url = await FirebaseStorageService.uploadImage(
            File(image),
            'room_images',
          );
          if (url != null) {
            imageUrls.add(url);
          }
        }
      }

      await services.add({
        'serviceName': serviceName,
        'address': address,
        'description': description,
        'phoneNo': phoneNo,
        'serviceImage': imageUrl ,
        'serviceImageList': imageUrls,
        'serviceadminId': auth.currentUser!.uid
      });
    } catch (e) {
      // Handle errors
      print('Error adding service to Firestore: $e');
    }
  }
}
