import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hostel_mangement/services/notification/push_notication.dart';
import 'package:hostel_mangement/services/shared_prefernces/shared_preferences.dart';
import 'package:hostel_mangement/user/views/home/admin_bottom_nav.dart';
import 'package:hostel_mangement/user/views/home/home.dart';
import 'package:hostel_mangement/user/views/home/service_dashboard_screen.dart';
import 'package:hostel_mangement/user/views/welcome/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      // Assuming you have an async function to get the user's role
      future: SharedPreferencesHelper.getUserRole(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          String? userRole = snapshot.data;

          Widget homeScreen;
          if (userRole == 'Hostel Admin') {
            homeScreen = const AdminBottomNav();
          } else if (userRole == 'Service Admin') {
            homeScreen = const ServiceDashboardNavBar();
          } else if (userRole == 'User') {
            homeScreen = const Home();
          } else {
            homeScreen = const WelcomeScreen();
          }

          return GetMaterialApp(
            title: 'Hotel Management',
            home: homeScreen,
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
