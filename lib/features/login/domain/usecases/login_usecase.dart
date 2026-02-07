import 'package:substore_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:substore_app/features/users/domain/entities/user.dart';

abstract class LoginUsecase {
  Future<User?> call({required String email, required String password});
}

class LoginUsecaseImpl implements LoginUsecase {
  final AuthRepository authRepository;

  LoginUsecaseImpl(this.authRepository);

  @override
  Future<User?> call({required String email, required String password}) async {
    final User? user =
        await authRepository.login(email: email, password: password);

    if (user != null) return user;

    return null;
  }
}
