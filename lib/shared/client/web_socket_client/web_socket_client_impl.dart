import 'package:get_it/get_it.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:substore_app/config/environment/environment_properties.dart';

import 'package:substore_app/shared/client/web_client/web_socket_client.dart';

class IOWebSocketClient implements WebSocketClient {
  IO.Socket? _socket;

  @override
  void connect(String url) {
    final EnvironmentProperties environmentProperties = GetIt.I.get<EnvironmentProperties>();
    _socket = IO.io(environmentProperties.baseUrl, <String, dynamic>{
      'path': url,
      'transports': ['websocket'],
      'autoConnect': false,
    });

    _socket?.connect();
  }

  @override
  void disconnect() {
    _socket?.disconnect();
  }

  @override
  void subscribeToEvent({required String event, required Map<String, String> data}) {
    _socket?.emit(event, data);
  }

  @override
  void onEvent({required String event, required void Function(dynamic) callback}) {
    _socket?.on(event, callback);
  }
}
