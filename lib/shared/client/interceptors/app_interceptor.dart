import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:substore_app/config/app_routes.dart';
import 'package:substore_app/features/auth/domain/usecases/refresh_token_usecase.dart';
import 'package:substore_app/shared/app_strings/app_strings.dart';
import 'package:substore_app/shared/storage/secure_storage.dart';

class AppInterceptor extends QueuedInterceptor {
  final String userSecureStorageKey;
  final SecureStorage secureStorage;

  AppInterceptor({
    required this.secureStorage,
    required this.userSecureStorageKey,
  });

  Future<String?> getUserToken() async {
    final userJson = await secureStorage.read(key: userSecureStorageKey);

    if (userJson != null) {
      return (jsonDecode(userJson) as Map<String, dynamic>)['token'] as String;
    }

    return null;
  }

  Future<String?> getRefreshToken() async {
    final userJson = await secureStorage.read(key: userSecureStorageKey);

    if (userJson != null) {
      return (jsonDecode(userJson) as Map<String, dynamic>)['refreshToken'] as String;
    }

    return null;
  }

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await getUserToken();

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
      options.headers['content-type'] = 'application/json';
    }

    return super.onRequest(options, handler);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    final bool isLoginRequest = err.requestOptions.path == AppStrings.login.loginRequestPath;
    final bool isUnauthorizedStatusCode = err.response?.statusCode == 401;
    if (!isLoginRequest && isUnauthorizedStatusCode) {
      try {
        await _refreshToken();

        final String? token = await getUserToken();

        if (token != null && token.isNotEmpty) {
          err.requestOptions.headers['Authorization'] = 'Bearer $token';
        }

        final Dio dio = Dio(BaseOptions(baseUrl: err.requestOptions.baseUrl));

        final Response<dynamic> response = await dio.request(
          err.requestOptions.path,
          cancelToken: err.requestOptions.cancelToken,
          data: err.requestOptions.data,
          queryParameters: err.requestOptions.queryParameters,
          options: Options(headers: err.requestOptions.headers),
        );

        return handler.resolve(response);
      } on DioException catch (error) {
        await redirectToLogin();
        return handler.reject(error);
      }
    } else {
      return super.onError(err, handler);
    }
  }

  Future<void> _refreshToken() async {
    try {
      final RefreshTokenUseCase refreshTokenUseCase = GetIt.I.get<RefreshTokenUseCase>();
      final String? refreshToken = await getRefreshToken();

      if (refreshToken == null) throw Exception('Refresh token inválido');

      await refreshTokenUseCase.call(refreshToken: refreshToken);
    } catch (e) {
      await redirectToLogin();
      rethrow;
    }
  }

  Future<void> redirectToLogin() async {
    await GetIt.I.get<SecureStorage>().deleteAll();
    AppRoutes.replaceToLoginPage();
  }
}
