import 'package:flutter/material.dart';
import 'package:hostel_mangement/res/colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: AppColors.green,
    // backgroundColor: AppColors.white,
    // accentColor: AppColors.yellow,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.green,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: AppColors.green,
    ),
  );

  static ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColor: AppColors.green,
    // backgroundColor: AppColors.bluegrey,
    // accentColor: AppColors.yellow,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.green,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: AppColors.green,
    ),
  );
}
