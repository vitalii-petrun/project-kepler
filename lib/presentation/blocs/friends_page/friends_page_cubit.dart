import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/user.dart';
import 'friends_page_state.dart';

class FriendsPageCubit extends Cubit<FriendsPageState> {
  FriendsPageCubit() : super(FriendsInit());
  void fetch(String id) async {
    emit(FriendsLoading());
    await fetchFriendsList(id)
        .then((users) => emit(FriendsLoaded(users)))
        .catchError((e) => emit(FriendsError(e.toString())));
  }

  Future<List<User>> fetchFriendsList(String userId) async {
    try {
      DocumentReference currentUserDocRef =
          FirebaseFirestore.instance.collection('users').doc(userId);

      QuerySnapshot querySnapshot =
          await currentUserDocRef.collection('user_friends').get();

      List<User> usersList = [];
      for (var doc in querySnapshot.docs) {
        await fetchUser(doc.id).then((user) => usersList.add(user));
      }
      return usersList;
    } catch (e) {
      throw Exception('Failed to fetch user list');
    }
  }

  Future<User> fetchUser(String userId) async {
    try {
      DocumentReference currentUserDocRef =
          FirebaseFirestore.instance.collection('users').doc(userId);

      DocumentSnapshot querySnapshot = await currentUserDocRef.get();

      User user = User.fromJson(querySnapshot.data() as Map<String, dynamic>);

      return user;
    } catch (e) {
      print('Error fetching user list from Firestore: $e');
      throw Exception('Failed to fetch user list');
    }
  }
}
