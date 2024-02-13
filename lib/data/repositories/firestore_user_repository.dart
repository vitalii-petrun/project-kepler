import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/converters/firestore_user_converter.dart';
import '../../domain/entities/firestore_user.dart';
import '../../domain/repositories/db_repository.dart';
import '../../data/models/firestore_user_dto.dart';

class FirestoreUserRepository implements DBRepository<FirestoreUser> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final FirestoreUserDtoToEntityConverter _dtoToEntityConverter =
      FirestoreUserDtoToEntityConverter();

  final FirestoreUserEntityToDtoConverter _entityToDtoConverter =
      FirestoreUserEntityToDtoConverter();

  @override
  Future<FirestoreUser> get(String id) async {
    var snapshot = await _firestore.collection('users').doc(id).get();
    var userDto = FirestoreUserDTO.fromJson(snapshot.data() ?? {});
    return _dtoToEntityConverter.convert(userDto);
  }

  @override
  Stream<List<FirestoreUser>> getAll() {
    return _firestore.collection('users').snapshots().map((snapshot) => snapshot
        .docs
        .map((doc) => _dtoToEntityConverter
            .convert(FirestoreUserDTO.fromJson(doc.data())))
        .toList());
  }

  @override
  Future<void> add(FirestoreUser user) async {
    await _firestore
        .collection('users')
        .doc(user.uid)
        .set(_entityToDtoConverter.convert(user).toJson());
  }

  @override
  Future<void> update(String id, FirestoreUser user) async {
    await _firestore
        .collection('users')
        .doc(id)
        .update(_entityToDtoConverter.convert(user).toJson());
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
        var data = friendDoc.data() as Map<String, dynamic>?; // Safe cast
        if (data != null) {
          var friendDto = FirestoreUserDTO.fromJson(data);
          friendsList.add(_dtoToEntityConverter.convert(friendDto));
        }
      }
      return friendsList;
    } catch (e) {
      throw Exception('Failed to fetch friends list: $e');
    }
  }
}
