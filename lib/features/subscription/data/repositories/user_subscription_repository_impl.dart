import 'dart:ui';

import 'package:substore_app/features/subscription/data/datasources/user_subscription_remote_datasource.dart';
import 'package:substore_app/features/subscription/domain/entities/store.dart';
import 'package:substore_app/features/subscription/domain/repositories/user_subscription_repository.dart';

class UserSubscriptionRepositoryImpl extends UserSubscriptionRepository {
  final UserSubscriptionRemoteDatasource remoteDatasource;

  UserSubscriptionRepositoryImpl({required this.remoteDatasource});

  @override
  Future<List<Store>> getUserSubscriptions() async {
    return remoteDatasource.getUserSubscriptions();
  }

  @override
  void subscribeToCheckinWebSocket({required String checkinId, required VoidCallback onSuccess, required VoidCallback onError}) {
    remoteDatasource.subscribeToCheckinWebSocket(checkinId: checkinId, onSuccess: onSuccess, onError: onError);
  }

  @override
  void cancelSubscription() => remoteDatasource.cancelSubscription();
}
