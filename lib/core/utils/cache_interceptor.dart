import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:project_kepler/core/global.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CacheInterceptor extends Interceptor {
  final SharedPreferences sharedPreferences;

  CacheInterceptor(this.sharedPreferences);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final key = options.uri.toString();
    final cachedData = sharedPreferences.getString(key);

    if (cachedData != null) {
      final data = jsonDecode(cachedData);
      final expiryDate = DateTime.tryParse(data['expiryDate']);

      if (expiryDate != null && DateTime.now().isBefore(expiryDate)) {
        // If cached data is not expired, return it directly
        logger.d('Returning cached data');
        return handler.resolve(Response(
          requestOptions: options,
          statusCode: 200,
          data: data['data'],
        ));
      }
    }
    // No valid cached data, proceed with request
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    // Cache duration from .env file
    final cacheDuration = dotenv.env['CACHE_DURATION'];
    final duration = cacheDuration != null
        ? Duration(seconds: int.parse(cacheDuration))
        : const Duration(seconds: 60);

    final key = response.requestOptions.uri.toString();
    final data = {
      'data': response.data,
      'expiryDate': DateTime.now().add(duration).toIso8601String()
    };

    // Save data with timestamp to SharedPreferences
    await sharedPreferences.setString(key, jsonEncode(data));
    handler.next(response);
  }
}
