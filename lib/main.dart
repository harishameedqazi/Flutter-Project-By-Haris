
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hostel_mangement/firebase_options.dart';
import 'package:hostel_mangement/res/const/firebase_const.dart';
import 'package:hostel_mangement/services/notification/push_notication.dart';
import 'package:hostel_mangement/services/shared_prefernces/shared_preferences.dart';
import 'package:hostel_mangement/user/views/home/admin_bottom_nav.dart';
import 'package:hostel_mangement/user/views/home/home.dart';
import 'package:hostel_mangement/user/views/home/service_dashboard_screen.dart';
import 'package:hostel_mangement/user/views/welcome/welcome_screen.dart';
import 'package:hostel_mangement/user/views_models/students/practice.dart';

// ignore: prefer_typing_uninitialized_variables
var size;
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   // FirebaseFirestore.instance.settings=
//   firestore.settings = Settings(persistenceEnabled: true);
//   await FirebaseNotification().initNotification();
//   runApp(const MyApp());
// }
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(
      (message) => _firebaseMessagingBackgroundHandler(message));
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  firestore.settings = const Settings(persistenceEnabled: true);
  runApp(const MyApp());
}
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print(message.notification?.title);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseNotification firebaseNotification = FirebaseNotification();

  @override
  void initState() {
    firebaseNotification.initNotification();
    firebaseNotification.getToken();
    firebaseNotification.fireBaseInit(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return GetMaterialApp(
    //   home: PracticeScreen(),
    // );
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
