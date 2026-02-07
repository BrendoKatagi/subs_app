import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:substore_app/features/subscription/domain/entities/enum/subscription_ticket_stats.dart';
import 'package:substore_app/features/subscription/domain/entities/subscription_ticket.dart';
import 'package:substore_app/shared/models/timezone_date_time_converter.dart';

part 'subscription_ticket_model.g.dart';

@JsonSerializable()
class SubscriptionTicketModel extends Equatable {
  final String id;
  final String title;
  final SubscriptionTicketStats subscriptionTicketStats;
  final String? checkInData;
  @TimezoneDateTimeConverter()
  final DateTime? checkInDateTime;
  final List<String>? storeHours;
  @TimezoneDateTimeConverter()
  final DateTime? expireDate;

  const SubscriptionTicketModel({
    required this.id,
    required this.title,
    required this.subscriptionTicketStats,
    this.checkInData,
    this.checkInDateTime,
    this.storeHours,
    this.expireDate,
  });

  factory SubscriptionTicketModel.fromJson(Map<String, dynamic> json) => _$SubscriptionTicketModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubscriptionTicketModelToJson(this);

  SubscriptionTicket toEntity() => SubscriptionTicket(
        id: id,
        title: title,
        subscriptionTicketStats: subscriptionTicketStats,
        checkInDateTime: checkInDateTime,
        checkInData: checkInData,
        storeHours: storeHours,
        expireDate: expireDate,
      );

  @override
  List<Object?> get props => [
        id,
        title,
        subscriptionTicketStats,
        checkInData,
        checkInDateTime,
        storeHours,
        expireDate,
      ];
}
