import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttergram/models/user/user.dart' as model;
import 'package:fluttergram/resources/storage_meth.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get user data
  Future<model.User?> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot shot = await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromDocument(shot);
  }

  // To login
  Future<String?> loginUsr({required String email, required String password}) async {
    String? res = "Error occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(email: email, password: password);
        res = "Success";
        print(res);
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // To sign up
  Future<String?> singupUsr(
      {required String email, required String password, required String username, required String bio, required Uint8List avatarImg}) async {
    String? res = "Error occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty || username.isNotEmpty || bio.isNotEmpty || avatarImg != null) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);

        String? photoUrl = await StorageMethods().uploadImageToStorage('profilePic', avatarImg, false, '');

        model.User user = model.User(
            email: email, uid: cred.user!.uid, password: password, username: username, bio: bio, followers: [], followings: [], photoUrl: photoUrl);

        await _firestore.collection('users').doc(cred.user!.uid).set(user.toJson());

        res = "Success";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
