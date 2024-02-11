import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../data/repositories/firestore_user_repository.dart';
import '../entities/firestore_user.dart';

class SignInWithGoogleUseCase {
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;
  final FirestoreUserRepository userRepository;

  SignInWithGoogleUseCase({
    required this.firebaseAuth,
    required this.googleSignIn,
    required this.userRepository,
  });

  Future<User?> call() async {
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser == null) return null;

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await firebaseAuth.signInWithCredential(credential);
    _addUserToFirestore(firebaseAuth.currentUser!);

    return firebaseAuth.currentUser;
  }

  void _addUserToFirestore(User user) {
    final FirestoreUser firestoreUser = FirestoreUser(
      user.uid,
      user.displayName ?? '',
      user.email ?? '',
      user.photoURL,
    );
    userRepository.add(firestoreUser);
  }
}
