import 'package:dio/dio.dart';
import 'package:substore_app/shared/client/web_client/web_client.dart';

extension DioResponseTypeExtension on ResponseType {
  ResponseDataType get toResponseDataType =>
      ResponseDataType.values.firstWhere((element) => element.name == name);
}
