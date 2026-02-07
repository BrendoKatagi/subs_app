import 'package:substore_app/features/users/data/models/user_registration_model.dart';

abstract class UserRepository {
  Future<bool> register({required UserRegistrationModel userData});
  Future<void> delete({required String userId});
}
