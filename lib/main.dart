import 'package:flutter/material.dart';
import 'package:project_kepler/core/application.dart';
import 'package:project_kepler/presentation/navigation/app_router.dart';

void main() {
  final appRouter = AppRouter();

  runApp(Application(appRouter: appRouter));
}
