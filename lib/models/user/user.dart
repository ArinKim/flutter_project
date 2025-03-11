import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'user.freezed.dart';
part 'user.g.dart';

@freezed
abstract class User with _$User {
  const User._();
  factory User({
    required String uid,
    required String email,
    required String password,
    required String username,
    @Default('') bio,
    @Default('') followers,
    @Default('') followings,
    @Default('') String photoUrl,
  }) = _User;

  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);

  static User empty() {
    return User(uid: '', email: '', password: '', username: '', bio: '', followers: '', followings: '', photoUrl: '');
  }

  static User? fromDocument(DocumentSnapshot document) {
    dynamic data = document.data();
    if (data == null || data.data == null) return null;
    return User(
      uid: data.data['uid'],
      email: data.data['email'],
      password: data.data['password'],
      username: data.data['username'],
      bio: data.data['bio'],
      followers: data.data['followers'],
      followings: data.data['followings'],
      photoUrl: data.data['photoUrl'],
    );
  }
}

// class User {
//   final String username;
//   final String email;
//   final String password;
//   final String bio;
//   final List followers;
//   final List followings;
//   final String photoUrl;
//   final String uid;

//   const User(
//       {required this.email,
//       required this.password,
//       required this.username,
//       required this.bio,
//       required this.followers,
//       required this.followings,
//       required this.photoUrl,
//       required this.uid});

//   Map<String, dynamic> toJson() => {
//         'username': username,
//         'email': email,
//         'password': password,
//         'bio': bio,
//         'followers': followers,
//         'followings': followings,
//         'photoUrl': photoUrl,
//         'uid': uid
//       };

//   static User getUserFromSnap(DocumentSnapshot snapshot) {
//     var shot = snapshot.data() as Map<String, dynamic>;
//     return User(
//       username: shot['username'],
//       email: shot['email'],
//       password: shot['password'],
//       bio: shot['bio'],
//       followers: shot['followers'],
//       followings: shot['followings'],
//       photoUrl: shot['photoUrl'],
//       uid: shot['uid'],
//     );
//   }
// }
