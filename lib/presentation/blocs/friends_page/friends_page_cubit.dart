import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/firestore_user_repository.dart';

import 'friends_page_state.dart';

class FriendsPageCubit extends Cubit<FriendsPageState> {
  final FirestoreUserRepository _firestoreUserRepository =
      FirestoreUserRepository();

  FriendsPageCubit() : super(FriendsInit());

  void fetchFriends(String currentUserId) {
    emit(FriendsLoading());

    _firestoreUserRepository.getFriendsOfUser(currentUserId).then(
          (friends) => emit(FriendsLoaded(friends)),
          onError: (e) => emit(FriendsError(e.toString())),
        );
  }
}
