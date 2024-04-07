import 'package:project_kepler/core/global.dart';

import '../../data/repositories/api_repository_impl.dart';
import '../entities/launch.dart';

class GetAllLaunchesUseCase {
  final ApiRepositoryImpl repository;

  GetAllLaunchesUseCase(this.repository);

  Future<List<Launch>> call() async {
    final launchList = await repository.getLaunchList();
    return await languageDetectionService.translateIfNeeded(launchList);
  }
}
