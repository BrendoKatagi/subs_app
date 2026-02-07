import 'package:get_it/get_it.dart';
import 'package:substore_app/features/sign_up/presentation/controllers/sign_up_cubit.dart';
import 'package:substore_app/features/users/domain/usecases/register_user_usecase.dart';

class SignUpDI {
  static Future<void> register() async {
    GetIt.I
        .registerFactory(() => SignUpCubit(GetIt.I.get<RegisterUserUseCase>()));
  }
}
