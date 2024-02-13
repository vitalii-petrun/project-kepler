import '../../data/repositories/api_repository_impl.dart';
import '../entities/launch.dart';

class GetUpcomingLaunchesUseCase {
  final ApiRepositoryImpl repository;

  GetUpcomingLaunchesUseCase(this.repository);

  Future<List<Launch>> call() async {
    return await repository.getUpcomingLaunchList();
  }
}
