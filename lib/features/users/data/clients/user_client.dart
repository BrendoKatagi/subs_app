import 'dart:io';

import 'package:substore_app/features/users/data/errors/user_exceptions.dart';
import 'package:substore_app/features/users/data/models/user_registration_model.dart';
import 'package:substore_app/shared/client/web_client/web_client.dart';
import 'package:substore_app/shared/errors/client_exceptions.dart';

abstract class UserClient {
  Future<bool> register({required UserRegistrationModel userData});
  Future<void> delete({required String userId});
}

class UserClientImpl implements UserClient {
  final WebClient client;

  UserClientImpl(this.client);

  @override
  Future<bool> register({required UserRegistrationModel userData}) async {
    try {
      const String path = '/customer-user';

      final data = userData.toJson();

      final ClientResponse response = await client.post(
        path,
        data: data,
      );

      return response.statusCode == 201;
    } catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<void> delete({required String userId}) async {
    try {
      final String path = '/user/$userId';
      await client.delete(path);
    } on ClientException catch (error) {
      if (error.response?.statusCode == HttpStatus.conflict) throw UserWithActivePlansException();
    } catch (error) {
      throw Exception(error);
    }
  }
}
