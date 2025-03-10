import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String username;
  final String userId;
  final String photoUrl;
  final String description;
  final String postId;
  final DateTime timestamp;
  final likes;

  const Post({
    required this.username,
    required this.userId,
    required this.photoUrl,
    required this.description,
    required this.postId,
    required this.timestamp,
    required this.likes,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'userId': userId,
        'photoUrl': photoUrl,
        'description': description,
        'postId': postId,
        'timestamp': timestamp,
        'likes': likes,
      };

  static Post getPostFromSnap(DocumentSnapshot snapshot) {
    var shot = snapshot.data() as Map<String, dynamic>;
    return Post(
      username: shot['username'],
      userId: shot['userId'],
      photoUrl: shot['photoUrl'],
      description: shot['description'],
      postId: shot['postId'],
      timestamp: shot['timestamp'],
      likes: shot['likes'],
    );
  }
}
