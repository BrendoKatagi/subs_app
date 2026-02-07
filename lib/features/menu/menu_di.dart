import 'package:get_it/get_it.dart';
import 'package:substore_app/features/auth/domain/usecases/get_user_logged_usecase.dart';
import 'package:substore_app/features/menu/presentation/controllers/menu_cubit.dart';

class MenuDI {
  static Future<void> register() async {
    GetIt.I.registerFactory<MenuCubit>(() => MenuCubit(GetIt.I.get<GetUserLoggedUseCase>()));
  }
}
