// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_registration_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRegistrationResponseModel _$UserRegistrationResponseModelFromJson(
        Map<String, dynamic> json) =>
    UserRegistrationResponseModel(
      status: json['status'] as int,
      message: json['message'] as String,
    );

Map<String, dynamic> _$UserRegistrationResponseModelToJson(
        UserRegistrationResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };
