import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'refresh_token_response_model.g.dart';

@JsonSerializable()
class RefreshTokenResponseModel extends Equatable {
  final String token;
  final String refreshToken;

  const RefreshTokenResponseModel(
      {required this.token, required this.refreshToken});

  factory RefreshTokenResponseModel.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$RefreshTokenResponseModelToJson(this);

  @override
  List<Object?> get props => [
        token,
        refreshToken,
      ];
}
