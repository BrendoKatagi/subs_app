import 'package:get_it/get_it.dart';
import 'package:substore_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:substore_app/features/login/domain/usecases/login_usecase.dart';
import 'package:substore_app/features/login/domain/usecases/reset_password_usecase.dart';
import 'package:substore_app/features/login/domain/usecases/update_password_usecase.dart';
import 'package:substore_app/features/login/presentation/cubit/password_cubit.dart';

class LoginDI {
  static Future<void> register() async {
    GetIt.I.registerLazySingleton<LoginUsecase>(
      () => LoginUsecaseImpl(
        GetIt.I.get<AuthRepository>(),
      ),
    );
    GetIt.I.registerLazySingleton<ResetPasswordUsecase>(
      () => ResetPasswordUsecaseImpl(
        GetIt.I.get<AuthRepository>(),
      ),
    );
    GetIt.I.registerLazySingleton<UpdatePasswordUsecase>(
      () => UpdatePasswordUsecaseImpl(
        GetIt.I.get<AuthRepository>(),
      ),
    );
    GetIt.I.registerFactory<PasswordCubit>(
      () => PasswordCubit(
        GetIt.I.get<ResetPasswordUsecase>(),
        GetIt.I.get<UpdatePasswordUsecase>(),
      ),
    );
  }
}
