import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:project_kepler/data/data%20sources/remote/api_client.dart';

@module
abstract class ApiClientModule {
  @singleton
  Dio get dio => Dio();

  @singleton
  ApiClient apiClient(Dio dio) => ApiClient(
        dio,
        dotenv.env['CORE_API_URL']!,
      );
}
