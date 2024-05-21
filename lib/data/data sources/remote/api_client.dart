import 'package:dio/dio.dart';
import 'package:project_kepler/core/global.dart';
import 'package:project_kepler/core/utils/cache_interceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  final Dio _dio;
  final String _baseUrl;
  final String apiKey;

  ApiClient(this._dio, this._baseUrl, {this.apiKey = ''}) {
    final sp = SharedPreferences.getInstance();
    sp.then((sharedPrefs) {
      // _dio.interceptors.add(CacheInterceptor(sharedPrefs));
    });
  }

  Future<Response> get(String path) async {
    // logger.d('GET: $_baseUrl$path');
    try {
      if (apiKey.isNotEmpty) {
        logger.d('API Key: $apiKey');
        _dio.options.headers['Authorization'] = apiKey;
      }
      final response = await _dio.get('$_baseUrl$path');
      _handleResponse(response);
      return response;
    } on DioException catch (dioError) {
      throw _handleError(dioError);
    }
  }

  void _handleResponse(Response response) {
    if (response.statusCode != 200) {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  Exception _handleError(DioException dioError) {
    return Exception(dioError.message);
  }
}
