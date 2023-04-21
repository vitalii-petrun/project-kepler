import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_kepler/core/application.dart';
import 'package:project_kepler/presentation/navigation/app_router.dart';
import 'package:project_kepler/utils/authentication.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Authentication.initializeFirebase();

  final appRouter = AppRouter();

  runApp(Application(appRouter: appRouter));
}
