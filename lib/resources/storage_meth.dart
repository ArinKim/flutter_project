import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageMethods {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> uploadImageToStorage(String childName, Uint8List file, bool isPost, String uuid) async {
    Reference ref;
    if (uuid == '') {
      ref = _firebaseStorage.ref().child(childName).child(_auth.currentUser!.uid);
    } else {
      ref = _firebaseStorage.ref().child(childName).child(uuid);
    }

    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String? downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
