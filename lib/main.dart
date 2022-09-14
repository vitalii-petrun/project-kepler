import 'package:flutter/material.dart';
import 'package:project_kepler/core/application.dart';
import 'package:project_kepler/data/repositories/api_repository_impl.dart';

void main() {
  ApiRepositoryImpl().getLaunchList();
  runApp(const Application());
}
