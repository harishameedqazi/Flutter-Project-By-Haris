import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;



class FirebaseStorageService {
  static Future<String?> uploadImage(File file, String folderName) async {
    try {
      if (!file.existsSync()) {
        // The file doesn't exist, handle accordingly
        print('Error: File does not exist at ${file.path}');
        return null;
      }


      String fileName = file.path.split('/').last;
      Reference storageReference =
          FirebaseStorage.instance.ref().child('$folderName/$fileName');

      UploadTask uploadTask = storageReference.putFile(file);
      TaskSnapshot taskSnapshot = await uploadTask;

      // Get the download URL
      String downloadURL = await taskSnapshot.ref.getDownloadURL();
      return downloadURL;
    } on FirebaseException catch (e) {
      print('Error uploading image to Firebase Storage: $e');
      return null;
    }
  }
}
