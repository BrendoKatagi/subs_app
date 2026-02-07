import 'package:dio/dio.dart';
import 'package:substore_app/shared/client/extensions/dio_response_type_extension.dart';
import 'package:substore_app/shared/client/web_client/web_client.dart';

extension DioResponseExtension on Response<dynamic> {
  ClientResponse get toClientResponse => ClientResponse(
        statusCode: statusCode!,
        responseData: data == null
            ? null
            : ResponseData(
                data: data,
                type: requestOptions.responseType.toResponseDataType,
              ),
        headers: headers.map,
      );
}
