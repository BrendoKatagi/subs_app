// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreUser _$StoreUserFromJson(Map<String, dynamic> json) => StoreUser(
      id: json['id'] as String,
      fkRole: json['fkRole'] as int,
      fkStore: json['fkStore'] as String,
    );

Map<String, dynamic> _$StoreUserToJson(StoreUser instance) => <String, dynamic>{
      'id': instance.id,
      'fkRole': instance.fkRole,
      'fkStore': instance.fkStore,
    };
