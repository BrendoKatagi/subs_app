// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthResponseModel _$AuthResponseModelFromJson(Map<String, dynamic> json) =>
    AuthResponseModel(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      token: json['token'] as String,
      customerUser: json['customerUser'] == null
          ? null
          : CustomerUser.fromJson(json['customerUser'] as Map<String, dynamic>),
      storeUser: json['storeUser'] == null
          ? null
          : StoreUser.fromJson(json['storeUser'] as Map<String, dynamic>),
      store: json['store'] == null
          ? null
          : Store.fromJson(json['store'] as Map<String, dynamic>),
      refreshToken: json['refreshToken'] as String,
      tokenExpiration: DateTime.parse(json['tokenExpiration'] as String),
    );

Map<String, dynamic> _$AuthResponseModelToJson(AuthResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'token': instance.token,
      'customerUser': instance.customerUser,
      'storeUser': instance.storeUser,
      'store': instance.store,
      'refreshToken': instance.refreshToken,
      'tokenExpiration': instance.tokenExpiration.toIso8601String(),
    };
