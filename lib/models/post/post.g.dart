// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Post _$PostFromJson(Map<String, dynamic> json) => _Post(
      username: json['username'] as String,
      userId: json['userId'] as String,
      photoUrl: json['photoUrl'] as String,
      description: json['description'] as String,
      postId: json['postId'] as String,
      timestamp: json['timestamp'] as String,
      likes: json['likes'] as String? ?? '0',
    );

Map<String, dynamic> _$PostToJson(_Post instance) => <String, dynamic>{
      'username': instance.username,
      'userId': instance.userId,
      'photoUrl': instance.photoUrl,
      'description': instance.description,
      'postId': instance.postId,
      'timestamp': instance.timestamp,
      'likes': instance.likes,
    };
