// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      token: json['token'] as String,
      refreshToken: json['refreshToken'] as String,
      tokenExpiration: DateTime.parse(json['tokenExpiration'] as String),
      customerUser: json['customerUser'] == null
          ? null
          : CustomerUser.fromJson(json['customerUser'] as Map<String, dynamic>),
      storeUser: json['storeUser'] == null
          ? null
          : StoreUser.fromJson(json['storeUser'] as Map<String, dynamic>),
      store: json['store'] == null
          ? null
          : Store.fromJson(json['store'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'token': instance.token,
      'refreshToken': instance.refreshToken,
      'tokenExpiration': instance.tokenExpiration.toIso8601String(),
      'customerUser': instance.customerUser,
      'storeUser': instance.storeUser,
      'store': instance.store,
    };
