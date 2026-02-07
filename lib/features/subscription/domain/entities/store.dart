import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:substore_app/features/subscription/domain/entities/enum/subscription_stats.dart';
import 'package:substore_app/features/subscription/domain/entities/subscription_plan.dart';

part 'store.g.dart';

@JsonSerializable()
class Store extends Equatable {
  final String id;
  final String? name;
  final String? profileImageUrl;
  final String? coverImageUrl;
  final String? bio;
  final String? pageUrl;
  final String? phone;
  final String? addressUrl;
  final double? rate;
  final List<SubscriptionPlan>? subscriptionPlans;

  const Store({
    required this.id,
    required this.name,
    required this.profileImageUrl,
    required this.coverImageUrl,
    required this.bio,
    this.pageUrl,
    this.phone,
    this.addressUrl,
    this.rate,
    this.subscriptionPlans,
  });

  List<SubscriptionPlan>? get availablePlans =>
      subscriptionPlans?.where((SubscriptionPlan plan) => plan.subscriptionStats == SubscriptionStats.subscripted).toList();

  factory Store.fromJson(Map<String, dynamic> json) => _$StoreFromJson(json);

  Map<String, dynamic> toJson() => _$StoreToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
        profileImageUrl,
        coverImageUrl,
        bio,
        pageUrl,
        phone,
        addressUrl,
        rate,
        subscriptionPlans,
      ];
}
