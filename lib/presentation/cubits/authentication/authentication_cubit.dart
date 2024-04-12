import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:project_kepler/core/extensions/build_context_ext.dart';

import 'package:project_kepler/presentation/cubits/authentication/authentication_state.dart';

import '../../../core/utils/connectivity_service.dart';
import '../../../domain/use_cases/sign_in_with_google_use_case.dart';
import '../../../domain/use_cases/sign_out_use_case.dart';
import '../../utils/ui_helpers.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final SignInWithGoogleUseCase signInWithGoogleUseCase;
  final SignOutUseCase signOutUseCase;
  final ConnectivityService connectivityService;

  AuthenticationCubit({
    required this.signInWithGoogleUseCase,
    required this.signOutUseCase,
    required this.connectivityService,
  }) : super(Unauthenticated());

  Future<void> signInWithGoogle(BuildContext context) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    if (await connectivityService.isConnected() == false) {
      showConnectionError(scaffoldMessenger, context.l10n.missingInternet);
      return;
    }

    try {
      final user = await signInWithGoogleUseCase();
      if (user != null) {
        emit(Authenticated(user));
      } else {
        emit(SignInCancelled());
      }
    } on FirebaseAuthException catch (authError) {
      emit(AuthenticationError(authError.message ?? context.l10n.unknownError));
    } on Exception catch (generalError) {
      emit(AuthenticationError(
          context.l10n.unknownError + generalError.toString()));
      // Optionally log the error
    }
  }

  Future<void> signOut() async {
    try {
      await signOutUseCase();
      emit(Unauthenticated());
    } on FirebaseAuthException catch (authError) {
      emit(AuthenticationError(authError.message ?? "Unknown error"));
    } on Exception catch (generalError) {
      emit(AuthenticationError("Unknown error$generalError"));
      // Optionally log the error
    }
  }

  String getUid() {
    if (state is Authenticated) {
      return (state as Authenticated).user.uid;
    } else {
      return "NO_USER";
    }
  }
}
