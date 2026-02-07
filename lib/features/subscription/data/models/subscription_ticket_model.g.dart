// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_ticket_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscriptionTicketModel _$SubscriptionTicketModelFromJson(
        Map<String, dynamic> json) =>
    SubscriptionTicketModel(
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
      expireDate: _$JsonConverterFromJson<String, DateTime>(
          json['expireDate'], const TimezoneDateTimeConverter().fromJson),
    );

Map<String, dynamic> _$SubscriptionTicketModelToJson(
        SubscriptionTicketModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'subscriptionTicketStats':
          _$SubscriptionTicketStatsEnumMap[instance.subscriptionTicketStats]!,
      'checkInData': instance.checkInData,
      'checkInDateTime': _$JsonConverterToJson<String, DateTime>(
          instance.checkInDateTime, const TimezoneDateTimeConverter().toJson),
      'storeHours': instance.storeHours,
      'expireDate': _$JsonConverterToJson<String, DateTime>(
          instance.expireDate, const TimezoneDateTimeConverter().toJson),
    };

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

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
