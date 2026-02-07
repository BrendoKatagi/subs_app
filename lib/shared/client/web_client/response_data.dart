part of 'web_client.dart';

enum ResponseDataType {
  json,
  stream,
  plain,
  bytes;
}

class ResponseData extends Equatable {
  final dynamic data;
  final ResponseDataType type;

  const ResponseData({required this.data, required this.type});

  @override
  List<Object?> get props => [
        data,
        type,
      ];
}
