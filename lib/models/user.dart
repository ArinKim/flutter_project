import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String username;
  final String email;
  final String password;
  final String bio;
  final List followers;
  final List followings;
  final String photoUrl;
  final String uid;

  const User(
      {required this.email,
      required this.password,
      required this.username,
      required this.bio,
      required this.followers,
      required this.followings,
      required this.photoUrl,
      required this.uid});

  Map<String, dynamic> toJson() => {
        'username': username,
        'email': email,
        'password': password,
        'bio': bio,
        'followers': followers,
        'followings': followings,
        'photoUrl': photoUrl,
        'uid': uid
      };
      
  static User getUserFromSnap(DocumentSnapshot snapshot) {
    var shot = snapshot.data() as Map<String, dynamic>;
    return User(
      username: shot['username'],
      email: shot['email'],
      password: shot['password'],
      bio: shot['bio'],
      followers: shot['followers'],
      followings: shot['followings'],
      photoUrl: shot['photoUrl'],
      uid: shot['uid'],
    );
  }
}
