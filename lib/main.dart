import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_kepler/core/application.dart';
import 'package:project_kepler/presentation/blocs/authentication/authentication_cubit.dart';
import 'package:project_kepler/presentation/navigation/app_router.dart';

import 'firebase_options.dart';

late final AppRouter appRouter;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  appRouter = AppRouter();

  runApp(
    Application(
      appRouter: appRouter,
      authenticationCubit: AuthenticationCubit(),
    ),
  );
}
