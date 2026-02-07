import 'package:get_it/get_it.dart';
import 'package:substore_app/config/app_routes.dart';
import 'package:substore_app/config/environment/environment_properties.dart';
import 'package:substore_app/features/auth/domain/repositories/auth_repository.dart';

abstract class ResetPasswordUsecase {
  Future<void> call({required String email});
}

class ResetPasswordUsecaseImpl implements ResetPasswordUsecase {
  final AuthRepository authRepository;

  ResetPasswordUsecaseImpl(this.authRepository);
  @override
  Future<void> call({required String email}) async {
    final EnvironmentProperties environmentProperties = GetIt.I.get<EnvironmentProperties>();
    final link = '${environmentProperties.appBaseUrl}/#${AppRoutes.loginPagePath}/${AppRoutes.updatePasswordPagePath}';

    await authRepository.resetPassword(email: email, link: link);
  }
}
