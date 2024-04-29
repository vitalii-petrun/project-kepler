import 'package:mockito/annotations.dart';
import 'package:project_kepler/domain/repositories/space_devs_repository.dart';
import 'package:project_kepler/domain/use_cases/fetch_articles_use_case.dart';
import 'package:project_kepler/domain/use_cases/get_all_launches_use_case.dart';
import 'package:project_kepler/presentation/utils/language_detection_service.dart';

@GenerateNiceMocks([
  MockSpec<SpaceDevsRepository>(),
  MockSpec<FetchArticlesUseCase>(),
  MockSpec<GetAllLaunchesUseCase>(),
  MockSpec<LanguageDetectionService>()
])

// ignore: unused_import
import 'test_helpers.mocks.dart';
