import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// for authentication
FirebaseAuth auth = FirebaseAuth.instance;
// for storing
FirebaseFirestore firestore = FirebaseFirestore.instance;
final FirebaseStorage storage = FirebaseStorage.instance;

// this is current user

User? currentUser = auth.currentUser;
// creating user detail in firebase
var currentId = currentUser!.uid;
const usersCollection = "users";
const hostelsCollection = "hostels";
const serviceCollection = "services";
const roomsCollection = "rooms";
const favoritesCollection = "favorites";
const studentsCollection = "students";
const reservedStudentsCollection = "reservedStudentsCollection";
const  fcmUrl='https://fcm.googleapis.com/fcm/send';
const fcmKey =
    'AAAAFGgFs4M:APA91bFD1UpaIIotKmLp2eruvQz9O1sqEtfYEMDK-91uMnjpu8x4n029k-ZKopuacamX6q9fCgVVSWI683pLNvD8qGqjLGExqjjD1-ep9ELXhn8YmiE6iiLcT7gWpmHtrTLzi8gd5LqH';

// creating prduct in firebase
final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
