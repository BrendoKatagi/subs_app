import 'package:substore_app/features/auth/domain/repositories/auth_repository.dart';

abstract class UpdatePasswordUsecase {
  Future<void> call({required String password, required String resetToken});
}

class UpdatePasswordUsecaseImpl implements UpdatePasswordUsecase {
  final AuthRepository authRepository;

  UpdatePasswordUsecaseImpl(this.authRepository);
  @override
  Future<void> call({required String password, required String resetToken}) async {
    await authRepository.updatePassword(password: password, resetToken: resetToken);
  }
}
