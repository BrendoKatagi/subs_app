import 'package:equatable/equatable.dart';

class ActivePlan extends Equatable {
  final String? userName;
  final String? title;
  final String? userSubscriptionPlanId;
  final int? available;
  final int? done;
  final int? expired;
  final DateTime? start;
  final DateTime? end;
  final int? price;
  final bool? active;

  const ActivePlan({
    this.userName,
    this.title,
    this.userSubscriptionPlanId,
    this.available,
    this.done,
    this.expired,
    this.start,
    this.end,
    this.price,
    this.active,
  });

  factory ActivePlan.fromJson(Map<String, dynamic> json) => ActivePlan(
        userName: json['userName'] as String?,
        title: json['title'] as String?,
        userSubscriptionPlanId: json['userSubscriptionPlanId'] as String?,
        available: json['available'] as int?,
        done: json['done'] as int?,
        expired: json['expired'] as int?,
        start: json['start'] == null ? null : DateTime.parse(json['start'] as String),
        end: json['end'] == null ? null : DateTime.parse(json['end'] as String),
        price: json['price'] as int?,
        active: json['active'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'userName': userName,
        'title': title,
        'userSubscriptionPlanId': userSubscriptionPlanId,
        'available': available,
        'done': done,
        'expired': expired,
        'start': start?.toIso8601String(),
        'end': end?.toIso8601String(),
        'price': price,
        'active': active,
      };

  ActivePlan copyWith({
    String? userName,
    String? title,
    String? userSubscriptionPlanId,
    int? available,
    int? done,
    int? expired,
    DateTime? start,
    DateTime? end,
    int? price,
    bool? active,
  }) {
    return ActivePlan(
      userName: userName ?? this.userName,
      title: title ?? this.title,
      userSubscriptionPlanId: userSubscriptionPlanId ?? this.userSubscriptionPlanId,
      available: available ?? this.available,
      done: done ?? this.done,
      expired: expired ?? this.expired,
      start: start ?? this.start,
      end: end ?? this.end,
      price: price ?? this.price,
      active: active ?? this.active,
    );
  }

  @override
  List<Object?> get props {
    return [
      userName,
      title,
      userSubscriptionPlanId,
      available,
      done,
      expired,
      start,
      end,
      price,
      active,
    ];
  }
}
