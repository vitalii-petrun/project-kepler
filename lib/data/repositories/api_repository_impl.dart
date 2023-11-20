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

  @override
  Future<List<Launch>> getUpcomingLaunchList() async {
    final launchJsonList = await _getUpcomingLaunchJsonList();
    final launchList = await _convertLaunchJsonList(launchJsonList);
    return launchList;
  }

  @override
  Future<Launch> getLaunchDetailsById(String id) async {
    final launchJson = await _getLaunchJsonById(id);
    final launch = await _convertLaunchJson(launchJson);
    return launch;
  }

  @override
  Future<Agency?> getAgencyById(int? id) async {
    final agencyJson = await _getAgencyJsonById(id);
    final agency = await _convertAgencyJson(agencyJson);
    return agency;
  }

  Future<List<dynamic>> _getLaunchJsonList() async {
    final response = await _dio.get("$_baseUrl/launch/");
    if (response.statusCode == 200) {
      final launchList = response.data["results"] as List;
      return launchList;
    } else {
      throw Exception('Failed to load upcoming launch list');
    }
  }

  Future<List<dynamic>> _getUpcomingLaunchJsonList() async {
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
    try {
      final launchList = await Future.wait(launchJsonList.map(
        (json) async {
          final rocketConfiguration = await _getRocketConfigurationById(
              json["rocket"]["configuration"]["id"]);

          Launch launch = Launch.fromJson(json);
          launch.rocket.configuration = rocketConfiguration;

          return launch;
        },
      ).toList());
      return launchList;
    } catch (e) {
      print(e);
    }
    return [];
  }

  Future<RocketConfiguration> _getRocketConfigurationById(int id) async {
    final rocketConfiguration = await _dio.get("$_baseUrl/config/launcher/$id");
    if (rocketConfiguration.statusCode == 200) {
      final rocket = RocketConfiguration.fromJson(rocketConfiguration.data);
      return rocket;
    } else {
      throw Exception('Failed to load rocket configuration');
    }
  }

  Future<dynamic> _getLaunchJsonById(String id) async {
    final response = await _dio.get("$_baseUrl/launch/$id/");

    if (response.statusCode == 200) {
      return response.data;
    } else if (response.statusCode == 404) {
      throw Exception('Launch not found');
    } else {
      throw Exception('Failed to load launch details');
    }
  }

  Future<Launch> _convertLaunchJson(dynamic json) async {
    Launch launch = Launch.fromJson(json);

    return launch;
  }

  Future<dynamic> _getAgencyJsonById(int? id) async {
    if (id == null) {
      return null;
    }
    final response = await _dio.get("$_baseUrl/agencies/$id/");
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('Failed to load agency details');
    }
  }

  Future<Agency?> _convertAgencyJson(dynamic json) async {
    if (json == null) {
      return null;
    }
    Agency agency = Agency.fromJson(json);

    return agency;
  }
}
