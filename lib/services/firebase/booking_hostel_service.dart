import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hostel_mangement/res/const/firebase_const.dart';
import 'package:hostel_mangement/services/firebase/firebase_storage.dart';

class BookingHostel {
  Future<void> bookingHostel(
      {
      // Add new booking-related fields
      required String guestName,
      required String guestPhone,
      required String guestAddress,
      required String cinic,
      required String age,
      required String hostelName,
      required String hostelId,
      required String adminId,
      required String roomNo,
      required String price,
      required String token,

      required guestImage}) async {
    try {
      final CollectionReference hostels =
          firestore.collection(studentsCollection);

      String? guestImageUrl;
      if (guestImage != null && guestImage.path.isNotEmpty) {
        guestImageUrl = await FirebaseStorageService.uploadImage(
          guestImage,
          'guestImage',
        );
      }

      await hostels.doc(auth.currentUser!.uid).set({
        'studentId': auth.currentUser!.uid,
        'guestName': guestName,
        'guestPhone': guestPhone,
        'guestAddress': guestAddress,
        'guestImage': guestImageUrl,
        'clinic': cinic,
        'age': age,
        'hostelName': hostelName,
        'hostelId': hostelId,
        'adminId': adminId,
        'roomNo': roomNo,
        'price':price,
        'token':token
      });
    } catch (e) {
      print('Error adding hostel to Firestore: $e');
    }
  }
}
