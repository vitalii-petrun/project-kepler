import 'package:dio/dio.dart';

class ApiClient {
  final Dio _dio;
  final String _baseUrl;

  ApiClient(this._dio, this._baseUrl);

  Future<Response> get(String path) async {
    try {
      final response = await _dio.get('$_baseUrl$path');
      _handleResponse(response);
      return response;
    } on DioError catch (dioError) {
      throw _handleError(dioError);
    }
  }

  // Add other HTTP methods as needed...

  void _handleResponse(Response response) {
    if (response.statusCode != 200) {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  Exception _handleError(DioError dioError) {
    // Handle different types of errors: network, HTTP, etc.
    // Convert DioError to a domain-specific error if needed
    return Exception(dioError.message);
  }
}
