// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_registration_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRegistrationModel _$UserRegistrationModelFromJson(
        Map<String, dynamic> json) =>
    UserRegistrationModel(
      email: json['email'] as String,
      cpf: json['cpf'] as String,
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$UserRegistrationModelToJson(
        UserRegistrationModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'cpf': instance.cpf,
      'name': instance.name,
      'password': instance.password,
      'phoneNumber': instance.phoneNumber,
    };
