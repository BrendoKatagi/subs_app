import 'dart:ui';
import 'package:substore_app/features/subscription/domain/entities/store.dart';

abstract class UserSubscriptionRepository {
  Future<List<Store>> getUserSubscriptions();
  void subscribeToCheckinWebSocket({required String checkinId, required VoidCallback onSuccess, required VoidCallback onError});
  void cancelSubscription();
}
