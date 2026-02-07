import 'package:substore_app/features/users/data/models/user_registration_model.dart';
import 'package:substore_app/features/users/domain/repositories/user_repository.dart';

class RegisterUserUseCase {
  final UserRepository userRepository;

  RegisterUserUseCase({required this.userRepository});

  Future<bool> call({required UserRegistrationModel userData}) =>
      userRepository.register(userData: userData);
}
