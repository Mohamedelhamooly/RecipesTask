import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'package:posts_task/layers/data/source/local/local_storage.dart';
import 'package:posts_task/layers/data/source/remote/app_endpoints.dart';

import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String APPLICATION_JSON = 'application/json';
const String CONTENT_TYPE = 'content-type';
const String ACCEPT = 'accept';
// const String AUTHORIZATION = 'Authorization';
const String AUTHORIZATION = 'Authorization';
const String DEFAULT_LANGUAGE = 'lang';
const String APP_ID = 'app-id';

class DioFactory {
  DioFactory(this._localStorage);

  final LocalStorage _localStorage;

  Future<Dio> getDio() async {
    final dio = Dio();

    // Add the DioTokenInterceptor to the Dio instance.
    dio.interceptors.add(DioTokenInterceptor());

    // final token = await _localStorage.getToken() ?? '';
    // final language = await _localStorage.getAppLanguage();
    final headers = <String, String>{
      // CONTENT_TYPE: APPLICATION_JSON,
      // ACCEPT: APPLICATION_JSON,
      // AUTHORIZATION: 'Bearer $token',
      // DEFAULT_LANGUAGE: language,
      APP_ID: '65f192f7e5c046f8c9037588'
    };

    dio.options = BaseOptions(
      baseUrl: AppEndPoints.baseUrl,
      headers: headers,
      receiveTimeout: const Duration(minutes: 1),
      sendTimeout: const Duration(minutes: 1),
    );

    if (!kReleaseMode) {
      // its debug mode so print app logs
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
        ),
      );
    }

    return dio;
  }
}

class DioTokenInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // final localStorage = getIt<LocalStorage>();
    //
    // // Get the token from shared preferences.
    // final token = await localStorage.getToken() ?? '';
    // // Get the language from shared preferences.
    // final lang = await localStorage.getAppLanguage();

    // Update the token and lang in the headers.
    // options.headers[AUTHORIZATION] = 'Bearer $token';
    // options.headers[DEFAULT_LANGUAGE] = lang;

    // Continue the request.
    handler.next(options);
  }
}
