// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerUser _$CustomerUserFromJson(Map<String, dynamic> json) => CustomerUser(
      id: json['id'] as String,
      cpf: json['cpf'] as String,
      phoneNumber: json['phoneNumber'] as String,
    );

Map<String, dynamic> _$CustomerUserToJson(CustomerUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cpf': instance.cpf,
      'phoneNumber': instance.phoneNumber,
    };
