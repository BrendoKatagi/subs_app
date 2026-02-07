// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_plan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscriptionPlan _$SubscriptionPlanFromJson(Map<String, dynamic> json) =>
    SubscriptionPlan(
      id: json['id'] as String,
      title: json['title'] as String,
      monthlyPrice: (json['monthlyPrice'] as num).toDouble(),
      subscriptionStats:
          $enumDecode(_$SubscriptionStatsEnumMap, json['subscriptionStats']),
      description: json['description'] as String?,
      subscriptionTickets: (json['subscriptionTickets'] as List<dynamic>?)
          ?.map((e) => SubscriptionTicket.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SubscriptionPlanToJson(SubscriptionPlan instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'monthlyPrice': instance.monthlyPrice,
      'subscriptionStats':
          _$SubscriptionStatsEnumMap[instance.subscriptionStats]!,
      'description': instance.description,
      'subscriptionTickets': instance.subscriptionTickets,
    };

const _$SubscriptionStatsEnumMap = {
  SubscriptionStats.available: 'available',
  SubscriptionStats.subscripted: 'subscripted',
};
