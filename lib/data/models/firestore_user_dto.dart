import 'package:json_annotation/json_annotation.dart';

part 'firestore_user_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class FirestoreUserDTO {
  final String uid;
  final String displayName;
  final String email;
  final String? photoURL;

  FirestoreUserDTO(
    this.uid,
    this.displayName,
    this.email,
    this.photoURL,
  );

  ///Converter from json to [FirestoreUserDTO] object.
  factory FirestoreUserDTO.fromJson(Map<String, dynamic> json) =>
      _$FirestoreUserDTOFromJson(json);

  ///Converter from  [FirestoreUser] object to json.
  Map<String, dynamic> toJson() => _$FirestoreUserDTOToJson(this);
}
