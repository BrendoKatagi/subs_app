part of 'web_client.dart';

class ClientResponse extends Equatable {
  final ResponseData? responseData;
  final Map<String, List<String>> headers;
  final int statusCode;

  const ClientResponse({
    required this.statusCode,
    this.headers = const <String, List<String>>{},
    this.responseData,
  });

  @override
  List<Object?> get props => <Object?>[
        responseData,
        headers,
        statusCode,
      ];
}
