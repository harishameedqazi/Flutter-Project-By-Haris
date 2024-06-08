import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hostel_mangement/res/colors.dart';

class Utils {
  static void flutterToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.red,
        textColor: AppColors.white,
        fontSize: 16.0);
  }

  static void sucessToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: AppColors.white,
        fontSize: 16.0);
  }

  void snackbar(BuildContext context, String message) {
    ScaffoldMessenger(child: SnackBar(content: Text(message)));
  }
}

Widget loading() {
  return CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation(AppColors.red),
  );
}
