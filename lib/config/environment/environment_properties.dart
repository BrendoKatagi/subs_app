import 'package:equatable/equatable.dart';

class EnvironmentProperties extends Equatable {
  final String baseUrl;
  final String appBaseUrl;

  const EnvironmentProperties({required this.baseUrl, required this.appBaseUrl});

  factory EnvironmentProperties.fromJson(Map<String, dynamic> json) => EnvironmentProperties(
        baseUrl: (json['BASE_URL'] ?? '') as String,
        appBaseUrl: (json['APP_BASE_URL'] ?? '') as String,
      );

  @override
  List<Object?> get props => [
        baseUrl,
      ];
}
