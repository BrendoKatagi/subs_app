import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:substore_app/features/subscription/domain/entities/enum/subscription_stats.dart';
import 'package:substore_app/features/subscription/domain/entities/enum/subscription_ticket_stats.dart';
import 'package:substore_app/features/subscription/domain/entities/subscription_ticket.dart';

part 'subscription_plan.g.dart';

@JsonSerializable()
class SubscriptionPlan extends Equatable {
  final String id;
  final String title;
  final double monthlyPrice;
  final SubscriptionStats subscriptionStats;
  final String? description;
  final List<SubscriptionTicket>? subscriptionTickets;

  const SubscriptionPlan({
    required this.id,
    required this.title,
    required this.monthlyPrice,
    required this.subscriptionStats,
    this.description,
    this.subscriptionTickets,
  });

  int get availableTickets => subscriptionTickets != null
      ? subscriptionTickets!
          .where(
            (element) =>
                element.subscriptionTicketStats ==
                SubscriptionTicketStats.available,
          )
          .length
      : 0;

  SubscriptionPlan copyWithTickets(
    List<SubscriptionTicket>? subscriptionTickets,
  ) =>
      SubscriptionPlan(
        id: id,
        title: title,
        monthlyPrice: monthlyPrice,
        subscriptionStats: subscriptionStats,
        description: description,
        subscriptionTickets: subscriptionTickets,
      );

  factory SubscriptionPlan.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionPlanFromJson(json);

  Map<String, dynamic> toJson() => _$SubscriptionPlanToJson(this);

  @override
  List<Object?> get props => [
        id,
        title,
        monthlyPrice,
        subscriptionStats,
        description,
        subscriptionTickets,
      ];
}
