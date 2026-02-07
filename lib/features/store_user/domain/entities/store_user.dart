import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:substore_app/features/users/domain/entities/enum/roles.dart';

part 'store_user.g.dart';

@JsonSerializable()
class StoreUser extends Equatable {
  final String id;
  final int fkRole;
  final String fkStore;

  const StoreUser({
    required this.id,
    required this.fkRole,
    required this.fkStore,
  });

  Role get role => Role.byFkRole(fkRole);

  factory StoreUser.fromJson(Map<String, dynamic> json) => _$StoreUserFromJson(json);

  Map<String, dynamic> toJson() => _$StoreUserToJson(this);

  @override
  List<Object?> get props => [id, fkRole, fkStore];
}
