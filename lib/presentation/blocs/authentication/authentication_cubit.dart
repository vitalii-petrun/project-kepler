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
    if (await checkConnectivity(context) == false) return;

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
      scaffoldMessengerKey.currentState!.showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          duration: const Duration(seconds: 5),
        ),
      );
    }
  }

  Future<void> signOut(BuildContext context) async {
    if (await checkConnectivity(context) == false) return;
    try {
      await _googleSignIn.signOut();
    } catch (e) {
      scaffoldMessengerKey.currentState!.showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  Future<bool> checkConnectivity(BuildContext context) async {
    final ConnectivityResult connectivityResult =
        await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.l10n.missingInternet),
          duration: const Duration(seconds: 3),
        ),
      );
    }
    return connectivityResult != ConnectivityResult.none;
  }
}
