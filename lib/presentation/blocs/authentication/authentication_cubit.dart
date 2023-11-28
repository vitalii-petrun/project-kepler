import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project_kepler/core/extensions/build_context_ext.dart';
import 'package:project_kepler/presentation/blocs/authentication/authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

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
      await addUserToFirestore(_firebaseAuth.currentUser!);

      emit(Authenticated(_firebaseAuth.currentUser!));
    } catch (e) {/* do nothing */}
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

  Future<void> addUserToFirestore(User user) async {
    //TODO: move to DB layer
    try {
      // Reference to Firestore collection
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');

      // Add user data to Firestore
      await users.doc(user.uid).set({
        'displayName': user.displayName,
        'email': user.email,
        'photoURL': user.photoURL,
        'uid': user.uid,
      });
    } catch (e) {
      print('Error adding user to Firestore: $e');
    }
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
