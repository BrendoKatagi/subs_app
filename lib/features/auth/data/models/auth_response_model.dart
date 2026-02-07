import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:substore_app/features/customer_user/domain/entities/customer_user.dart';
import 'package:substore_app/features/store_user/domain/entities/store_user.dart';
import 'package:substore_app/features/subscription/domain/entities/store.dart';
import 'package:substore_app/features/users/domain/entities/user.dart';

part 'auth_response_model.g.dart';

@JsonSerializable()
class AuthResponseModel extends Equatable {
  final String id;
  final String email;
  final String name;
  final String token;
  final CustomerUser? customerUser;
  final StoreUser? storeUser;
  final Store? store;
  final String refreshToken;
  final DateTime tokenExpiration;

  const AuthResponseModel({
    required this.id,
    required this.email,
    required this.name,
    required this.token,
    this.customerUser,
    this.storeUser,
    this.store,
    required this.refreshToken,
    required this.tokenExpiration,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) => _$AuthResponseModelFromJson(json);

  factory AuthResponseModel.fromEntity(User user) => AuthResponseModel(
        id: user.id,
        email: user.email,
        name: user.name,
        token: user.token,
        customerUser: user.customerUser,
        storeUser: user.storeUser,
        store: user.store,
        refreshToken: user.refreshToken,
        tokenExpiration: user.tokenExpiration,
      );

  set token(String token) => this.token = token;
  set refreshToken(String refreshToken) => this.refreshToken = refreshToken;

  Map<String, dynamic> toJson() => _$AuthResponseModelToJson(this);

  AuthResponseModel copyWith({
    String? id,
    String? email,
    String? name,
    String? token,
    CustomerUser? customerUser,
    StoreUser? storeUser,
    Store? store,
    String? refreshToken,
    DateTime? tokenExpiration,
  }) =>
      AuthResponseModel(
        id: id ?? this.id,
        email: email ?? this.email,
        name: name ?? this.name,
        token: token ?? this.token,
        customerUser: customerUser ?? this.customerUser,
        storeUser: storeUser ?? this.storeUser,
        store: store ?? this.store,
        refreshToken: refreshToken ?? this.refreshToken,
        tokenExpiration: tokenExpiration ?? this.tokenExpiration,
      );

  User toEntity() => User(
        id: id,
        email: email,
        name: name,
        customerUser: customerUser,
        storeUser: storeUser,
        store: store,
        token: token,
        refreshToken: refreshToken,
        tokenExpiration: tokenExpiration,
      );

  @override
  List<Object?> get props => [
        id,
        email,
        name,
        customerUser,
        storeUser,
        store,
        token,
        refreshToken,
        tokenExpiration,
      ];
}
