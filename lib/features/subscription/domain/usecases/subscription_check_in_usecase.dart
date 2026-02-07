import 'dart:ui';

import 'package:substore_app/features/subscription/domain/repositories/user_subscription_repository.dart';

class SubscriptionCheckInUseCase {
  final UserSubscriptionRepository userSubscriptionRepository;

  SubscriptionCheckInUseCase({required this.userSubscriptionRepository});

  void call({required String checkinId, required VoidCallback onSuccess, required VoidCallback onError}) =>
      userSubscriptionRepository.subscribeToCheckinWebSocket(checkinId: checkinId, onSuccess: onSuccess, onError: onError);
  void cancelSubscription() => userSubscriptionRepository.cancelSubscription();
}
