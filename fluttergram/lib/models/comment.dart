import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  final String username;
  final String userId;
  final String commentId;
  final String comment;
  final String postId;
  final DateTime timestamp;
  final likes;

  const Comment({
    required this.username,
    required this.userId,
    required this.commentId,
    required this.comment,
    required this.postId,
    required this.timestamp,
    required this.likes,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'userId': userId,
        'commentId': commentId,
        'comment': comment,
        'postId': postId,
        'timestamp': timestamp,
        'likes': likes,
      };

  static Comment getPostFromSnap(DocumentSnapshot snapshot) {
    var shot = snapshot.data() as Map<String, dynamic>;
    return Comment(
      username: shot['username'],
      userId: shot['userId'],
      commentId: shot['commentId'],
      comment: shot['comment'],
      postId: shot['postId'],
      timestamp: shot['timestamp'],
      likes: shot['likes'],
    );
  }
}
