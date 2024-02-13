import '../../../data/repositories/api_repository_impl.dart';
import '../../../domain/entities/launch.dart';
import '../../../domain/entities/agency.dart';

class GetLaunchDetailsUseCase {
  final ApiRepositoryImpl repository;

  GetLaunchDetailsUseCase(this.repository);

  Future<LaunchDetailsResult> call(String id) async {
    final launch = await repository.getLaunchDetailsById(id);
    final agency = await repository.getAgencyById(launch.pad.agencyID);
    return LaunchDetailsResult(launch, agency);
  }
}

class LaunchDetailsResult {
  final Launch launch;
  final Agency? agency;

  LaunchDetailsResult(this.launch, this.agency);
}