import 'dart:io';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:mediclica/core/constants/apis_url.dart';

import 'cache_storage_services.dart';

final Logger logger = Logger();

class DioServices {
  static DioServices? _instance;

  DioServices._();

  factory DioServices() => _instance ??= DioServices._();

  Dio? dio;

  init() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiUrls.baseUrl,
        receiveDataWhenStatusError: true,
      ),
    );
  }

  // Replace this function with your actual implementation to get the bearer token from cache
  String getBearerTokenFromCache() {
    return CacheHelper.getData(key: "barrierToken");
  }

  Map<String, dynamic> get _baseHeader {
    String? token = getBearerTokenFromCache();

    Map<String, dynamic> headers = {
      'lang': 'en',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    // if (token != null && token.isNotEmpty) {
    //   headers['Authorization'] = 'Bearer $token';
    // }

    return headers;
  }

  Future<Response> get({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
  }) async {
    logger.d(
        "============== GET METHOD ================= \n URL: ($url) \n Parameters: $data");
    return await dio!.get(
      url,
      data: data,
      queryParameters: query,
      cancelToken: cancelToken,
      options: Options(headers: headers ?? _baseHeader),
    );
  }

  Future<Response> post({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
  }) async {
    logger.d(
        "============== POST METHOD ================= \n URL: ($url) \n Parameters: $data");
    logger.d("============== POST METHOD ================= \n URL: ($url) \n "
        "Parameters: $query");
    return await dio!.post(
      ///
      url,
      data: data,
      queryParameters: query,
      cancelToken: cancelToken,
      options: Options(headers: headers),
    );
  }

  Future<Response> put({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
  }) async {
    logger.d(
        "============== PUT METHOD ================= \n URL: ($url) \n Parameters: $data");
    return await dio!.put(
      url,
      data: data,
      queryParameters: query,
      cancelToken: cancelToken,
      options: Options(headers: headers ?? _baseHeader),
    );
  }

  Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
  }) async {
    logger.d(
        "============== DELETE METHOD ================= \n URL: ($url) \n Parameters: $data");
    return await dio!.delete(
      url,
      data: data,
      queryParameters: query,
      cancelToken: cancelToken,
      options: Options(headers: headers ?? _baseHeader),
    );
  }

  Future<Response?> postVerification({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
  }) async {
    return await dio!.post(
      url,
      data: data,
      queryParameters: query,
      cancelToken: cancelToken,
      options: Options(headers: headers ?? _baseHeader),
    );
  }

  Future<Response?> postImage({
    String? contentype,
    required String url,
    required var data,
    Map<String, dynamic>? query,
  }) async {
    return await dio!.post(
      url,
      queryParameters: query,
      data: data,
      options: Options(
        headers: {
          HttpHeaders.contentTypeHeader: contentype,
        },
      ),
    );
  }
}
