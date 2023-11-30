import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_kepler/data/repositories/firestore_user_repository.dart';
import 'package:project_kepler/domain/entities/firestore_user.dart';

import 'Users_page_state.dart';

class UsersPageCubit extends Cubit<UsersPageState> {
  final FirestoreUserRepository _firestoreUserRepository =
      FirestoreUserRepository();
  StreamSubscription<List<FirestoreUser>>? _usersSubscription;

  UsersPageCubit() : super(UsersInit()) {
    fetchUsers();
  }

  void fetchUsers() {
    emit(UsersLoading());
    _usersSubscription?.cancel();
    _usersSubscription = _firestoreUserRepository.getAll().listen(
          (users) => emit(UsersLoaded(users)),
          onError: (e) => emit(UsersError(e.toString())),
        );
  }

  @override
  Future<void> close() {
    _usersSubscription?.cancel();
    return super.close();
  }
}

// class UsersPageCubit extends Cubit<UsersPageState> {
//   final FirestoreUserRepository _firestoreUserRepository =
//       FirestoreUserRepository();

//   // Create a StreamController to handle the stream
//   final StreamController<List<FirestoreUser>> _usersController =
//       StreamController<List<FirestoreUser>>();

//   UsersPageCubit() : super(UsersInit()) {
//     _firestoreUserRepository.getAll().listen((users) {
//       emit(UsersLoaded(users));
//     }, onError: (error) {
//       emit(UsersError(error.toString()));
//     });
//   }
//   Stream<List<FirestoreUser>> get usersStream => _usersController.stream;

//   @override
//   Future<void> close() {
//     _usersController.close();
//     return super.close();
//   }
// }