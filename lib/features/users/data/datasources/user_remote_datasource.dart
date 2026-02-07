import 'package:substore_app/features/users/data/clients/user_client.dart';
import 'package:substore_app/features/users/data/models/user_registration_model.dart';

abstract class UserRemoteDatasource {
  Future<bool> register({required UserRegistrationModel userData});
  Future<void> delete({required String userId});
}

class UserRemoteDatasourceImpl implements UserRemoteDatasource {
  final UserClient client;

  UserRemoteDatasourceImpl(this.client);

  @override
  Future<bool> register({required UserRegistrationModel userData}) async {
    return client.register(userData: userData);
  }

  @override
  Future<void> delete({required String userId}) async {
    return client.delete(userId: userId);
  }
}
