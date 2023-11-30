import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/firestore_user.dart';
import '../../domain/repositories/db_repository.dart';

class FirestoreUserRepository implements DBRepository<FirestoreUser> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<FirestoreUser> get(String id) async {
    var snapshot = await _firestore.collection('users').doc(id).get();
    return FirestoreUser.fromJson(snapshot.data() ?? {});
  }

  @override
  Stream<List<FirestoreUser>> getAll() {
    return _firestore.collection('users').snapshots().map((snapshot) => snapshot
        .docs
        .map((doc) => FirestoreUser.fromJson(doc.data()))
        .toList());
  }

  @override
  Future<void> add(FirestoreUser user) async {
    await _firestore.collection('users').doc(user.uid).set(user.toJson());
  }

  @override
  Future<void> update(String id, FirestoreUser user) async {
    await _firestore.collection('users').doc(id).update(user.toJson());
  }

  @override
  Future<void> delete(String id) async {
    await _firestore.collection('users').doc(id).delete();
  }
}
