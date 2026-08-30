import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../constant/app_constants.dart';
import '../di.dart';
import '../funcations/app_functions.dart';
import '../security/security_helper.dart';

class DioHelper {
  final Dio dio;

  DioHelper(this.dio);

  void setup() {
    dio.options = BaseOptions(
      baseUrl: AppConstants.baseUrl,
      receiveDataWhenStatusError: true,
    );

    if (!kReleaseMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
        ),
      );
    }
  }

  Future<void> headers({bool withAuth = false}) async {
    final token = getIt<AuthStorage>().token;
    final lang = AppFunctions.getLanguageCode();
    final tokenValue = token?.trim();
    final hasToken = tokenValue != null && tokenValue.isNotEmpty;

    dio.options.headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'locale': lang,
      if (withAuth && hasToken) 'Authorization': 'Bearer $tokenValue',
    };
  }

  Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    bool appendAuthParams = false,
    bool withAuth = false,
  }) async {
    await headers(withAuth: withAuth);

    final token = getIt<AuthStorage>().token;
    final userId = getIt<AuthStorage>().userId;
    final tokenValue = token?.trim();
    final hasToken = tokenValue != null && tokenValue.isNotEmpty;
    final userIdValue = userId?.trim();
    final hasUserId = userIdValue != null && userIdValue.isNotEmpty;

    final fullQuery = {
      if (appendAuthParams && hasToken && hasUserId) "access-token": tokenValue,
      if (appendAuthParams && hasToken && hasUserId) "id": userIdValue,
      if (query != null) ...query,
    };

    return dio.get(url, queryParameters: fullQuery.isEmpty ? null : fullQuery);
  }

  Future<Response> postData({
    required String url,
    required dynamic data,
    Map<String, dynamic>? query,
    bool appendAuthParams = false,
    bool withAuth = false,
  }) async {
    await headers(withAuth: withAuth);

    final token = getIt<AuthStorage>().token;
    final userId = getIt<AuthStorage>().userId;
    final tokenValue = token?.trim();
    final hasToken = tokenValue != null && tokenValue.isNotEmpty;
    final userIdValue = userId?.trim();
    final hasUserId = userIdValue != null && userIdValue.isNotEmpty;

    String finalUrl = url;
    if (appendAuthParams && hasToken && hasUserId) {
      finalUrl = "$url?access-token=$tokenValue&id=$userIdValue";
    }

    return dio.post(finalUrl, data: data, queryParameters: query);
  }

  Future<Response> putData({
    required String url,
    required dynamic data,
    Map<String, dynamic>? query,
  }) async {
    await headers();

    final token = getIt<AuthStorage>().token;
    final userId = getIt<AuthStorage>().userId;
    final tokenValue = token?.trim();
    final hasToken = tokenValue != null && tokenValue.isNotEmpty;
    final userIdValue = userId?.trim();
    final hasUserId = userIdValue != null && userIdValue.isNotEmpty;

    final finalUrl = (hasToken && hasUserId)
        ? "$url?access-token=$tokenValue&id=$userIdValue"
        : url;

    return dio.put(finalUrl, data: data, queryParameters: query);
  }

  Future<Response> putDataWithAuth({
    required String url,
    required dynamic data,
    Map<String, dynamic>? query,
    bool withAuth = false,
  }) async {
    await headers(withAuth: withAuth);

    final token = getIt<AuthStorage>().token;
    final userId = getIt<AuthStorage>().userId;
    final tokenValue = token?.trim();
    final hasToken = tokenValue != null && tokenValue.isNotEmpty;
    final userIdValue = userId?.trim();
    final hasUserId = userIdValue != null && userIdValue.isNotEmpty;

    String finalUrl = url;
    if (withAuth && hasToken && hasUserId) {
      finalUrl = "$url?access-token=$tokenValue&id=$userIdValue";
    }

    return dio.put(finalUrl, data: data, queryParameters: query);
  }

  Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    await headers();

    final token = getIt<AuthStorage>().token ?? '';
    final userId = getIt<AuthStorage>().userId ?? '';
    return dio.delete(
      "$url?access-token=$token&id=$userId",
      queryParameters: query,
    );
  }

  Future<Response> deleteDataWithAuth({
    required String url,
    dynamic data,
    Map<String, dynamic>? query,
    bool withAuth = false,
  }) async {
    await headers(withAuth: withAuth);

    return dio.delete(url, data: data, queryParameters: query);
  }

  Future<Response> patchData({
    required String url,
    dynamic data,
    Map<String, dynamic>? query,
    bool withAuth = false,
  }) async {
    await headers(withAuth: withAuth);
    return dio.patch(url, data: data, queryParameters: query);
  }

  Future<Response> postMultipartData({
    required String url,
    required FormData formData,
    bool withAuth = false,
  }) async {
    await headers(withAuth: withAuth);

    return dio.post(url, data: formData);
  }
}
