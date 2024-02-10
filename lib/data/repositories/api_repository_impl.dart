import '../../domain/entities/agency.dart';
import '../../domain/entities/launch.dart';
import '../../domain/entities/rocket_configuration.dart';
import '../../domain/repositories/api_repository.dart';
import '../data sources/remote/api_client.dart';

class ApiRepositoryImpl implements ApiRepository {
  final ApiClient _apiClient;

  ApiRepositoryImpl(this._apiClient);

  @override
  Future<List<Launch>> getLaunchList() async {
    final response = await _apiClient.get('/launch/');
    return _convertLaunchJsonList(response.data["results"]);
  }

  @override
  Future<List<Launch>> getUpcomingLaunchList() async {
    final response = await _apiClient.get('/launch/upcoming/');
    return _convertLaunchJsonList(response.data["results"]);
  }

  @override
  Future<Launch> getLaunchDetailsById(String id) async {
    final response = await _apiClient.get('/launch/$id/');
    return _convertLaunchJson(response.data);
  }

  @override
  Future<Agency?> getAgencyById(int? id) async {
    if (id == null) return null;
    final response = await _apiClient.get('/agencies/$id/');
    return _convertAgencyJson(response.data);
  }

  Future<List<Launch>> _convertLaunchJsonList(
      List<dynamic> launchJsonList) async {
    try {
      final launchList = await Future.wait(
        launchJsonList.map(
          (json) async {
            final rocketConfiguration = await _getRocketConfigurationById(
                json["rocket"]["configuration"]["id"]);

            Launch launch = Launch.fromJson(json);
            launch.rocket.configuration = rocketConfiguration;

            return launch;
          },
        ).toList(),
      );
      return launchList;
    } catch (e) {
      // How to handle errors here?
    }
    return [];
  }

  Future<RocketConfiguration> _getRocketConfigurationById(int id) async {
    final response = await _apiClient.get("/config/launcher/$id");
    return RocketConfiguration.fromJson(response.data);
  }

  Launch _convertLaunchJson(Map<String, dynamic> json) {
    // Additional processing can be done here if necessary
    return Launch.fromJson(json);
  }

  Agency? _convertAgencyJson(Map<String, dynamic> json) {
    return Agency.fromJson(json);
  }
}
