import 'package:get_it/get_it.dart';
import 'package:substore_app/features/auth/cubit/auth_user_cubit.dart';
import 'package:substore_app/features/auth/data/client/auth_client.dart';
import 'package:substore_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:substore_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:substore_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:substore_app/features/auth/domain/usecases/get_user_logged_usecase.dart';
import 'package:substore_app/features/auth/domain/usecases/refresh_token_usecase.dart';
import 'package:substore_app/features/login/domain/usecases/login_usecase.dart';
import 'package:substore_app/shared/client/web_client/web_client.dart';
import 'package:substore_app/shared/storage/secure_storage.dart';

class AuthDI {
  static Future<void> register(String userSecureStorageKey) async {
    GetIt.I.registerFactory<AuthClient>(
      () => AuthClientImpl(
        GetIt.I.get<WebClient>(),
      ),
    );
    GetIt.I.registerFactory<AuthRemoteDatasource>(
      () => AuthRemoteDatasourceImpl(
        GetIt.I.get<AuthClient>(),
      ),
    );
    GetIt.I.registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        remoteDatasource: GetIt.I.get<AuthRemoteDatasource>(),
        secureStorage: GetIt.I.get<SecureStorage>(),
        userSecureStorageKey: userSecureStorageKey,
      ),
    );
    GetIt.I.registerLazySingleton<GetUserLoggedUseCase>(
      () => GetUserLoggedUseCase(
        GetIt.I.get<AuthRepository>(),
      ),
    );
    GetIt.I.registerFactory<RefreshTokenUseCase>(
      () => RefreshTokenUseCase(
        GetIt.I.get<AuthRepository>(),
      ),
    );
    GetIt.I.registerLazySingleton<AuthUserCubit>(
      () => AuthUserCubit(
        loginUsecase: GetIt.I.get<LoginUsecase>(),
        getUserLoggedUseCase: GetIt.I.get<GetUserLoggedUseCase>(),
        secureStorage: GetIt.I.get<SecureStorage>(),
      ),
    );
  }
}
