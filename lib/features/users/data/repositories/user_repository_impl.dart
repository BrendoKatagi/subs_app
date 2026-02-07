import 'package:substore_app/features/users/data/datasources/user_remote_datasource.dart';
import 'package:substore_app/features/users/data/models/user_registration_model.dart';
import 'package:substore_app/features/users/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDatasource remoteDatasource;

  UserRepositoryImpl(this.remoteDatasource);

  @override
  Future<bool> register({required UserRegistrationModel userData}) async {
    return remoteDatasource.register(userData: userData);
  }

  @override
  Future<void> delete({required String userId}) async {
    return remoteDatasource.delete(userId: userId);
  }
}
