import '../../domain/converters/agency_converter.dart';
import '../../domain/converters/launch_converter.dart';
import '../../domain/entities/agency.dart';
import '../../domain/entities/launch.dart';
import '../../domain/repositories/api_repository.dart';
import '../data sources/remote/api_client.dart';
import '../models/agency_dto.dart';
import '../models/launch_dto.dart';

class ApiRepositoryImpl implements ApiRepository {
  final ApiClient _apiClient;

  final launchDtoToEntityConverter = LaunchDtoToEntityConverter();
  final agencyDtoToEntityConverter = AgencyDtoToEntityConverter();

  ApiRepositoryImpl(this._apiClient);

  @override
  Future<List<Launch>> getLaunchList() async {
    final response = await _apiClient.get('/launch/');
    final launchDtoList = (response.data["results"] as List)
        .map((item) => LaunchDTO.fromJson(item))
        .toList();
    return launchDtoList.map(launchDtoToEntityConverter.convert).toList();
  }

  @override
  Future<List<Launch>> getUpcomingLaunchList() async {
    final response = await _apiClient.get('/launch/upcoming/');
    final launchDtoList = (response.data["results"] as List)
        .map((item) => LaunchDTO.fromJson(item))
        .toList();
    // Use the converter's convert method
    return launchDtoList.map(launchDtoToEntityConverter.convert).toList();
  }

  @override
  Future<Launch> getLaunchDetailsById(String id) async {
    final response = await _apiClient.get('/launch/$id/');
    final launchDto = LaunchDTO.fromJson(response.data);
    // Use the converter's convert method
    return launchDtoToEntityConverter.convert(launchDto);
  }

  @override
  Future<Agency?> getAgencyById(int? id) async {
    if (id == null) return null;
    final response = await _apiClient.get('/agencies/$id/');
    final agencyDto = AgencyDTO.fromJson(response.data);
    // Use the converter's convert method
    return agencyDtoToEntityConverter.convert(agencyDto);
  }
}
