// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$User implements DiagnosticableTreeMixin {
  String get uid;
  String get email;
  String get password;
  String get username;
  dynamic get bio;
  dynamic get followers;
  dynamic get followings;
  String get photoUrl;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UserCopyWith<User> get copyWith =>
      _$UserCopyWithImpl<User>(this as User, _$identity);

  /// Serializes this User to a JSON map.
  Map<String, dynamic> toJson();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'User'))
      ..add(DiagnosticsProperty('uid', uid))
      ..add(DiagnosticsProperty('email', email))
      ..add(DiagnosticsProperty('password', password))
      ..add(DiagnosticsProperty('username', username))
      ..add(DiagnosticsProperty('bio', bio))
      ..add(DiagnosticsProperty('followers', followers))
      ..add(DiagnosticsProperty('followings', followings))
      ..add(DiagnosticsProperty('photoUrl', photoUrl));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is User &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.username, username) ||
                other.username == username) &&
            const DeepCollectionEquality().equals(other.bio, bio) &&
            const DeepCollectionEquality().equals(other.followers, followers) &&
            const DeepCollectionEquality()
                .equals(other.followings, followings) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      uid,
      email,
      password,
      username,
      const DeepCollectionEquality().hash(bio),
      const DeepCollectionEquality().hash(followers),
      const DeepCollectionEquality().hash(followings),
      photoUrl);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'User(uid: $uid, email: $email, password: $password, username: $username, bio: $bio, followers: $followers, followings: $followings, photoUrl: $photoUrl)';
  }
}

/// @nodoc
abstract mixin class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) _then) =
      _$UserCopyWithImpl;
  @useResult
  $Res call(
      {String uid,
      String email,
      String password,
      String username,
      dynamic bio,
      dynamic followers,
      dynamic followings,
      String photoUrl});
}

/// @nodoc
class _$UserCopyWithImpl<$Res> implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._self, this._then);

  final User _self;
  final $Res Function(User) _then;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? email = null,
    Object? password = null,
    Object? username = null,
    Object? bio = freezed,
    Object? followers = freezed,
    Object? followings = freezed,
    Object? photoUrl = null,
  }) {
    return _then(_self.copyWith(
      uid: null == uid
          ? _self.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _self.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _self.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      bio: freezed == bio
          ? _self.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as dynamic,
      followers: freezed == followers
          ? _self.followers
          : followers // ignore: cast_nullable_to_non_nullable
              as dynamic,
      followings: freezed == followings
          ? _self.followings
          : followings // ignore: cast_nullable_to_non_nullable
              as dynamic,
      photoUrl: null == photoUrl
          ? _self.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _User extends User with DiagnosticableTreeMixin {
  _User(
      {required this.uid,
      required this.email,
      required this.password,
      required this.username,
      this.bio = '',
      this.followers = '',
      this.followings = '',
      this.photoUrl = ''})
      : super._();
  factory _User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  @override
  final String uid;
  @override
  final String email;
  @override
  final String password;
  @override
  final String username;
  @override
  @JsonKey()
  final dynamic bio;
  @override
  @JsonKey()
  final dynamic followers;
  @override
  @JsonKey()
  final dynamic followings;
  @override
  @JsonKey()
  final String photoUrl;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UserCopyWith<_User> get copyWith =>
      __$UserCopyWithImpl<_User>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UserToJson(
      this,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'User'))
      ..add(DiagnosticsProperty('uid', uid))
      ..add(DiagnosticsProperty('email', email))
      ..add(DiagnosticsProperty('password', password))
      ..add(DiagnosticsProperty('username', username))
      ..add(DiagnosticsProperty('bio', bio))
      ..add(DiagnosticsProperty('followers', followers))
      ..add(DiagnosticsProperty('followings', followings))
      ..add(DiagnosticsProperty('photoUrl', photoUrl));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _User &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.username, username) ||
                other.username == username) &&
            const DeepCollectionEquality().equals(other.bio, bio) &&
            const DeepCollectionEquality().equals(other.followers, followers) &&
            const DeepCollectionEquality()
                .equals(other.followings, followings) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      uid,
      email,
      password,
      username,
      const DeepCollectionEquality().hash(bio),
      const DeepCollectionEquality().hash(followers),
      const DeepCollectionEquality().hash(followings),
      photoUrl);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'User(uid: $uid, email: $email, password: $password, username: $username, bio: $bio, followers: $followers, followings: $followings, photoUrl: $photoUrl)';
  }
}

/// @nodoc
abstract mixin class _$UserCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$UserCopyWith(_User value, $Res Function(_User) _then) =
      __$UserCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String uid,
      String email,
      String password,
      String username,
      dynamic bio,
      dynamic followers,
      dynamic followings,
      String photoUrl});
}

/// @nodoc
class __$UserCopyWithImpl<$Res> implements _$UserCopyWith<$Res> {
  __$UserCopyWithImpl(this._self, this._then);

  final _User _self;
  final $Res Function(_User) _then;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? uid = null,
    Object? email = null,
    Object? password = null,
    Object? username = null,
    Object? bio = freezed,
    Object? followers = freezed,
    Object? followings = freezed,
    Object? photoUrl = null,
  }) {
    return _then(_User(
      uid: null == uid
          ? _self.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _self.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _self.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      bio: freezed == bio ? _self.bio! : bio,
      followers: freezed == followers ? _self.followers! : followers,
      followings: freezed == followings ? _self.followings! : followings,
      photoUrl: null == photoUrl
          ? _self.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
