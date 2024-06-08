import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hostel_mangement/res/const/firebase_const.dart';
import 'package:hostel_mangement/res/widgets/utils.dart';
import 'package:hostel_mangement/services/firebase/firebase_storage.dart';

class AdminHostelDetails {
  Future<void> addHostelToFirestore({
    required String hostelName,
    required String address,
    required String description,
    required String phoneNo,
    required String totalRoomsAvailable,
    required String hostelCategory,
    required List<String> roomImages,
    required String hostelImage,
    required String hostelId,
    required String token,
    required String availableRooms,
  }) async {
    try {
      final CollectionReference hostels =
          firestore.collection(hostelsCollection);

      // Upload hostel image
      String? hostelImageUrl;
      if (hostelImage.isNotEmpty) {
        hostelImageUrl = await FirebaseStorageService.uploadImage(
          File(hostelImage),
          'hostel_images',
        );
      }

      // Upload room images
      List<String> roomImageUrls = [];
      for (String roomImage in roomImages) {
        if (roomImage.isNotEmpty) {
          String? imageUrl = await FirebaseStorageService.uploadImage(
            File(roomImage),
            'room_images',
          );
          if (imageUrl != null) {
            roomImageUrls.add(imageUrl);
          }
        }
      }

      await hostels.add({
        'hostelName': hostelName,
        'address': address,
        'description': description,
        'phoneNo': phoneNo,
        'totalRoomsAvailable': totalRoomsAvailable,
        'hostelCategory': hostelCategory,
        'userId': auth.currentUser!.uid,
        'hostelImage': hostelImageUrl,
        'roomImages': roomImageUrls,
        'hostelId': hostelId,
        'availableRooms':availableRooms,
        'token':token
      });
    } catch (e) {
      // Handle errors
      print('Error adding hostel to Firestore: $e');
    }
  }

  Future<void> addRoomsToFirestore(
      {required String roomId,
      required String description,
      required String price,
      required String totalBeds,
      required String availableBeds,
      required List<String> roomImages,
      required String hostelImage,
      required String hostelId}) async {
    try {
      final CollectionReference hostels = firestore.collection(roomsCollection);

      // Upload hostel image
      String? hostelImageUrl;
      if (hostelImage.isNotEmpty) {
        hostelImageUrl = await FirebaseStorageService.uploadImage(
          File(hostelImage),
          'hostel_images',
        );
      }

      // Upload room images
      List<String> roomImageUrls = [];
      for (String roomImage in roomImages) {
        if (roomImage.isNotEmpty) {
          String? imageUrl = await FirebaseStorageService.uploadImage(
            File(roomImage),
            'room_images',
          );
          if (imageUrl != null) {
            roomImageUrls.add(imageUrl);
          }
        }
      }

      await hostels.add({
        'roomNo': roomId,
        'description': description,
        'price': price,
        'userId': auth.currentUser!.uid,
        'hostelImage': hostelImageUrl,
        'roomImages': roomImageUrls,
        'totalBeds': totalBeds,
        'hostelId': hostelId,
        'availableBeds': availableBeds
      });
    } catch (e) {
      // Handle errors
      print('Error adding Rooms to Firestore: $e');
    }
  }

  Future<int> getTotalBeds(
      String userId, String hostelId, String roomId) async {
    try {
      var querySnapshot = await firestore
          .collection(roomsCollection)
          .where('userId', isEqualTo: userId)
          .where('hostelId', isEqualTo: hostelId)
          .where('roomNo', isEqualTo: roomId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        var roomDocument = querySnapshot.docs.first;
        var totalBeds = roomDocument['totalBeds'] as int;

        return totalBeds;
      } else {
        Utils.flutterToast('No Bed available');
        // Handle the case when the document is not found
        return 0;
      }
    } catch (e) {
      // Handle errors
      print('Error getting total beds: $e');
      return 0;
    }
  }

  // Future<void> deleteHostel(String hostelId) async {
  //   try {
  //     final CollectionReference hostels =
  //         firestore.collection(hostelsCollection);

  //     // Find the hostel document by its ID
  //     QuerySnapshot hostelQuery =
  //         await hostels.where('hostelId', isEqualTo: hostelId).get();

  //     // Check if the hostel exists
  //     if (hostelQuery.docs.isNotEmpty) {
  //       // Delete the hostel document
  //       await hostels.doc(hostelQuery.docs.first.id).delete();
  //       Utils.sucessToast('Hostel Room Deleted Succesfuuly');

  //       print('Hostel deleted successfully.');
  //     } else {
  //       print('Hostel with ID $hostelId not found.');
  //     }
  //   } catch (e) {
  //     // Handle errors
  //     Utils.flutterToast('Error deleting hostel from Firestore: $e');

  //     print('Error deleting hostel from Firestore: $e');
  //   }
  // }
  Future<void> deleteHostel(String hostelId) async {
    try {
      final CollectionReference hostels =
          firestore.collection(hostelsCollection);

      // Find the hostel document by its ID
      QuerySnapshot hostelQuery =
          await hostels.where('hostelId', isEqualTo: hostelId).get();

      // Check if the hostel exists
      if (hostelQuery.docs.isNotEmpty) {
        // Delete the hostel document
        await hostels.doc(hostelQuery.docs.first.id).delete();

        // Delete associated rooms
        await deleteRooms(hostelId);

        // Delete reserved students
        await deleteReservedStudents(hostelId);

        Utils.sucessToast('Hostel and associated data deleted successfully.');
        print('Hostel and associated data deleted successfully.');
      } else {
        print('Hostel with ID $hostelId not found.');
      }
    } catch (e) {
      // Handle errors
      Utils.flutterToast('Error deleting hostel and associated data: $e');
      print('Error deleting hostel and associated data: $e');
    }
  }

  Future<void> deleteRooms(String hostelId) async {
    try {
      final CollectionReference rooms = firestore.collection(roomsCollection);

      // Find rooms associated with the hostel ID
      QuerySnapshot roomQuery =
          await rooms.where('hostelId', isEqualTo: hostelId).get();

      // Delete each room
      for (QueryDocumentSnapshot roomDoc in roomQuery.docs) {
        await roomDoc.reference.delete();
      }

      print('Rooms associated with hostel ID $hostelId deleted successfully.');
    } catch (e) {
      // Handle errors
      print('Error deleting rooms associated with hostel ID $hostelId: $e');
    }
  }

  Future<void> deleteReservedStudents(String hostelId) async {
    try {
      final CollectionReference reservedStudents =
          firestore.collection(reservedStudentsCollection);

      // Find reserved students associated with the hostel ID
      QuerySnapshot reservedStudentsQuery =
          await reservedStudents.where('hostelId', isEqualTo: hostelId).get();

      // Delete each reserved student
      for (QueryDocumentSnapshot studentDoc in reservedStudentsQuery.docs) {
        await studentDoc.reference.delete();
      }

      print(
          'Reserved students associated with hostel ID $hostelId deleted successfully.');
    } catch (e) {
      // Handle errors
      print(
          'Error deleting reserved students associated with hostel ID $hostelId: $e');
    }
  }

  Future<void> deleteHostelRooms(String hostelId, String roomNo) async {
    try {
      final CollectionReference rooms = firestore.collection(roomsCollection);

      // Find rooms associated with the hostel ID
      QuerySnapshot roomQuery =
          await rooms.where('hostelId', isEqualTo: hostelId).get();

      // Delete each room
      for (QueryDocumentSnapshot roomDoc in roomQuery.docs) {
        String roomNo = roomDoc['roomNo'];
        await roomDoc.reference.delete();

        // Delete reserved students associated with the room
        await deleteReservedStudentsWithRoomNo(hostelId, roomNo);
      }

      print('Rooms associated with hostel ID $hostelId deleted successfully.');
    } catch (e) {
      // Handle errors
      print('Error deleting rooms associated with hostel ID $hostelId: $e');
    }
  }

  Future<void> deleteReservedStudentsWithRoomNo(
      String hostelId, String roomNo) async {
    try {
      final CollectionReference reservedStudents =
          firestore.collection(reservedStudentsCollection);

      // Find reserved students associated with the hostel ID and room number
      QuerySnapshot reservedStudentsQuery = await reservedStudents
          .where('hostelId', isEqualTo: hostelId)
          .where('roomNo', isEqualTo: roomNo)
          .get();

      // Delete each reserved student
      for (QueryDocumentSnapshot studentDoc in reservedStudentsQuery.docs) {
        await studentDoc.reference.delete();
      }

      print(
          'Reserved students with room number $roomNo associated with hostel ID $hostelId deleted successfully.');
    } catch (e) {
      // Handle errors
      print(
          'Error deleting reserved students with room number $roomNo associated with hostel ID $hostelId: $e');
    }
  }
}
