import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_registration_response_model.g.dart';

@JsonSerializable()
class UserRegistrationResponseModel extends Equatable {
  final int status;
  final String message;

  const UserRegistrationResponseModel({required this.status, required this.message});

  factory UserRegistrationResponseModel.fromJson(Map<String, dynamic> json) => _$UserRegistrationResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserRegistrationResponseModelToJson(this);

  @override
  List<Object?> get props => [status, message];
}
