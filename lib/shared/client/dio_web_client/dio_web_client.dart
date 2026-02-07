// ignore_for_file: only_throw_errors, inference_failure_on_function_invocation

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:substore_app/config/environment/environment_properties.dart';
import 'package:substore_app/shared/client/extensions/dio_error_extension.dart';
import 'package:substore_app/shared/client/extensions/dio_response_extension.dart';
import 'package:substore_app/shared/client/web_client/web_client.dart';
import 'package:substore_app/typedefs.dart';

enum WebClientMethod {
  get,
  put,
  post,
  patch,
  delete,
}

class DioWebClient implements WebClient {
  final Dio _dio;

  DioWebClient(this._dio);

  @override
  Future<ClientResponse> delete(
    String path, {
    JsonObject? data,
    JsonObject? headers,
    Map<String, dynamic>? queryParameters,
  }) =>
      _dio
          .delete(
            path,
            data: data,
            options: Options(headers: headers ?? <String, dynamic>{}),
            queryParameters: queryParameters,
          )
          .then(_handleResponse)
          .catchError(_handleError);

  @override
  Future<ClientResponse> get(
    String path, {
    JsonObject? headers,
    Map<String, dynamic>? queryParameters,
  }) =>
      _dio
          .get(
            path,
            options: Options(headers: headers ?? <String, dynamic>{}),
            queryParameters: queryParameters,
          )
          .then(_handleResponse)
          .catchError(_handleError);

  @override
  Future<ClientResponse> patch(
    String path, {
    JsonObject? data,
    JsonObject? headers,
    Map<String, dynamic>? queryParameters,
  }) =>
      _dio
          .patch(
            path,
            data: data,
            options: Options(headers: headers ?? <String, dynamic>{}),
            queryParameters: queryParameters,
          )
          .then(_handleResponse)
          .catchError(_handleError);

  @override
  Future<ClientResponse> post(
    String path, {
    JsonObject? data,
    JsonObject? headers,
    Map<String, dynamic>? queryParameters,
  }) =>
      _dio
          .post(
            path,
            data: data,
            options: Options(headers: headers ?? <String, dynamic>{}),
            queryParameters: queryParameters,
          )
          .then(_handleResponse)
          .catchError(_handleError);

  @override
  Future<ClientResponse> put(
    String path, {
    JsonObject? data,
    JsonObject? headers,
    Map<String, dynamic>? queryParameters,
  }) =>
      _dio
          .put(
            path,
            data: data,
            options: Options(headers: headers ?? <String, dynamic>{}),
            queryParameters: queryParameters,
          )
          .then(_handleResponse)
          .catchError(_handleError);

  @override
  Future<ClientResponse> download(
    String path, {
    required String savePath,
    JsonObject? data,
    JsonObject? headers,
    Map<String, dynamic>? queryParameters,
  }) =>
      _dio
          .download(
            path,
            savePath,
            data: data,
            options: Options(headers: headers ?? <String, dynamic>{}),
            queryParameters: queryParameters,
          )
          .then(_handleResponse)
          .catchError(_handleError);

  ClientResponse _handleResponse(Response<dynamic> response) {
    return response.toClientResponse;
  }

  Never _handleError(Object error) {
    if (error is DioException) {
      throw error.toClientException(handleResponse: _handleResponse);
    } else {
      throw error;
    }
  }

  @override
  DioWebClient getNewInstance() {
    final EnvironmentProperties environmentProperties = GetIt.I.get<EnvironmentProperties>();
    return DioWebClient(Dio(BaseOptions(
      baseUrl: environmentProperties.baseUrl,
    )));
  }
}
