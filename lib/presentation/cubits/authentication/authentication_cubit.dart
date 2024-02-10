import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project_kepler/core/extensions/build_context_ext.dart';
import 'package:project_kepler/data/repositories/firestore_user_repository.dart';
import 'package:project_kepler/domain/entities/firestore_user.dart';
import 'package:project_kepler/presentation/cubits/authentication/authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  final FirestoreUserRepository _userRepository = FirestoreUserRepository();

  User? get user => _firebaseAuth.currentUser;

  AuthenticationCubit() : super(Unauthenticated()) {
    _firebaseAuth.authStateChanges().listen(
        (user) => emit(user == null ? Unauthenticated() : Authenticated(user)));
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    if (await checkConnectivity(context) == false) {
      showConnectionError(context);
      return;
    }

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
      // Add the user to Firestore
      _addUserToFirestore();

      emit(Authenticated(_firebaseAuth.currentUser!));
    } catch (e) {/* do nothing */}
  }

  void _addUserToFirestore() {
    final User user = _firebaseAuth.currentUser!;
    final FirestoreUser firestoreUser = FirestoreUser(
      user.uid,
      user.displayName!,
      user.email!,
      user.photoURL,
    );
    _userRepository.add(firestoreUser);
  }

  Future<void> signOut(BuildContext context) async {
    if (await checkConnectivity(context) == false) {
      showConnectionError(context);
      return;
    }

    try {
      await _googleSignIn.signOut();
      emit(Unauthenticated());
    } catch (e) {/* do nothing */}
  }

  Future<bool> checkConnectivity(BuildContext context) async {
    final ConnectivityResult connectivityResult =
        await Connectivity().checkConnectivity();

    return connectivityResult != ConnectivityResult.none;
  }

  void showConnectionError(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(context.l10n.missingInternet),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}