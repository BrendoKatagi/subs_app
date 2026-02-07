import 'package:substore_app/features/subscription/domain/entities/subscription_ticket.dart';

class CheckIn extends SubscriptionTicket {
  final String userName;

  const CheckIn({
    required this.userName,
    required super.id,
    required super.title,
    required super.subscriptionTicketStats,
    super.checkInData,
    super.checkInDateTime,
    super.storeHours,
  });

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
