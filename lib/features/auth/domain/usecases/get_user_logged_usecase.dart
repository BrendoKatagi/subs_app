import 'package:substore_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:substore_app/features/users/domain/entities/user.dart';

class GetUserLoggedUseCase {
  final AuthRepository authRepository;

  GetUserLoggedUseCase(this.authRepository);

  Future<User?> call() => authRepository.getUserLogged();
}
