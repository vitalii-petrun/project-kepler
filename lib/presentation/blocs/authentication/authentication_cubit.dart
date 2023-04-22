import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project_kepler/presentation/blocs/authentication/authentication_state.dart';

class AuthenticationCubit extends Cubit<AutheticationState> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  User? get user => _firebaseAuth.currentUser;
  AuthenticationCubit() : super(Uninitialized()) {
    _firebaseAuth.authStateChanges().listen(
        (user) => emit(user == null ? Uninitialized() : Authenticated(user)));
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _firebaseAuth.signInWithCredential(credential);
    } catch (e) {
      // Handle the exception
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
