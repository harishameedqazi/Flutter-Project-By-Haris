import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hostel_mangement/res/const/firebase_const.dart';
import 'package:hostel_mangement/res/widgets/utils.dart';
import 'package:hostel_mangement/services/firebase/firebase_services.dart';
import 'package:hostel_mangement/services/shared_prefernces/shared_preferences.dart';
import 'package:hostel_mangement/user/views/auth/login_screen.dart';
import 'package:hostel_mangement/user/views/home/admin_bottom_nav.dart';
import 'package:hostel_mangement/user/views/home/home.dart';
import 'package:hostel_mangement/user/views/home/service_dashboard_screen.dart';

class AuthModel extends GetxController {
  FirebaseServices firebaseServices = FirebaseServices();
  var isLoading = false.obs;
  var emailController = TextEditingController();
  var pasController = TextEditingController();
  var conformPassController = TextEditingController();
  var nameController = TextEditingController();
  final userType = 'User'.obs;
  var isAdmin;
  var isService;
  List<String> usercategory = ['Hostel Admin', 'User', 'Service Admin'];
  var obscureText = true.obs;
  var obscureText1 = true.obs;

  void setSelected(String value) {
    userType.value = value;
  }

// signIn

  Future<UserCredential?> signIn({email, pass}) async {
    UserCredential? userCredential;

    try {
      isLoading.value = true;
      update();
      String? token = await firebaseMessaging.getToken();
      if (token != null) {
        // Update Firestore document with token
        await firestore
            .collection('users')
            .where('id', isEqualTo: auth.currentUser!.uid)
            .get()
            .then((QuerySnapshot querySnapshot) {
          for (var doc in querySnapshot.docs) {
            doc.reference.update({'pushToken': token});
          }
        });
      }
      userCredential = await auth
          .signInWithEmailAndPassword(
        email: email,
        password: pass,
      )
          .then((value) {
        return firebaseServices.getUserType(value.user!.uid).then((userType) {
          isAdmin = (userType == 'Hostel Admin');
          isService = (userType == 'Service Admin');

          SharedPreferencesHelper.setUserRole(userType);

          // Save email and password to SharedPreferences
          SharedPreferencesHelper.setPassword(pass);
          if (isAdmin) {
            return Get.offAll(() => const AdminBottomNav());
          } else if (isService) {
            return Get.offAll(() => const ServiceDashboardNavBar());
          } else {
            return Get.offAll(() => const Home());
          }
        });
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Utils.flutterToast('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Utils.flutterToast('Wrong password provided for that user.');
      } else if (e.code == 'invalid-email') {
        Utils.flutterToast('Invalid email format.');
      } else {
        Utils.flutterToast('An error occurred while logging in.');
      }
    } catch (error) {
      Utils.flutterToast(error.toString());
    } finally {
      isLoading.value = false;
      update();
    }

    return userCredential;
  }

  // register with email and password
  Future<UserCredential?> signUp({String? email, String? password}) async {
    UserCredential? userCredential;

    try {
      isLoading.value = true;
      // update();
      String? token = await firebaseMessaging.getToken();
      print('token $token');
      userCredential = await auth
          .createUserWithEmailAndPassword(
        email: email!,
        password: password!,
      )
          .then((value) {
        Utils.sucessToast('Account created successfully');

        return firebaseServices
            .signupDetails(
                pushToken: token,
                createdAt: DateTime.now().toString(),
                name: nameController.text,
                id: value.user!.uid,
                email: email,
                password: password,
                usertype: userType.value,
                val: value)
            .then((value) {
          isLoading.value = false;

          return Get.off(() => const LoginScreen());
        });
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Utils.flutterToast('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Utils.flutterToast('The account already exists for that email.');
      }
    } finally {
      isLoading.value = false;
      update();
    }

    return userCredential;
  }

  // sign out
  Future<void> signOut() async {
    try {
      await auth.signOut().then((value) async {
        Get.off(() => const LoginScreen());
        await SharedPreferencesHelper.clearUserPreferences();
      });
    } catch (error) {
      Utils.flutterToast(error.toString());
    }
  }
}
