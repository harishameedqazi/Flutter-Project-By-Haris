import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:hostel_mangement/res/const/firebase_const.dart';
import 'package:http/http.dart' as http;

class FirebaseNotification {
  Future<void> initNotification() async {
    NotificationSettings settings = await firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  getToken() async {
    String? token = await firebaseMessaging.getToken().then((value) {
      if (value != null) {
        print('Token: $value');
      }
    });
  }
 Future<String?> getUserToken(String userId) async {
    try {
      // Retrieve user document from Firestore
      DocumentSnapshot userDoc = await firestore.collection(usersCollection).doc(userId).get();
      
      // Check if the user document exists
      if (userDoc.exists) {
        // Retrieve the user's token from the document data
        String? userToken = userDoc.get('token');
        if (userToken != null) {
          return userToken;
        } else {
          print('User token not found for user with ID: $userId');
          return null;
        }
      } else {
        print('User document not found for user with ID: $userId');
        return null;
      }
    } catch (e) {
      print('Error retrieving user token: $e');
      return null;
    }
  }
  void fireBaseInit(context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        //   initLocalNotifications(context, message);
        // showNotification(message);
        print('Message Title: ${notification.title}');
        print('Message Body: ${notification.body}');
        print('Message Payload: ${message.data}');
        iniitLocalNotification(context, message);
        showNotification(message);
      }
    });
  }

  void showNotification(RemoteMessage message) {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      Random.secure().nextInt(10000).toString(),
      'High Importance Notification ',
    );

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(channel.id, channel.name,
            playSound: true,
            priority: Priority.high,
            importance: Importance.high,
            // showWhen: false,
            ticker: 'ticker');

    Future.delayed(Duration.zero, () {
      flutterLocalNotificationsPlugin.show(
          0,
          message.notification!.title.toString(),
          message.notification!.body.toString(),
          NotificationDetails(android: androidNotificationDetails));
    });
  }

  Future<void> iniitLocalNotification(
      BuildContext? context, RemoteMessage? message) async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    // AndroidInitializationSettings('@drawable/ic_launcher.png');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        print('Notification details: ${details.payload}');
        handleMessage(context!, message!);
      },
    );
  }

  void handleMessage(BuildContext context, RemoteMessage message) {
    iniitLocalNotification(context, message);
  
    // Get.to(()=>); 
  
 }

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    if (message.notification != null) {
      print('Message Title: ${message.notification?.title}');
      print('Message Body: ${message.notification?.body}');
      print('Message Payload: ${message.data}');
      print('Handling a background message ${message.messageId}');
    } else {
      print('No Notification');
    }
  }

  Future<void> sendBookingNotificationToAdmin({
    required String guestName,
    required String hostelName,
    required String adminId,
  }) async {
    // Construct the notification payload
    Map<String, dynamic> notificationData = {
      'title': 'New Reservation Request',
      'body': '$guestName has requested a reservation at $hostelName.'
    };

    // Send FCM notification
 String? adminToken = await getUserToken(adminId);
  if (adminToken != null) {
    // Send FCM notification
    sendFCMNotification(notificationData, adminToken);
  } else {
    print('Admin token not found.');
    // Handle the case where the admin's token is not found
  }
  }
  Future<void> sendNotificationtoGuest ({
    required String guestName,
    required String hostelName,
    required String adminId,
  }) async {
    // Construct the notification payload
    Map<String, dynamic> notificationData = {
      'title': 'New Reserv',
      'body': '$guestName has requested a reservation at $hostelName.'
    };
 String? adminToken = await getUserToken(adminId);
  if (adminToken != null) {
    // Send FCM notification
    sendFCMNotification(notificationData, adminToken);
  } else {
    print('Admin token not found.');
    // Handle the case where the admin's token is not found
  }
  }

  
  Future<void> sendRequestAcceptedNotification({
  required String guestName,
  required String hostelName,
  required String adminId,
}) async {
  // Construct the notification payload
  Map<String, dynamic> notificationData = {
    'title': 'Reservation Accepted',
    'body': 'Your reservation request at $hostelName has been accepted.'
  };

 String? adminToken = await getUserToken(adminId);
  if (adminToken != null) {
    // Send FCM notification
    sendFCMNotification(notificationData, adminToken);
  } else {
    print('Admin token not found.');
    // Handle the case where the admin's token is not found
  }
}

Future<void> sendRequestRejectedNotification({
  required String guestName,
  required String hostelName,
  required String adminId,
}) async {
  // Construct the notification payload
  Map<String, dynamic> notificationData = {
    'title': 'Reservation Rejected',
    'body': 'Your reservation request at $hostelName has been rejected.'
  };

  // Send FCM notification
   String? adminToken = await getUserToken(adminId);
  if (adminToken != null) {
    // Send FCM notification
    sendFCMNotification(notificationData, adminToken);
  } else {
    print('Admin token not found.');
    // Handle the case where the admin's token is not found
  }
}
void sendFCMNotification(Map<String, dynamic> notificationData, String guestToken) async {
    // Retrieve device token
    String? token = await firebaseMessaging.getToken();

    if (token != null) {
      // Define the FCM endpoint URL
      Uri fcmUrl = Uri.parse('https://fcm.googleapis.com/fcm/send');

      // Define the request body
      Map<String, dynamic> requestBody = {
        'to': guestToken,
        'notification': notificationData,
        'priority': 'high',
        // You can add more data if needed
      };

      // Send the HTTP POST request
      try {
        final response = await http.post(
          fcmUrl,
          body: jsonEncode(requestBody),
          headers: {
            'Content-Type': 'application/json; charset=utf-8',
            'Authorization': 'Bearer $fcmKey',
          },
        );

        if (response.statusCode == 200) {
          print('FCM notification sent successfully.');
        } else {
          print(
              'Failed to send FCM notification. Status code: ${response.statusCode}');
        }
      } catch (error) {
        print('Error sending FCM notification: $error');
      }
    }
  }

}
