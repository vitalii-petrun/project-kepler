import '../../data/repositories/api_repository_impl.dart';
import '../entities/launch.dart';

class GetAllLaunchesUseCase {
  final ApiRepositoryImpl repository;

  GetAllLaunchesUseCase(this.repository);

  Future<List<Launch>> call() async {
    return await repository.getLaunchList();
  }
}
