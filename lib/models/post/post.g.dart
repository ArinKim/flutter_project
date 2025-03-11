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
      timestamp: DateTime.parse(json['timestamp'] as String),
      likes: (json['likes'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$PostToJson(_Post instance) => <String, dynamic>{
      'username': instance.username,
      'userId': instance.userId,
      'photoUrl': instance.photoUrl,
      'description': instance.description,
      'postId': instance.postId,
      'timestamp': instance.timestamp.toIso8601String(),
      'likes': instance.likes,
    };
