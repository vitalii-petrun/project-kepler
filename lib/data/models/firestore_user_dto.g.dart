// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firestore_user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FirestoreUserDTO _$FirestoreUserDTOFromJson(Map<String, dynamic> json) =>
    FirestoreUserDTO(
      json['uid'] as String,
      json['displayName'] as String,
      json['email'] as String,
      json['photoURL'] as String?,
    );

Map<String, dynamic> _$FirestoreUserDTOToJson(FirestoreUserDTO instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'displayName': instance.displayName,
      'email': instance.email,
      'photoURL': instance.photoURL,
    };
