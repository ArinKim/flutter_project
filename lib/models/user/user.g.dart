// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_User _$UserFromJson(Map<String, dynamic> json) => _User(
      uid: json['uid'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      username: json['username'] as String,
      bio: json['bio'] ?? '',
      followers: json['followers'] ?? '',
      followings: json['followings'] ?? '',
      photoUrl: json['photoUrl'] as String? ?? '',
    );

Map<String, dynamic> _$UserToJson(_User instance) => <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'password': instance.password,
      'username': instance.username,
      'bio': instance.bio,
      'followers': instance.followers,
      'followings': instance.followings,
      'photoUrl': instance.photoUrl,
    };
