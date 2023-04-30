import 'package:dio/dio.dart';
import 'package:project_kepler/domain/entities/agency.dart';
import 'package:project_kepler/domain/entities/launch.dart';
import 'package:project_kepler/domain/entities/rocket_configuration.dart';

import 'package:project_kepler/domain/repositories/api_repository.dart';

class ApiRepositoryImpl implements ApiRepository {
  final _dio = Dio();
  final _baseUrl = 'https://lldev.thespacedevs.com/2.2.0';

  @override
  Future<List<Launch>> getLaunchList() async {
    final launchJsonList = await _getLaunchJsonList();
    final launchList = await _convertLaunchJsonList(launchJsonList);
    return launchList;
  }

  Future<List<dynamic>> _getLaunchJsonList() async {
    final response = await _dio.get("$_baseUrl/launch/upcoming/");
    if (response.statusCode == 200) {
      final launchList = response.data["results"] as List;

      return launchList;
    } else {
      throw Exception('Failed to load upcoming launch list');
    }
  }

  Future<List<Launch>> _convertLaunchJsonList(
      List<dynamic> launchJsonList) async {
    final launchList = await Future.wait(launchJsonList.map(
      (json) async {
        final rocketConfiguration = await getRocketConfigurationById(
            json["rocket"]["configuration"]["id"]);
        Launch launch = Launch.fromJson(json);
        launch.rocket.configuration = rocketConfiguration;
        print(
            "launch.rocket.configuration: ${launch.rocket.configuration.manufacturer?.foundingYear}");
        return launch;
      },
    ).toList());

    return launchList;
  }

  @override
  Future<RocketConfiguration> getRocketConfigurationById(int id) async {
    final rocketConfiguration = await _dio.get("$_baseUrl/config/launcher/$id");
    if (rocketConfiguration.statusCode == 200) {
      final rocket = RocketConfiguration.fromJson(rocketConfiguration.data);
      return rocket;
    } else {
      throw Exception('Failed to load rocket configuration');
    }
  }

  @override
  Future<Launch> getLaunchDetailsById(String id) async {
    final response = await _dio.get("$_baseUrl/launch/upcoming/$id/");
    if (response.statusCode == 200) {
      final launch = Launch.fromJson(response.data);
      return launch;
    } else if (response.statusCode == 404) {
      throw Exception('Launch not found');
    } else {
      throw Exception('Failed to load launch details');
    }
  }

  @override
  Future<Agency> getAgencyById(int id) async {
    final response = await _dio.get("$_baseUrl/agencies/$id/");
    if (response.statusCode == 200) {
      final agency = Agency.fromJson(response.data);
      return agency;
    } else {
      throw Exception('Failed to load agency details');
    }
  }
}
