
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:hostel_mangement/res/const/firebase_const.dart';
import 'package:hostel_mangement/res/widgets/utils.dart';
import 'package:image_picker/image_picker.dart';

class AccountServices {
  final ImagePicker imagePicker = ImagePicker();
  // get user details

  Future<Map<String, dynamic>> getUserDetails() async {
    try {
      var value = await firestore
          .collection(usersCollection)
          .doc(auth.currentUser!.uid)
          .get();

      return {
        'imageUrl': value.data()!['imageUrl'],
        'name': value.data()!['name'],
      };
    } catch (e) {
      Utils.flutterToast(e.toString());
      rethrow;
    }
  }

  updateName({name}) {
    return firestore
        .collection(usersCollection)
        .doc(auth.currentUser!.uid)
        .set({
      'name': name,
    }, SetOptions(merge: true));
  }

  Future<void> updateImageUrl({required String imageUrl}) async {
    firestore.collection(usersCollection).doc(auth.currentUser!.uid).set({
      'imageUrl': imageUrl,
    }, SetOptions(merge: true));
  }

  Stream<List<Map<String, dynamic>>> fetechPrfoileDetails() {
    var currentUser = auth.currentUser;
    return firestore
        .collection(usersCollection)
        .where('id', isEqualTo: currentUser?.uid)
        .snapshots()
        .map<List<Map<String, dynamic>>>((snapshot) {
      return snapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  Future<void> updateImageAndName(String imageUrl, String name) async {
    try {
      await firestore
          .collection(usersCollection)
          .doc(auth.currentUser!.uid)
          .set({'imageUrl': imageUrl, 'name': name}, SetOptions(merge: true));

      if (kDebugMode) {
        print('Update successful: Name=$name, ImageUrl=$imageUrl');
      }
    } catch (e) {
      Utils.flutterToast(e.toString());
      rethrow;
    }
  }
  Future<void> updatePassword(String pass) async {
    try {
      await firestore
          .collection(usersCollection)
          .doc(auth.currentUser!.uid)
          .set({'password': pass, }, SetOptions(merge: true));

      if (kDebugMode) {
        print('Update successful: pass=$pass');
      }
    } catch (e) {
      Utils.flutterToast(e.toString());
      rethrow;
    }
  }


    }



 
