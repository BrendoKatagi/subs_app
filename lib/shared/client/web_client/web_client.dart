import 'package:equatable/equatable.dart';
import 'package:substore_app/typedefs.dart';

part 'response.dart';
part 'response_data.dart';

abstract class WebClient {
  Future<ClientResponse> get(
    String path, {
    JsonObject? headers,
    Map<String, dynamic>? queryParameters,
  });

  Future<ClientResponse> put(
    String path, {
    JsonObject? data,
    JsonObject? headers,
    Map<String, dynamic>? queryParameters,
  });

  Future<ClientResponse> post(
    String path, {
    JsonObject? data,
    JsonObject? headers,
    Map<String, dynamic>? queryParameters,
  });

  Future<ClientResponse> patch(
    String path, {
    JsonObject? data,
    JsonObject? headers,
    Map<String, dynamic>? queryParameters,
  });

  Future<ClientResponse> delete(
    String path, {
    JsonObject? data,
    JsonObject? headers,
    Map<String, dynamic>? queryParameters,
  });

  Future<ClientResponse> download(
    String path, {
    required String savePath,
    JsonObject? data,
    JsonObject? headers,
    Map<String, dynamic>? queryParameters,
  });

  WebClient getNewInstance();
}
