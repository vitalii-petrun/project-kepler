import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mockito/annotations.dart';
import 'package:project_kepler/core/utils/language_detection_service.dart';
import 'package:project_kepler/domain/repositories/launch_library_repository.dart';
import 'package:project_kepler/domain/use_cases/fetch_articles_use_case.dart';
import 'package:project_kepler/domain/use_cases/get_all_launches_use_case.dart';

@GenerateNiceMocks([
  MockSpec<LaunchLibraryRepository>(),
  MockSpec<FetchArticlesUseCase>(),
  MockSpec<GetAllLaunchesUseCase>(),
  MockSpec<LanguageDetectionService>(),
  MockSpec<FlutterLocalNotificationsPlugin>(),
])

// ignore: unused_import
import 'test_helpers.mocks.dart';
