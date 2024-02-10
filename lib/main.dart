import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_kepler/core/application.dart';
import 'package:project_kepler/data/data%20sources/remote/api_client.dart';
import 'package:project_kepler/presentation/cubits/authentication/authentication_cubit.dart';
import 'package:project_kepler/presentation/navigation/app_router.dart';

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
      authenticationCubit: AuthenticationCubit(),
    ),
  );
}
