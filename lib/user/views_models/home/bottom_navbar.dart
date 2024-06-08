import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hostel_mangement/user/views/explore/admin_explore.dart';
import 'package:hostel_mangement/user/views/explore/explore1.dart';
import 'package:hostel_mangement/user/views/home/admin_home_screen.dart';
import 'package:hostel_mangement/user/views/home/home_screen.dart';
import 'package:hostel_mangement/user/views/home/service_dashboard.dart';
import 'package:hostel_mangement/user/views/hostel/admin_hostel.dart';
import 'package:hostel_mangement/user/views/hostel/hostel_screen.dart';
import 'package:hostel_mangement/user/views/profile/profile_screen.dart';
import 'package:hostel_mangement/user/views/students/admin_students_details.dart';

class MyHomePageController extends GetxController {
  final PageController pageController = PageController(initialPage: 0);
  final NotchBottomBarController notchBottomBarController =
      NotchBottomBarController(index: 0);

  int maxCount = 5;
  int serviceMAx = 4;

  List<Widget> userPages = [
    const HomeScreen(),
    const HostelScreen(),
    UserServicesScreen(),
    const ProfileScreen(),
  ];

  List<Widget> adminPages = [
    const AdminHomeScreen(),
    AdminHostel(),
    AdminStudentsDetails(),
    const ProfileScreen(),
  ];
  List<Widget> servicePages = [
    ServiceDahsboard(),
    const AdminServicesScreen(),
    const ProfileScreen(),
  ];

  void onTabChange(int index) {
    pageController.jumpToPage(index);
  }

  // @override
  // void dispose() {
  //   pageController.dispose();
  //   super.dispose();
  // }
}
