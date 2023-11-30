// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firestore_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FirestoreUser _$FirestoreUserFromJson(Map<String, dynamic> json) =>
    FirestoreUser(
      json['uid'] as String,
      json['displayName'] as String,
      json['email'] as String,
      json['photoURL'] as String?,
    );

Map<String, dynamic> _$FirestoreUserToJson(FirestoreUser instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'displayName': instance.displayName,
      'email': instance.email,
      'photoURL': instance.photoURL,
    };
