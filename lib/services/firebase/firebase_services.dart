import 'package:hostel_mangement/model/usermodel.dart';
import 'package:hostel_mangement/res/const/firebase_const.dart';

class FirebaseServices {
  Future signupDetails(
      {String? name,
      String? id,
      String? email,
      String? password,
      String? pushToken,
      String ? createdAt,
      val,
    String?   usertype}) async {
    var db = firestore.collection(usersCollection).doc(val.user!.uid);
    UserModel usermodel = UserModel(
        name: name!,
        createdAt: createdAt!,
        pushToken: pushToken!,
        imageUrl:
            'https://static-00.iconduck.com/assets.00/profile-circle-icon-2048x2048-cqe5466q.png',
        id: auth.currentUser!.uid,
        email: email!,
        usertype: usertype!,
        password: password!);

    await db.set(usermodel.toJson());
  }


    Future<String> getUserType(String userId) async {
    try {
      var docSnapshot = await firestore
          .collection(usersCollection)
          .doc(userId)
          .get();

      // Assuming 'usertype' is the field in Firestore representing the user type
      return docSnapshot.get('usertype') ?? 'User';
    } catch (error) {
      print('Error getting user type: $error');
      return 'User'; // Default to 'User' in case of an error
    }
  }
}
