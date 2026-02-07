import 'package:substore_app/features/auth/data/client/auth_client.dart';
import 'package:substore_app/features/auth/data/models/auth_response_model.dart';
import 'package:substore_app/features/auth/data/models/refresh_token_response_model.dart';
import 'package:substore_app/features/auth/domain/entities/token.dart';
import 'package:substore_app/features/users/domain/entities/user.dart';
import 'package:substore_app/typedefs.dart';

abstract class AuthRemoteDatasource {
  Future<User?> login({required String email, required String password});
  Future<RefreshTokenResponseModel> refreshToken({required String refreshToken});
  Future<void> resetPassword({required String email, required String link});
  Future<bool> updatePassword({required String password, required String resetToken});
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final AuthClient client;

  AuthRemoteDatasourceImpl(this.client);

  @override
  Future<User?> login({required String email, required String password}) async {
    final JsonObject? response = await client.login(email: email, password: password);
    if (response == null) return null;

    final String token = response['access_token']! as String;
    final JsonObject tokenJson = Token(jwtToken: token).decode();
    final userData = response['userData']!;
    final JsonObject user = {
      ...userData as JsonObject,
      'storeUser': userData['store_user'] as JsonObject?,
      'customerUser': response['customer_user'] as JsonObject?,
      'token': response['access_token']! as String,
      'refreshToken': response['refresh_token']! as String,
      'tokenExpiration': tokenJson['exp'].toString(),
    };

    return AuthResponseModel.fromJson(user).toEntity();
  }

  @override
  Future<RefreshTokenResponseModel> refreshToken({required String refreshToken}) async {
    final JsonObject response = await client.refreshToken(refreshToken: refreshToken);

    return RefreshTokenResponseModel.fromJson({
      'token': response['access_token'],
      'refreshToken': response['refresh_token'],
    });
  }

  @override
  Future<void> resetPassword({required String email, required String link}) async {
    return client.resetPassword(email: email, link: link);
  }

  @override
  Future<bool> updatePassword({required String password, required String resetToken}) async {
    return client.updatePassword(password: password, resetToken: resetToken);
  }
}
