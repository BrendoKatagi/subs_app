import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:substore_app/features/subscription/data/models/subscription_ticket_model.dart';
import 'package:substore_app/features/subscription/domain/entities/enum/subscription_stats.dart';
import 'package:substore_app/features/subscription/domain/entities/subscription_plan.dart';

part 'subscription_plan_model.g.dart';

@JsonSerializable()
class SubscriptionPlanModel extends Equatable {
  final String id;
  final String title;
  final double monthlyPrice;
  final SubscriptionStats subscriptionStats;
  final String? description;
  final List<SubscriptionTicketModel>? subscriptionTickets;

  const SubscriptionPlanModel({
    required this.id,
    required this.title,
    required this.subscriptionStats,
    required this.monthlyPrice,
    this.description,
    this.subscriptionTickets,
  });

  factory SubscriptionPlanModel.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionPlanModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubscriptionPlanModelToJson(this);

  SubscriptionPlan toEntity() => SubscriptionPlan(
        id: id,
        title: title,
        monthlyPrice: monthlyPrice,
        subscriptionStats: subscriptionStats,
        description: description,
        subscriptionTickets:
            subscriptionTickets?.map((e) => e.toEntity()).toList(),
      );

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
