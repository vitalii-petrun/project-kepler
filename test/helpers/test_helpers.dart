import 'package:mockito/annotations.dart';
import 'package:project_kepler/domain/repositories/api_repository.dart';
import 'package:project_kepler/domain/use_cases/fetch_articles_use_case.dart';
import 'package:project_kepler/domain/use_cases/get_all_launches_use_case.dart';

@GenerateNiceMocks([
  MockSpec<ApiRepository>(),
  MockSpec<FetchArticlesUseCase>(),
  MockSpec<GetAllLaunchesUseCase>()
])
import 'test_helpers.mocks.dart';
