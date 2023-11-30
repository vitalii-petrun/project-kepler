import 'package:json_annotation/json_annotation.dart';

part 'firestore_user.g.dart';

@JsonSerializable(explicitToJson: true)
class FirestoreUser {
  final String uid;
  final String displayName;
  final String email;
  final String? photoURL;

  FirestoreUser(
    this.uid,
    this.displayName,
    this.email,
    this.photoURL,
  );

  ///Converter from json to [FirestoreUser] object.
  factory FirestoreUser.fromJson(Map<String, dynamic> json) =>
      _$FirestoreUserFromJson(json);

  ///Converter from  [FirestoreUser] object to json.
  Map<String, dynamic> toJson() => _$FirestoreUserToJson(this);
}
