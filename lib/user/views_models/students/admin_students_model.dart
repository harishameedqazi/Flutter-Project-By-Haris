import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hostel_mangement/res/const/firebase_const.dart';
import 'package:hostel_mangement/res/widgets/utils.dart';
import 'package:hostel_mangement/services/firebase/admin_hostel_service.dart';
import 'package:hostel_mangement/services/notification/push_notication.dart';

class AdminStudnetsModel extends GetxController {
  var isLoading = false.obs;
  AdminHostelDetails adminHostelDetails = AdminHostelDetails();
  FirebaseNotification firebaseNotification = FirebaseNotification();
  Stream<List<Map<String, dynamic>>> fetchStundentsStream() {
    return firestore
        .collection(studentsCollection)
        .where('adminId', isEqualTo: auth.currentUser!.uid)
        .snapshots()
        .map<List<Map<String, dynamic>>>((snapshot) {
      return snapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  Future<int> fetchTotalStudents() async {
    final querySnapshot = await firestore
        .collection(reservedStudentsCollection)
        .where('adminId', isEqualTo: auth.currentUser!.uid)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      print(querySnapshot.docs.length);
      return querySnapshot.docs.length;
    } else {
      print(querySnapshot.docs.length);

      return 0;
    }
  }

  Future<int> fetchTotalRooms() async {
    final querySnapshot = await firestore
        .collection(hostelsCollection)
        .where('userId', isEqualTo: auth.currentUser!.uid)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      // Calculate the total number of rooms available
      int totalRooms = 0;
      for (var doc in querySnapshot.docs) {
        final roomsSnapshot = await firestore
            .collection(
                roomsCollection) // Assuming 'rooms' is the subcollection containing rooms data
            .where('userId', isEqualTo: auth.currentUser!.uid)
            .get();
        totalRooms += roomsSnapshot.docs.length;
      }
      print(totalRooms);
      return totalRooms;
    } else {
      // Return 0 if no hostels are found for the current user
      print(0);
      return 0;
    }
  }

  Future<int> fetchTotalPrice() async {
    final querySnapshot = await firestore
        .collection(hostelsCollection)
        .where('userId', isEqualTo: auth.currentUser!.uid)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      // Calculate the total number of rooms available
      int totalRooms = 0;
      // ignore: unused_local_variable
      for (var doc in querySnapshot.docs) {
        final roomsSnapshot = await firestore
            .collection(
                roomsCollection) // Assuming 'rooms' is the subcollection containing rooms data
            .where('userId', isEqualTo: auth.currentUser!.uid)
            .get();
        totalRooms += roomsSnapshot.docs.length;
      }
      print(totalRooms);
      return totalRooms;
    } else {
      // Return 0 if no hostels are found for the current user
      print(0);
      return 0;
    }
  }

  Stream<List<Map<String, dynamic>>> fetchstudentRequestStream() {
    return firestore
        .collection(reservedStudentsCollection)
        .where('adminId',
            isEqualTo: auth.currentUser!.uid) // Filter by user's hostel ID
        .snapshots()
        .map<List<Map<String, dynamic>>>((snapshot) {
      return snapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  // Future<void> acceptRequest(
  //     {String? studentId,
  //     String? userId,
  //     String? hostelId,
  //     String? roomId}) async {
  //   try {
  //     // Move student to reservedStudents collection
  //     adminHostelDetails
  //         .getTotalBeds(userId!, hostelId!, roomId!)
  //         .then((value) async {});
  //     await firestore.collection(reservedStudentsCollection).add(
  //           (await firestore
  //                   .collection(studentsCollection)
  //                   .doc(studentId)
  //                   .get())
  //               .data()!,
  //         );

  //     // Delete student from students collection
  //     await firestore.collection(studentsCollection).doc(studentId).delete();
  //     Utils.sucessToast('Request Accepted');
  //   } catch (e) {
  //     Utils.flutterToast('Error accepting request: $e');
  //   }
  // }

  Future<void> acceptRequest(
      {String? studentId,
      String? userId,
      String? hostelId,
      String? adminName,
      String? hostelName,
     
      String? roomId}) async {
    try {
      // Move student to reservedStudents collection
      adminHostelDetails.getTotalBeds(userId!, hostelId!, roomId!);

      // Decrease available beds by 1
      await decreaseAvailableBeds(hostelId, roomId);

      await firestore.collection(reservedStudentsCollection).add(
            (await firestore
                    .collection(studentsCollection)
                    .doc(studentId)
                    .get())
                .data()!,
          );
  
        firebaseNotification.sendRequestAcceptedNotification(
            guestName: adminName!, hostelName: hostelName!, adminId: studentId!);

      // Delete student from students collection
      await firestore.collection(studentsCollection).doc(studentId).delete();
      Utils.sucessToast('Request Accepted');
    } catch (e) {
      Utils.flutterToast('Error accepting request: $e');
    }
  }

  Future<void> decreaseAvailableBeds(String hostelId, String roomId) async {
    try {
      final QuerySnapshot roomSnapshot = await firestore
          .collection(roomsCollection)
          .where('hostelId', isEqualTo: hostelId)
          .where('roomNo', isEqualTo: roomId)
          .get();

      roomSnapshot.docs.forEach((doc) async {
        int availableBeds = int.parse(doc['availableBeds']);
        if (availableBeds > 0) {
          availableBeds--; // Decrease available beds by 1
          await doc.reference
              .update({'availableBeds': availableBeds.toString()});
        } else {
          // Handle case where available beds are already 0
          print('No available beds in this room');
        }
      });
    } catch (e) {
      print('Error decreasing available beds: $e');
    }
  }

  Future<void> rejectRequest({  String? adminName,String?studentId,
      String? hostelName,
    }) async {
    try {
      // Delete student from students collection
      await firestore.collection(studentsCollection).doc(studentId).delete();
      
        firebaseNotification.sendRequestRejectedNotification(
            guestName: adminName!, hostelName: hostelName!, adminId:studentId !);
      Utils.sucessToast('Request Rejected');
    } catch (e) {
      Utils.flutterToast('Error rejecting request: $e');
    }
  }
}
