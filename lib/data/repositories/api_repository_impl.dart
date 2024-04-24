import 'dart:convert';

import 'package:project_kepler/core/global.dart';
import 'package:project_kepler/domain/converters/agency_converter.dart';
import 'package:project_kepler/domain/converters/event_converter.dart';
import 'package:project_kepler/domain/converters/launch_converter.dart';
import 'package:project_kepler/domain/entities/event.dart';

import '../../domain/entities/agency.dart';
import '../../domain/entities/launch.dart';
import '../../domain/repositories/api_repository.dart';
import '../data sources/remote/api_client.dart';
import '../models/agency_dto.dart';

class ApiRepositoryImpl implements ApiRepository {
  final ApiClient _apiClient;

  final LaunchDtoToEntityConverter _launchConverter;
  final EventDtoToEntityConverter _eventConverter;
  final AgencyDtoToEntityConverter _agencyConverter;

  ApiRepositoryImpl(this._apiClient, this._launchConverter,
      this._eventConverter, this._agencyConverter);

  @override
  Future<List<Launch>> getLaunchList() async =>
      _fetchItems('/launch/', _launchConverter);

  @override
  Future<List<Launch>> getUpcomingLaunchList() async =>
      _fetchItems('/launch/upcoming/', _launchConverter);

  @override
  Future<List<Event>> getAllEvents() async =>
      _fetchItems('/event/', _eventConverter);

  @override
  Future<Event> getEventById(String id) async =>
      (await _fetchItems('/event/$id/', _eventConverter)).first;

  @override
  Future<Launch> getLaunchDetailsById(String id) async {
    final launch = await _fetchItems('/launch/$id/', _launchConverter);
    return launch.first;
  }

  @override
  Future<Agency?> getAgencyById(int? id) async {
    try {
      if (id == null) return null;

      final response = await _apiClient.get('/agencies/$id/');
      final agencyDto = AgencyDTO.fromJson(response.data);

      return _agencyConverter.convert(agencyDto);
    } catch (e) {
      logger.e('Failed to fetch data: $e');
      throw Exception('Failed to fetch data: $e');
    }
  }

  Future<List<T>> _fetchItems<T>(
      String endpoint, Converter<dynamic, T> converter) async {
    try {
      final response = await _apiClient.get(endpoint);
      final itemList = (response.data["results"] as List)
          .map((item) => converter.convert(item))
          .toList();
      return itemList;
    } catch (e) {
      logger.e('Failed to fetch data: $e');
      throw Exception('Failed to fetch data: $e');
    }
  }
}
