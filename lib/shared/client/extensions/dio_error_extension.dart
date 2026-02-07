import 'dart:io';

import 'package:dio/dio.dart';
import 'package:substore_app/shared/client/web_client/web_client.dart';
import 'package:substore_app/shared/errors/client_exceptions.dart';

extension DioErrorException on DioException {
  ClientException toClientException({
    required ClientResponse Function(Response<dynamic>) handleResponse,
  }) {
    ClientResponse? clientResponse;

    if (response != null) {
      clientResponse = handleResponse(response!);
    }

    if (error is SocketException) {
      return NetworkClientException(response: clientResponse);
    } else {
      return GenericClientException(response: clientResponse);
    }
  }
}
