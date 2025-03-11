// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Comment _$CommentFromJson(Map<String, dynamic> json) => _Comment(
      username: json['username'] as String,
      userId: json['userId'] as String,
      commentId: json['commentId'] as String,
      comment: json['comment'] as String,
      postId: json['postId'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      likes: (json['likes'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$CommentToJson(_Comment instance) => <String, dynamic>{
      'username': instance.username,
      'userId': instance.userId,
      'commentId': instance.commentId,
      'comment': instance.comment,
      'postId': instance.postId,
      'timestamp': instance.timestamp.toIso8601String(),
      'likes': instance.likes,
    };
