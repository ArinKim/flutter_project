import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post.freezed.dart';
part 'post.g.dart';

@freezed
abstract class Post with _$Post {
  factory Post({
    required String username,
    required String userId,
    required String photoUrl,
    required String description,
    required String postId,
    required DateTime timestamp,
    required List<String> likes,
  }) = _Post;

  factory Post.fromJson(Map<String, Object?> json) => _$PostFromJson(json);
}

// class Post {
//   final String username;
//   final String userId;
//   final String photoUrl;
//   final String description;
//   final String postId;
//   final DateTime timestamp;
//   final likes;

//   const Post({
//     required this.username,
//     required this.userId,
//     required this.photoUrl,
//     required this.description,
//     required this.postId,
//     required this.timestamp,
//     required this.likes,
//   });

//   Map<String, dynamic> toJson() => {
//         'username': username,
//         'userId': userId,
//         'photoUrl': photoUrl,
//         'description': description,
//         'postId': postId,
//         'timestamp': timestamp,
//         'likes': likes,
//       };

//   static Post getPostFromSnap(DocumentSnapshot snapshot) {
//     var shot = snapshot.data() as Map<String, dynamic>;
//     return Post(
//       username: shot['username'],
//       userId: shot['userId'],
//       photoUrl: shot['photoUrl'],
//       description: shot['description'],
//       postId: shot['postId'],
//       timestamp: shot['timestamp'],
//       likes: shot['likes'],
//     );
//   }
// }
