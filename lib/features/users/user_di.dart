import 'package:get_it/get_it.dart';
import 'package:substore_app/features/subscription/data/client/user_subscription_client.dart';
import 'package:substore_app/features/subscription/data/datasources/user_subscription_remote_datasource.dart';
import 'package:substore_app/features/subscription/data/repositories/user_subscription_repository_impl.dart';
import 'package:substore_app/features/subscription/domain/repositories/user_subscription_repository.dart';
import 'package:substore_app/features/subscription/domain/usecases/get_user_subscriptions_usecase.dart';
import 'package:substore_app/features/users/data/clients/user_client.dart';
import 'package:substore_app/features/users/data/datasources/user_remote_datasource.dart';
import 'package:substore_app/features/users/data/repositories/user_repository_impl.dart';
import 'package:substore_app/features/users/domain/repositories/user_repository.dart';
import 'package:substore_app/features/users/domain/usecases/delete_user_usecase.dart';
import 'package:substore_app/features/users/domain/usecases/register_user_usecase.dart';
import 'package:substore_app/shared/client/web_client/web_client.dart';

class UserDI {
  static Future<void> register() async {
    GetIt.I.registerLazySingleton<UserSubscriptionClient>(
      () => UserSubscriptionClientImpl(
        client: GetIt.I.get(),
        webSocketClient: GetIt.I.get(),
      ),
    );
    GetIt.I.registerLazySingleton<UserSubscriptionRemoteDatasource>(
      () => UserSubscriptionRemoteDatasourceImpl(
        client: GetIt.I.get(),
      ),
    );
    GetIt.I.registerLazySingleton<UserSubscriptionRepository>(
      () => UserSubscriptionRepositoryImpl(
        remoteDatasource: GetIt.I.get(),
      ),
    );
    GetIt.I.registerLazySingleton<GetUserSubscriptionsUseCase>(
      () => GetUserSubscriptionsUseCase(
        userSubscriptionRepository: GetIt.I.get(),
      ),
    );
    GetIt.I.registerFactory<UserClient>(
      () => UserClientImpl(GetIt.I.get<WebClient>()),
    );
    GetIt.I.registerFactory<UserRemoteDatasource>(
      () => UserRemoteDatasourceImpl(GetIt.I.get<UserClient>()),
    );
    GetIt.I.registerFactory<UserRepository>(
      () => UserRepositoryImpl(GetIt.I.get<UserRemoteDatasource>()),
    );
    GetIt.I.registerFactory<RegisterUserUseCase>(
      () => RegisterUserUseCase(userRepository: GetIt.I.get<UserRepository>()),
    );
    GetIt.I.registerFactory<DeleteUserUseCase>(
      () => DeleteUserUseCase(userRepository: GetIt.I.get<UserRepository>()),
    );
  }
}
