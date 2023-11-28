import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  final String uid;
  final String displayName;
  final String email;
  final String? photoURL;

  User(
    this.uid,
    this.displayName,
    this.email,
    this.photoURL,
  );

  ///Converter from json to [User] object.
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  ///Converter from  [User] object to json.
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
