import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/user.dart';
import 'Users_page_state.dart';

class UsersPageCubit extends Cubit<UsersPageState> {
  UsersPageCubit() : super(UsersInit());
  void fetch() async {
    emit(UsersLoading());
    await fetchUserList()
        .then((users) => emit(UsersLoaded(users)))
        .catchError((e) => emit(UsersError(e.toString())));
  }

  Future<List<User>> fetchUserList() async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');

      final querySnapshot = await users.get();
      List<User> usersList = [];

      for (var element in querySnapshot.docs) {
        final data = element.data();
        if (data != null && data is Map<String, dynamic>) {
          usersList.add(User.fromJson(data));
        }
      }

      return usersList;
    } catch (e) {
      print('Error fetching user list from Firestore: $e');
      // You might want to throw an exception here or return an empty list, depending on your use case.
      throw Exception('Failed to fetch user list');
    }
  }
}
