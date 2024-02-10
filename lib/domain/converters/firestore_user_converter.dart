import '../../data/models/firestore_user_dto.dart';
import '../entities/firestore_user.dart';

class FirestoreUserConverter {
  static FirestoreUser fromDto(FirestoreUserDTO dto) {
    return FirestoreUser(
      dto.uid,
      dto.displayName,
      dto.email,
      dto.photoURL,
    );
  }

  static FirestoreUserDTO toDto(FirestoreUser user) {
    return FirestoreUserDTO(
      user.uid,
      user.displayName,
      user.email,
      user.photoURL,
    );
  }
}
