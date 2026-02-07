// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_in_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckInModel _$CheckInModelFromJson(Map<String, dynamic> json) => CheckInModel(
      userName: json['userName'] as String,
      id: json['id'] as String,
      title: json['title'] as String,
      subscriptionTicketStats: $enumDecode(
          _$SubscriptionTicketStatsEnumMap, json['subscriptionTicketStats']),
      checkInData: json['checkInData'] as String?,
      checkInDateTime: _$JsonConverterFromJson<String, DateTime>(
          json['checkInDateTime'], const TimezoneDateTimeConverter().fromJson),
      storeHours: (json['storeHours'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

const _$SubscriptionTicketStatsEnumMap = {
  SubscriptionTicketStats.available: 'available',
  SubscriptionTicketStats.done: 'done',
  SubscriptionTicketStats.expired: 'expired',
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);
