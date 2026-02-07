import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:substore_app/features/subscription/data/models/subscription_plan_model.dart';
import 'package:substore_app/features/subscription/domain/entities/store.dart';

part 'store_model.g.dart';

@JsonSerializable()
class StoreModel extends Equatable {
  final String id;
  final String name;
  final String? profileImageUrl;
  final String? coverImageUrl;
  final String? bio;
  final String? pageUrl;
  final String? phone;
  final String? addressUrl;
  final double? rate;
  final List<SubscriptionPlanModel>? subscriptionPlans;

  const StoreModel({
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

  factory StoreModel.fromJson(Map<String, dynamic> json) =>
      _$StoreModelFromJson(json);

  Map<String, dynamic> toJson() => _$StoreModelToJson(this);

  Store toEntity() => Store(
        id: id,
        name: name,
        profileImageUrl: profileImageUrl,
        coverImageUrl: coverImageUrl,
        bio: bio,
        pageUrl: pageUrl,
        phone: phone,
        addressUrl: addressUrl,
        rate: rate,
        subscriptionPlans: subscriptionPlans?.map((e) => e.toEntity()).toList(),
      );

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
