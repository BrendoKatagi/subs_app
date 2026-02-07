import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:substore_app/typedefs.dart';

class Token extends Equatable {
  final String jwtToken;

  const Token({required this.jwtToken});

  JsonObject decode() {
    return parseJwt();
  }

  JsonObject parseJwt() {
    final parts = jwtToken.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }

    return payloadMap;
  }

  String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');

    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!"');
    }

    return utf8.decode(base64Url.decode(output));
  }

  @override
  List<Object?> get props => [jwtToken];
}
