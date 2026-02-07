import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:substore_app/features/users/domain/entities/enum/roles.dart';
part 'customer_user.g.dart';

@JsonSerializable()
class CustomerUser extends Equatable {
  final String id;
  final String cpf;
  final String phoneNumber;

  Role get role => Role.user;

  const CustomerUser({
    required this.id,
    required this.cpf,
    required this.phoneNumber,
  });

  factory CustomerUser.fromJson(Map<String, dynamic> json) => _$CustomerUserFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerUserToJson(this);

  @override
  List<Object?> get props => [
        id,
        cpf,
        phoneNumber,
      ];
}
