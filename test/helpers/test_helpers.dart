import 'package:mockito/annotations.dart';
import 'package:project_kepler/domain/repositories/api_repository.dart';
import 'package:project_kepler/domain/use_cases/fetch_articles_use_case.dart';
import 'package:project_kepler/domain/use_cases/get_all_launches_use_case.dart';
import 'package:project_kepler/presentation/utils/language_detection_service.dart';

@GenerateNiceMocks([
  MockSpec<ApiRepository>(),
  MockSpec<FetchArticlesUseCase>(),
  MockSpec<GetAllLaunchesUseCase>(),
  MockSpec<LanguageDetectionService>()
])

// ignore: unused_import
import 'test_helpers.mocks.dart';
