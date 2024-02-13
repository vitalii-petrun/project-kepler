import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project_kepler/core/application.dart';
import 'package:project_kepler/data/data%20sources/remote/api_client.dart';
import 'package:project_kepler/presentation/cubits/authentication/authentication_cubit.dart';
import 'package:project_kepler/presentation/navigation/app_router.dart';

import 'core/utils/connectivity_service.dart';
import 'data/repositories/firestore_user_repository.dart';
import 'domain/use_cases/sign_in_with_google_use_case.dart';
import 'domain/use_cases/sign_out_use_case.dart';
import 'firebase_options.dart';

late final AppRouter appRouter;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  appRouter = AppRouter();

  ApiClient apiClient = ApiClient(
    Dio(),
    'https://lldev.thespacedevs.com/2.2.0',
  );

  runApp(
    Application(
      appRouter: appRouter,
      apiClient: apiClient,
      authenticationCubit: AuthenticationCubit(
        signOutUseCase: SignOutUseCase(firebaseAuth: FirebaseAuth.instance),
        signInWithGoogleUseCase: SignInWithGoogleUseCase(
          firebaseAuth: FirebaseAuth.instance,
          googleSignIn: GoogleSignIn(),
          userRepository: FirestoreUserRepository(),
        ),
        connectivityService: ConnectivityService(connectivity: Connectivity()),
      ),
    ),
  );
}
