import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_registration_model.g.dart';

@JsonSerializable()
class UserRegistrationModel extends Equatable {
  final String email;
  final String cpf;
  final String name;
  final String password;
  final String phoneNumber;

  const UserRegistrationModel({
    required this.email,
    required this.cpf,
    required this.name,
    required this.phoneNumber,
    required this.password,
  });

  factory UserRegistrationModel.fromJson(Map<String, dynamic> json) => _$UserRegistrationModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserRegistrationModelToJson(this);

  @override
  List<Object?> get props => [
        email,
        cpf,
        name,
        phoneNumber,
        password,
      ];
}
