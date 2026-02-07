import 'package:get_it/get_it.dart';
import 'package:substore_app/features/auth/domain/usecases/get_user_logged_usecase.dart';
import 'package:substore_app/features/settings/presentation/controllers/settings_cubit.dart';
import 'package:substore_app/features/users/domain/usecases/delete_user_usecase.dart';

class SettingsDI {
  static Future<void> register() async {
    GetIt.I.registerFactory<SettingsCubit>(
      () => SettingsCubit(GetIt.I.get<DeleteUserUseCase>(), GetIt.I.get<GetUserLoggedUseCase>()),
    );
  }
}
