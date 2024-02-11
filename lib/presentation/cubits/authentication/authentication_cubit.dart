import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:project_kepler/core/extensions/build_context_ext.dart';

import 'package:project_kepler/presentation/cubits/authentication/authentication_state.dart';

import '../../../core/utils/connectivity_service.dart';
import '../../../domain/use_cases/sign_in_with_google_use_case.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final SignInWithGoogleUseCase signInWithGoogleUseCase;
  final ConnectivityService connectivityService;

  AuthenticationCubit({
    required this.signInWithGoogleUseCase,
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
}

void showConnectionError(
    ScaffoldMessengerState scaffoldMessenger, String message) {
  scaffoldMessenger.showSnackBar(
    SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 3),
    ),
  );
}
