import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:substore_app/features/subscription/domain/entities/enum/subscription_ticket_stats.dart';
import 'package:substore_app/shared/models/timezone_date_time_converter.dart';

part 'subscription_ticket.g.dart';

@JsonSerializable()
class SubscriptionTicket extends Equatable {
  final String id;
  final String title;
  final SubscriptionTicketStats subscriptionTicketStats;
  final String? checkInData;
  @TimezoneDateTimeConverter()
  final DateTime? checkInDateTime;
  final List<String>? storeHours;
  @TimezoneDateTimeConverter()
  final DateTime? expireDate;

  const SubscriptionTicket({
    required this.id,
    required this.title,
    required this.subscriptionTicketStats,
    this.checkInData,
    this.checkInDateTime,
    this.storeHours,
    this.expireDate,
  });

  factory SubscriptionTicket.fromJson(Map<String, dynamic> json) => _$SubscriptionTicketFromJson(json);

  Map<String, dynamic> toJson() => _$SubscriptionTicketToJson(this);

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
