import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

class ApiService {
  ApiService._internal();
  static final ApiService _apiService = ApiService._internal();
  static final Dio _dio = Dio();

  static const String _baseUrl = 'https://quote-garden.herokuapp.com/api/v3';
  static String _accessToken;

  Dio get dio => _dio ?? Dio();
  String get baseUrl => _baseUrl;

  set accessToken(String value) {
    if (value != null) _accessToken = value;
  }

  factory ApiService() {
    // Set default configs
    _dio.options.baseUrl = _baseUrl;
    _dio.options.connectTimeout = 100000; //60s -> 10s // test: remove 0
    _dio.options.receiveTimeout = 3000;

    // OR
    // _dio.options.headers['Content-Type'] = 'application/json';
    _dio.options.contentType = 'application/json';

    // Handshake error in client : CERTIFICATE_VERIFY_FAILED Self signed certificate in android
    if (Platform.isAndroid) {
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
    }

    return _apiService;
  }

  void _onRequest(String route) {
    print('_onRequest: -> ' + route);

    if (route is String) {}
  }

  Future<ApiResponse> _onError(error) async {
    // developer.log('onError:', name: 'api', error: error);
    print('_onError: -> ');
    print(error);
    if (error is AppException) {
      return Future.error(ApiResponse.error(error, 1));
    }
    return Future.error(error);
  }

  Future<ApiResponse> _onResponse(Response response) {
    print('_onResponse: -> ');
    print(response);

    switch (response.statusCode) {
      case 200:
        if (response.data is Map) {
          if ((response.data as Map).isEmpty) {
            // When error: empty json
            return _onError(InvalidResponseException(response.data.toString()));
          }

          // When success
          // final responseJson = json.decode(response.data);
          if (response.data['success'] != null) {
            // continue with succes
            return Future.value(
              ApiResponse.success(
                response.data['success'],
              ),
            );
          }

          if (response.data['error'] != null) {
            // continue error code
            return Future.value(
              ApiResponse.error(
                response.data['error'],
                response.data['error']['code'],
              ),
            );
          }
        }
        // others: external endpoints
        return Future.value(ApiResponse.success(response));

      case 400:
        return _onError(BadRequestException(response.data.toString()));
      case 401:
      case 403:
        return _onError(UnauthorisedException(response.data.toString()));
      case 500:
      default:
        return _onError(FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}'));
    }
  }

  Future<ApiResponse> get(route, params) async {
    return this._request(route, params, 'GET');
  }

  Future<ApiResponse> post(route, params) async {
    return this._request(route, params, 'POST');
  }

  Future<ApiResponse> put(route, params) async {
    return this._request(route, params, 'PUT');
  }

  void initInterceptors() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (Options options) async {
        return options; //continue
      },
      onResponse: (Response response) async {
        return _onResponse(response); // continue
        // return response; // continue
      },
      onError: (DioError e) async {
        // Do something with response error
        return _onError(e);
        // return e; //continue
      },
    ));
    // to print request/response log automaticlly
    // _dio.interceptors.add(LogInterceptor()); // responseBody: false
  }

  Future<ApiResponse> _request(route, params, verb) async {
    print('_request');
    try {
      _onRequest(route);
      print(params);
      // Add only one interceptor
      if (_dio.interceptors.isEmpty) {
        initInterceptors();
      }
      // Set method
      _dio.options.method = verb;
      // _dio.options.headers['Authorization'] = 'Bearer $_accessToken';
      // print('Authorization2 = ${_dio.options.headers['Authorization']}');
      // Fetch api
      // final , dynamic, var
      final response = await _dio.request(
        route,
        data: params,
        // options: Options(method: verb),
      );
      // Do somthing and return
      //
      return response.data;
    } catch (e) {
      return _onError(FetchDataException(e.toString()));
    }
  }
}

class ApiResponse {
  ApiResponse.success(this.data) : status = ApiStatus.success;
  ApiResponse.error(this.error, this.errorCode) : status = ApiStatus.error;

  ApiStatus status;
  dynamic data; // response.data.success
  dynamic error; // response.data.error
  int errorCode; // response.data.error.code

  @override
  String toString() {
    return 'Status : $status \n errorCode : $errorCode \n Data : $data \n Error : $error';
  }
}

enum ApiStatus { success, error }

class AppException implements Exception {
  AppException([this._message, this._prefix]);
  final _message;
  final _prefix;

  @override
  String toString() {
    return '$_prefix$_message';
  }
}

class FetchDataException extends AppException {
  FetchDataException([String message])
      : super(message, 'Error During Communication: ');
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, 'Invalid Request: ');
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message, 'Unauthorised: ');
}

class InvalidResponseException extends AppException {
  InvalidResponseException([String message])
      : super(message, 'Invalid Response: ');
}
