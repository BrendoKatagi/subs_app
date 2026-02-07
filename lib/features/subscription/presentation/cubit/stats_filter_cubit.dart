import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:substore_app/features/subscription/domain/entities/enum/subscription_ticket_stats.dart';
import 'package:substore_app/features/subscription/domain/entities/subscription_plan.dart';
import 'package:substore_app/features/subscription/presentation/cubit/stats_filter_state.dart';

class StatsFilterCubit extends Cubit<StatsFilterState> {
  final List<SubscriptionPlan>? subscriptionPlans;

  StatsFilterCubit({required this.subscriptionPlans})
      : super(
          StatsFilterInitial(
            _filterPlansByStats(
              subscriptionPlans,
              SubscriptionTicketStats.available,
            ),
          ),
        );

  void filterPlansByStats(SubscriptionTicketStats selectedStats) {
    emit(
      StatsFilterState(
        stats: selectedStats,
        subscriptionPlans: _filterPlansByStats(
          subscriptionPlans,
          selectedStats,
        ),
      ),
    );
  }

  static List<SubscriptionPlan> _filterPlansByStats(
    List<SubscriptionPlan>? subscriptionPlans,
    SubscriptionTicketStats selectedStats,
  ) {
    final plans = <SubscriptionPlan>[];

    if (subscriptionPlans != null) {
      for (final plan in subscriptionPlans) {
        final tickets = plan.subscriptionTickets
            ?.where(
              (element) => element.subscriptionTicketStats == selectedStats,
            )
            .toList();

        if (tickets != null && tickets.isNotEmpty) {
          plans.add(plan.copyWithTickets(tickets));
        }
      }
    }

    return plans;
  }
}
