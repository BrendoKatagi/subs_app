import 'package:substore_app/features/subscription/domain/entities/store.dart';
import 'package:substore_app/features/subscription/domain/repositories/user_subscription_repository.dart';

class GetUserSubscriptionsUseCase {
  final UserSubscriptionRepository userSubscriptionRepository;

  GetUserSubscriptionsUseCase({required this.userSubscriptionRepository});

  Future<List<Store>> call() =>
      userSubscriptionRepository.getUserSubscriptions();
}
