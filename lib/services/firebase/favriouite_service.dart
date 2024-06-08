import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hostel_mangement/res/const/firebase_const.dart';
import 'package:hostel_mangement/res/widgets/utils.dart';

class Favrourite{
  Future<void> addFavoriteHostel(String hostelId) async {
    try {
      await firestore
          .collection(favoritesCollection)
          .doc(auth.currentUser!.uid)
          .set({hostelId: true}, SetOptions(merge: true));
    } catch (e) {
      Utils.flutterToast('Failed to add hostel to favorites: $e');
    }
  }

  Future<void> removeFavoriteHostel(String hostelId) async {
    try {
      await firestore
          .collection(favoritesCollection)
          .doc(auth.currentUser!.uid)
          .update({hostelId: FieldValue.delete()});
    } catch (e) {
      Utils.flutterToast('Failed to remove hostel from favorites: $e');
    }
  }

  Future<bool> isFavoriteHostel(String hostelId) async {
    try {
      var snapshot = await firestore
          .collection(favoritesCollection)
          .doc(auth.currentUser!.uid)
          .get();

      var data = snapshot.data();
      return data != null && data[hostelId] == true;
    } catch (e) {
      Utils.flutterToast('Error checking favorite status: $e');
      return false;
    }
  }
}