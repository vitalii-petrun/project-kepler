import 'dart:convert';

import '../../data/models/firestore_user_dto.dart';
import '../entities/firestore_user.dart';

class FirestoreUserDtoToEntityConverter
    extends Converter<FirestoreUserDTO, FirestoreUser> {
  @override
  FirestoreUser convert(FirestoreUserDTO input) {
    return FirestoreUser(
      input.uid,
      input.displayName,
      input.email,
      input.photoURL,
    );
  }
}

class FirestoreUserEntityToDtoConverter
    extends Converter<FirestoreUser, FirestoreUserDTO> {
  @override
  FirestoreUserDTO convert(FirestoreUser input) {
    return FirestoreUserDTO(
      input.uid,
      input.displayName,
      input.email,
      input.photoURL,
    );
  }
}
