import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttergram/models/post/post.dart' as post_model;
import 'package:fluttergram/models/user/user.dart' as usr_model;
import 'package:fluttergram/models/comment/comment.dart' as comment_model;
import 'package:fluttergram/resources/storage_meth.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // ###################################################################
  //                                Posts
  // ###################################################################

  // To upload post
  Future<String?> uploadPost({required String username, required String userId, required String description, required Uint8List postImg}) async {
    String? res = "Error occured";
    try {
      if (username.isNotEmpty || userId.isNotEmpty || description.isNotEmpty || postImg != null) {
        Timestamp now = Timestamp.now();
        DateTime timestamp = now.toDate();

        String uuid = const Uuid().v1();

        String? photoUrl = await StorageMethods().uploadImageToStorage('postPic', postImg, true, uuid);

        post_model.Post post = post_model.Post(
            username: username, userId: userId, photoUrl: photoUrl, description: description, postId: uuid, timestamp: timestamp, likes: []);

        await _firestore.collection('posts').doc(uuid).set(post.toJson());

        res = "Success";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String?> addPostItemInList(String postId, String key, String item, bool isRemove) async {
    String? res = "Error occured";

    try {
      if (postId.isNotEmpty || key.isNotEmpty || item.isNotEmpty) {
        if (!isRemove) {
          await _firestore.collection('posts').doc(postId).update({
            key: FieldValue.arrayUnion([item]),
          });
        } else {
          await _firestore.collection('posts').doc(postId).update({
            key: FieldValue.arrayRemove([item]),
          });
        }
        res = "Success";
      }
    } catch (err) {
      res = err.toString();
    }

    return res;
  }
  // ###################################################################
  //                                Comments
  // ###################################################################

  // To upload post
  Future<String?> uploadComment({required String username, required String userId, required String comment, required String postId}) async {
    String? res = "Error occured";
    try {
      if (username.isNotEmpty || userId.isNotEmpty || comment.isNotEmpty || postId.isNotEmpty) {
        Timestamp now = Timestamp.now();
        DateTime timestamp = now.toDate();

        String uuid = const Uuid().v1();

        comment_model.Comment com = comment_model.Comment(
            username: username, userId: userId, comment: comment, postId: postId, commentId: uuid, timestamp: timestamp, likes: []);
        await _firestore.collection('posts').doc(postId).collection('comments').doc(uuid).set(com.toJson());

        res = "Success";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String?> addCommentItemInList(String postId, String commentId, String key, String item, bool isRemove) async {
    String? res = "Error occured";

    try {
      if (postId.isNotEmpty || key.isNotEmpty || item.isNotEmpty) {
        if (!isRemove) {
          await _firestore.collection('posts').doc(postId).collection('comments').doc(commentId).update({
            key: FieldValue.arrayUnion([item]),
          });
        } else {
          await _firestore.collection('posts').doc(postId).collection('comments').doc(commentId).update({
            key: FieldValue.arrayRemove([item]),
          });
        }
        res = "Success";
      }
    } catch (err) {
      res = err.toString();
    }

    return res;
  }

// ###################################################################
//                                User
// ###################################################################
  Future<String?> addUserItemInList(String userId, String key, String item, bool isRemove) async {
    String? res = "Error occured";

    try {
      if (userId.isNotEmpty || key.isNotEmpty || item.isNotEmpty) {
        if (!isRemove) {
          await _firestore.collection('users').doc(userId).update({
            key: FieldValue.arrayUnion([item]),
          });
        } else {
          await _firestore.collection('users').doc(userId).update({
            key: FieldValue.arrayRemove([item]),
          });
        }
        res = "Success";
      }
    } catch (err) {
      res = err.toString();
    }

    return res;
  }

  Future<String?> addUserItem(String userId, String key, String item, bool isRemove) async {
    String? res = "Error occured";

    try {
      if (userId.isNotEmpty || key.isNotEmpty || item.isNotEmpty) {
        if (!isRemove) {
          await _firestore.collection('users').doc(userId).update({
            key: item,
          });
        } else {
          await _firestore.collection('users').doc(userId).update({
            key: '',
          });
        }
        res = "Success";
      }
    } catch (err) {
      res = err.toString();
    }

    return res;
  }

// ###################################################################
//                                General
// ###################################################################

// This function can be used in both post and comment
// To get posting user avatar
  Future<Map<String, dynamic>?> getPostingUser(String col, String docId) async {
    var collection = FirebaseFirestore.instance.collection(col);
    DocumentSnapshot docSnapshot = await collection.doc(docId).get();

    return usr_model.User.fromDocument(docSnapshot)?.toJson();
  }
}
