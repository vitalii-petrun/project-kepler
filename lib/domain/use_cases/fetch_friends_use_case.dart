import '../../../data/repositories/firestore_user_repository.dart';
import '../../../domain/entities/firestore_user.dart';

class FetchFriendsUseCase {
  final FirestoreUserRepository firestoreUserRepository;

  FetchFriendsUseCase(this.firestoreUserRepository);

  Future<List<FirestoreUser>> call(String currentUserId) async {
    return await firestoreUserRepository.getFriendsOfUser(currentUserId);
  }
}
