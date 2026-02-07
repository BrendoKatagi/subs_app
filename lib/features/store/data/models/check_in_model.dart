import 'package:json_annotation/json_annotation.dart';
import 'package:substore_app/features/store/domain/entities/check_in.dart';
import 'package:substore_app/features/subscription/data/models/subscription_ticket_model.dart';
import 'package:substore_app/features/subscription/domain/entities/enum/subscription_ticket_stats.dart';
import 'package:substore_app/shared/models/timezone_date_time_converter.dart';

part 'check_in_model.g.dart';

@TimezoneDateTimeConverter()
@JsonSerializable(createToJson: false)
class CheckInModel extends SubscriptionTicketModel {
  final String userName;

  const CheckInModel({
    required this.userName,
    required super.id,
    required super.title,
    required super.subscriptionTicketStats,
    super.checkInData,
    super.checkInDateTime,
    super.storeHours,
  });

  factory CheckInModel.fromJson(Map<String, dynamic> json) => _$CheckInModelFromJson(json);

  @override
  CheckIn toEntity() => CheckIn(
        userName: userName,
        id: id,
        title: title,
        subscriptionTicketStats: subscriptionTicketStats,
        checkInData: checkInData,
        checkInDateTime: checkInDateTime,
        storeHours: storeHours,
      );

  @override
  List<Object?> get props => [
        userName,
        id,
        title,
        subscriptionTicketStats,
        checkInData,
        checkInDateTime,
        storeHours,
      ];
}
