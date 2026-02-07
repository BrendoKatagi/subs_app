import 'package:equatable/equatable.dart';
import 'package:substore_app/features/subscription/domain/entities/enum/subscription_ticket_stats.dart';
import 'package:substore_app/features/subscription/domain/entities/subscription_plan.dart';

class StatsFilterState extends Equatable {
  final SubscriptionTicketStats stats;
  final List<SubscriptionPlan> subscriptionPlans;

  const StatsFilterState({
    required this.stats,
    required this.subscriptionPlans,
  });

  @override
  List<Object?> get props => [stats, subscriptionPlans];
}

class StatsFilterInitial extends StatsFilterState {
  const StatsFilterInitial(List<SubscriptionPlan> subscriptionPlans)
      : super(
          stats: SubscriptionTicketStats.available,
          subscriptionPlans: subscriptionPlans,
        );
}
