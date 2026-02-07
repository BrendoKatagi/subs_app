import 'package:equatable/equatable.dart';
import 'package:substore_app/shared/client/web_client/web_client.dart';

class ClientException extends Equatable implements Exception {
  final ClientResponse? response;

  const ClientException({this.response});

  @override
  List<Object?> get props => [response];
}

class GenericClientException extends ClientException {
  const GenericClientException({super.response});
}

class NetworkClientException extends ClientException {
  const NetworkClientException({super.response});
}
