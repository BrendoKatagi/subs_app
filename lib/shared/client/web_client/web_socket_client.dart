abstract class WebSocketClient {
  void connect(String url);
  void disconnect();
  void subscribeToEvent({required String event, required Map<String, String> data});
  void onEvent({required String event, required void Function(dynamic) callback});
}
