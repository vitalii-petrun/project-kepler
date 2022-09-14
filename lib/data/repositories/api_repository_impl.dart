import 'package:dio/dio.dart';
import 'package:project_kepler/domain/entities/launch.dart';

import 'package:project_kepler/domain/repositories/api_repository.dart';

class ApiRepositoryImpl implements ApiRepository {
  final _dio = Dio();
  late List<Launch> result;
  final _baseUrl = 'https://lldev.thespacedevs.com/2.2.0';
  @override
  Future<List<Launch>> getLaunchList() async {
    final response = await _dio.get(_baseUrl + "/launch/upcoming/");
    if (response.statusCode == 200) {
      final launchList = response.data["results"] as List;
      print(launchList);
      result = launchList.map((json) {
        print(Launch.fromJson(json));
        return Launch.fromJson(json);
      }).toList();
    } else {
    throw Exception('Failed to load launch list');
  }
    //print(result);
    return result;
  }
}
