// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreModel _$StoreModelFromJson(Map<String, dynamic> json) => StoreModel(
      id: json['id'] as String,
      name: json['name'] as String,
      profileImageUrl: json['profileImageUrl'] as String?,
      coverImageUrl: json['coverImageUrl'] as String?,
      bio: json['bio'] as String?,
      pageUrl: json['pageUrl'] as String?,
      phone: json['phone'] as String?,
      addressUrl: json['addressUrl'] as String?,
      rate: (json['rate'] as num?)?.toDouble(),
      subscriptionPlans: (json['subscriptionPlans'] as List<dynamic>?)
          ?.map(
              (e) => SubscriptionPlanModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StoreModelToJson(StoreModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'profileImageUrl': instance.profileImageUrl,
      'coverImageUrl': instance.coverImageUrl,
      'bio': instance.bio,
      'pageUrl': instance.pageUrl,
      'phone': instance.phone,
      'addressUrl': instance.addressUrl,
      'rate': instance.rate,
      'subscriptionPlans': instance.subscriptionPlans,
    };
