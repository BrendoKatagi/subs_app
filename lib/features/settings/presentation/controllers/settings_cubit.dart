import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:substore_app/features/auth/domain/usecases/get_user_logged_usecase.dart';
import 'package:substore_app/features/users/data/errors/user_exceptions.dart';
import 'package:substore_app/features/users/domain/entities/user.dart';
import 'package:substore_app/features/users/domain/usecases/delete_user_usecase.dart';
import 'package:substore_app/shared/utils/cubit_utils.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final DeleteUserUseCase deleteUserUseCase;
  final GetUserLoggedUseCase getUserLoggedUseCase;
  SettingsCubit(this.deleteUserUseCase, this.getUserLoggedUseCase) : super(const SettingsInitial());

  Future<void> deleteUser() async {
    safeEmit(const SettingsDeleteUserLoading());

    try {
      final User? user = await getUserLoggedUseCase.call();
      if (user == null) throw const FormatException();

      await deleteUserUseCase.call(userId: user.id);
      safeEmit(const SettingsDeleteUserSuccess());
    } catch (error) {
      if (error is UserWithActivePlansException) return safeEmit(const SettingsDeleteUserNotAllowedError());
      safeEmit(const SettingsDeleteUserError());
    }
  }
}
