// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_plan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscriptionPlanModel _$SubscriptionPlanModelFromJson(
        Map<String, dynamic> json) =>
    SubscriptionPlanModel(
      id: json['id'] as String,
      title: json['title'] as String,
      subscriptionStats:
          $enumDecode(_$SubscriptionStatsEnumMap, json['subscriptionStats']),
      monthlyPrice: (json['monthlyPrice'] as num).toDouble(),
      description: json['description'] as String?,
      subscriptionTickets: (json['subscriptionTickets'] as List<dynamic>?)
          ?.map((e) =>
              SubscriptionTicketModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SubscriptionPlanModelToJson(
        SubscriptionPlanModel instance) =>
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
