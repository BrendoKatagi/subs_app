import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:substore_app/config/environment/environment_properties.dart';
import 'package:substore_app/shared/client/dio_web_client/dio_web_client.dart';
import 'package:substore_app/shared/client/interceptors/app_interceptor.dart';
import 'package:substore_app/shared/client/web_client/web_client.dart';
import 'package:substore_app/shared/client/web_client/web_socket_client.dart';
import 'package:substore_app/shared/client/web_socket_client/web_socket_client_impl.dart';
import 'package:substore_app/shared/storage/secure_storage.dart';

class ClientDI {
  static Future<void> register(String userSecureStorageKey) async {
    final EnvironmentProperties environmentProperties = GetIt.I.get<EnvironmentProperties>();

    final dio = Dio(BaseOptions(baseUrl: environmentProperties.baseUrl));

    dio.interceptors.add(AppInterceptor(
      secureStorage: GetIt.I.get<SecureStorage>(),
      userSecureStorageKey: userSecureStorageKey,
    ));

    if (kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(
          logPrint: (o) => debugPrint(o.toString()),
        ),
      );
    }

    GetIt.I.registerLazySingleton<WebClient>(() => DioWebClient(dio));
    GetIt.I.registerLazySingleton<WebSocketClient>(IOWebSocketClient.new);
  }
}
