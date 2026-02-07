import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:substore_app/features/customer_user/domain/entities/customer_user.dart';
import 'package:substore_app/features/store_user/domain/entities/store_user.dart';
import 'package:substore_app/features/subscription/domain/entities/store.dart';
import 'package:substore_app/features/users/domain/entities/enum/roles.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  final String id;
  final String email;
  final String name;
  final String token;
  final String refreshToken;
  final DateTime tokenExpiration;
  final CustomerUser? customerUser;
  final StoreUser? storeUser;
  final Store? store;

  Role? get role => storeUser != null ? storeUser?.role : customerUser?.role;

  const User({
    required this.id,
    required this.email,
    required this.name,
    required this.token,
    required this.refreshToken,
    required this.tokenExpiration,
    this.customerUser,
    this.storeUser,
    this.store,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object?> get props => [
        id,
        email,
        name,
        token,
        refreshToken,
        tokenExpiration,
        customerUser,
        storeUser,
        store,
      ];
}
