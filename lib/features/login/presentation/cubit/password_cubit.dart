import 'package:bloc/bloc.dart';
import 'package:substore_app/features/login/domain/usecases/reset_password_usecase.dart';
import 'package:substore_app/features/login/domain/usecases/update_password_usecase.dart';
import 'package:substore_app/features/login/presentation/cubit/password_state.dart';

class PasswordCubit extends Cubit<PasswordState> {
  final ResetPasswordUsecase resetPasswordUsecase;
  final UpdatePasswordUsecase updatePasswordUsecase;
  PasswordCubit(this.resetPasswordUsecase, this.updatePasswordUsecase) : super(const PasswordResetInitial());

  Future<void> resetPassword({required String email}) async {
    try {
      emit(const PasswordResetLoading());
      await resetPasswordUsecase.call(email: email);
      emit(const PasswordResetSuccess());
    } catch (e) {
      emit(const PasswordResetError());
    }
  }

  Future<void> updatePassword({required String newPassword, required String resetToken}) async {
    if (state is PasswordResetLoading) return;
    try {
      emit(const PasswordResetLoading());

      await updatePasswordUsecase.call(password: newPassword, resetToken: resetToken);
      emit(const PasswordResetSuccess());
    } catch (e) {
      emit(const PasswordUpdateError());
    }
  }
}
