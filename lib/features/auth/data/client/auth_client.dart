import 'package:substore_app/shared/app_strings/app_strings.dart';
import 'package:substore_app/shared/client/web_client/web_client.dart';
import 'package:substore_app/typedefs.dart';

abstract class AuthClient {
  Future<JsonObject?> login({required String email, required String password});
  Future<JsonObject> refreshToken({required String refreshToken});
  Future<void> resetPassword({required String email, required String link});
  Future<bool> updatePassword({required String password, required String resetToken});
}

class AuthClientImpl implements AuthClient {
  final WebClient client;

  AuthClientImpl(this.client);

  @override
  Future<JsonObject?> login({required String email, required String password}) async {
    final String path = AppStrings.login.loginRequestPath;
    final data = {
      'email': email,
      'password': password,
    };

    final ClientResponse response = await client.post(path, data: data);

    return response.responseData?.data as JsonObject;
  }

  @override
  Future<JsonObject> refreshToken({required String refreshToken}) async {
    const String path = '/auth/refresh';
    final data = {
      'refresh_token': refreshToken,
    };

    final newClient = client.getNewInstance();

    final ClientResponse response = await newClient.post(path, data: data);

    if (response.statusCode == 401) {
      throw Exception('Refresh token unauthorized');
    }

    return response.responseData?.data as JsonObject;
  }

  @override
  Future<void> resetPassword({required String email, required String link}) async {
    const String path = '/password/reset';
    final data = {
      'email': email,
      'link': link,
    };

    await client.post(path, data: data);
  }

  @override
  Future<bool> updatePassword({required String password, required String resetToken}) async {
    const String path = '/password/update';
    final data = {
      'new_password': password,
      'reset_token': resetToken,
    };

    final response = await client.patch(path, data: data);

    return response.statusCode == 200;
  }
}
