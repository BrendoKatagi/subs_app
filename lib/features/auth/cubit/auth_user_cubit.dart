import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:substore_app/features/auth/cubit/auth_user_state.dart';
import 'package:substore_app/features/auth/domain/usecases/get_user_logged_usecase.dart';
import 'package:substore_app/features/login/domain/usecases/login_usecase.dart';
import 'package:substore_app/features/login/presentation/resources/login_constants.dart';
import 'package:substore_app/shared/app_strings/app_strings.dart';
import 'package:substore_app/shared/storage/secure_storage.dart';
import 'package:substore_app/shared/utils/cubit_utils.dart';

class AuthUserCubit extends Cubit<AuthUserState> {
  final SecureStorage secureStorage;

  final LoginUsecase loginUsecase;
  final GetUserLoggedUseCase getUserLoggedUseCase;

  AuthUserCubit({
    required this.secureStorage,
    required this.loginUsecase,
    required this.getUserLoggedUseCase,
  }) : super(const AuthUserStateInitial());

  String? validateEmail(String email) {
    return LoginConstants.emailRegex.hasMatch(email) ? null : AppStrings.login.invalidEmail;
  }

  String? validatePassword(String password) {
    return LoginConstants.passwordRegex.hasMatch(password) ? null : AppStrings.login.invalidPassword;
  }

  Future<void> login({required String email, required String password}) async {
    try {
      safeEmit(const AuthUserStateLoginLoading());

      final String? emailError = validateEmail(email);
      final String? passwordError = validatePassword(password);

      if (emailError != null || passwordError != null) {
        safeEmit(AuthUserStateLoginInvalid(AppStrings.login.loginCredentialsError));
        return;
      }

      final user = await loginUsecase.call(email: email, password: password);

      if (user != null) {
        safeEmit(AuthUserStateLogged(user));
        return;
      }
      safeEmit(const AuthUserStateLoginError());
    } catch (error) {
      safeEmit(const AuthUserStateLoginError());
      addError(error);
    }
  }

  Future<void> getUserLogged() async {
    try {
      if (state is AuthUserStateLogged) return;

      final user = await getUserLoggedUseCase();

      if (user == null) {
        safeEmit(const AuthUserStateNotLogged());
        return;
      }

      safeEmit(AuthUserStateLogged(user));
    } catch (error) {
      safeEmit(const AuthUserStateFailure());
    }
  }

  Future<void> logout() async {
    await secureStorage.deleteAll();
    emit(const AuthUserStateNotLogged());
  }
}
