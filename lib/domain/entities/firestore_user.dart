class FirestoreUser {
  final String uid;
  final String displayName;
  final String email;
  final String? photoURL;

  FirestoreUser(
    this.uid,
    this.displayName,
    this.email,
    this.photoURL,
  );
}
