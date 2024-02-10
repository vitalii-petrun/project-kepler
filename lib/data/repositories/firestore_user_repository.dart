import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/converters/firestore_user_converter.dart';
import '../../domain/entities/firestore_user.dart';
import '../../domain/repositories/db_repository.dart';
import '../../data/models/firestore_user_dto.dart';

class FirestoreUserRepository implements DBRepository<FirestoreUser> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<FirestoreUser> get(String id) async {
    var snapshot = await _firestore.collection('users').doc(id).get();
    var userDto = FirestoreUserDTO.fromJson(snapshot.data() ?? {});
    return FirestoreUserConverter.fromDto(userDto);
  }

  @override
  Stream<List<FirestoreUser>> getAll() {
    return _firestore
        .collection('users')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              var userDto = FirestoreUserDTO.fromJson(doc.data());
              return FirestoreUserConverter.fromDto(userDto);
            }).toList());
  }

  @override
  Future<void> add(FirestoreUser user) async {
    // Assuming FirestoreUserConverter.toDto(user) exists for converting back to DTO
    await _firestore
        .collection('users')
        .doc(user.uid)
        .set(FirestoreUserConverter.toDto(user).toJson());
  }

  @override
  Future<void> update(String id, FirestoreUser user) async {
    await _firestore
        .collection('users')
        .doc(id)
        .update(FirestoreUserConverter.toDto(user).toJson());
  }

  @override
  Future<void> delete(String id) async {
    await _firestore.collection('users').doc(id).delete();
  }

  Future<List<FirestoreUser>> getFriendsOfUser(String userId) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('user_friends')
          .get();

      List<FirestoreUser> friendsList = [];
      for (var friendDoc in querySnapshot.docs) {
        var friendDto =
            FirestoreUserDTO.fromJson(friendDoc.data() as Map<String, dynamic>);
        friendsList.add(FirestoreUserConverter.fromDto(friendDto));
      }
      return friendsList;
    } catch (e) {
      throw Exception('Failed to fetch friends list: $e');
    }
  }
}
