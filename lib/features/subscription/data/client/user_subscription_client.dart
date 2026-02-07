import 'dart:ui';

import 'package:substore_app/shared/client/web_client/web_client.dart';
import 'package:substore_app/shared/client/web_client/web_socket_client.dart';
import 'package:substore_app/typedefs.dart';

abstract class UserSubscriptionClient {
  Future<JsonObject> getUserSubscriptions();
  void subscribeToCheckinWebSocket({required String checkinId, required VoidCallback onSuccess, required VoidCallback onError});
  void cancelSubscription();
}

class UserSubscriptionClientImpl implements UserSubscriptionClient {
  final WebClient client;
  final WebSocketClient webSocketClient;

  UserSubscriptionClientImpl({required this.client, required this.webSocketClient});

  @override
  Future<JsonObject> getUserSubscriptions() async {
    final response = await client.get('/user-subscription-plan');
    return response.responseData?.data as JsonObject;
  }

  @override
  void subscribeToCheckinWebSocket({required String checkinId, required VoidCallback onSuccess, required VoidCallback onError}) {
    webSocketClient
      ..connect('/qrcode/checkin')
      ..subscribeToEvent(event: 'join', data: {'checkInId': checkinId})
      ..onEvent(event: 'success', callback: (_) => onSuccess())
      ..onEvent(event: 'checkin-error', callback: (_) => onError());
  }

  @override
  void cancelSubscription() {
    webSocketClient.disconnect();
  }
}
