import 'package:get/get.dart';
import 'package:hostel_mangement/res/const/firebase_const.dart';

class UserServicesModel extends GetxController{
    var isLoading = false.obs;

 Stream<List<Map<String, dynamic>>> fetchServcieStream() {
    return firestore
        .collection(serviceCollection)
        .snapshots()
        .map<List<Map<String, dynamic>>>((snapshot) {
      return snapshot.docs.map((doc) => doc.data()).toList();
    });
  }


}