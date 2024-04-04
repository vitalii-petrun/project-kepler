import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class ApiClient {
  final Dio _dio;
  final String _baseUrl;
  final String apiKey;

  ApiClient(this._dio, this._baseUrl, {this.apiKey = ''});

  Future<Response> get(String path) async {
    debugPrint('GET: $_baseUrl$path');
    try {
      if (apiKey.isNotEmpty) {
        debugPrint('API Key: $apiKey');
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
    // Handle different types of errors: network, HTTP, etc.
    // Convert DioError to a domain-specific error if needed
    return Exception(dioError.message);
  }
}
