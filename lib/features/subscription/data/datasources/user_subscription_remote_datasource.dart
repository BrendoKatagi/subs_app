import 'dart:ui';

import 'package:substore_app/features/subscription/data/client/user_subscription_client.dart';
import 'package:substore_app/features/subscription/data/models/store_model.dart';
import 'package:substore_app/features/subscription/domain/entities/store.dart';
import 'package:substore_app/shared/models/list_model_helper.dart';

abstract class UserSubscriptionRemoteDatasource {
  Future<List<Store>> getUserSubscriptions();
  void subscribeToCheckinWebSocket({required String checkinId, required VoidCallback onSuccess, required VoidCallback onError});
  void cancelSubscription();
}

class UserSubscriptionRemoteDatasourceImpl implements UserSubscriptionRemoteDatasource {
  final UserSubscriptionClient client;

  UserSubscriptionRemoteDatasourceImpl({required this.client});

  Store _parseToStoreEntity(dynamic item) => StoreModel.fromJson(item as Map<String, dynamic>).toEntity();

  @override
  Future<List<Store>> getUserSubscriptions() async {
    final jsonData = await client.getUserSubscriptions();
    final userSubscriptions = ListModelHelper.getListFromData<Store>(
      jsonData,
      _parseToStoreEntity,
    );

    return userSubscriptions;
  }

  @override
  void subscribeToCheckinWebSocket({required String checkinId, required VoidCallback onSuccess, required VoidCallback onError}) {
    client.subscribeToCheckinWebSocket(checkinId: checkinId, onSuccess: onSuccess, onError: onError);
  }

  @override
  void cancelSubscription() => client.cancelSubscription();
}
