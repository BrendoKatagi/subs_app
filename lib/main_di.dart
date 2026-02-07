import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:substore_app/config/environment/environment_manager.dart';
import 'package:substore_app/config/environment/environment_properties.dart';
import 'package:substore_app/config/flavor_manager.dart';
import 'package:substore_app/shared/helpers/deep_link_helper.dart';
import 'package:substore_app/shared/storage/secure_storage.dart';
import 'package:substore_app/shared/storage/secure_storage_impl.dart';

class MainDI {
  final DotEnv dotEnv;

  MainDI({required this.dotEnv});

  Future<void> init() async {
    final environmentManager = EnvironmentManager(dotEnv: dotEnv);
    await environmentManager.init(flavor: FlavorManager.appFlavor!);

    final EnvironmentProperties? environmentProperties = environmentManager.properties;

    initSecureStorage();
    if (!kIsWeb) await DeepLinkHelper().init();

    GetIt.I.registerLazySingleton<EnvironmentProperties>(() => environmentProperties ?? const EnvironmentProperties(baseUrl: '', appBaseUrl: ''));
  }

  void initSecureStorage() {
    AndroidOptions getAndroidOptions() => const AndroidOptions(
          encryptedSharedPreferences: true,
        );

    GetIt.I.registerLazySingleton<SecureStorage>(
      () => SecureStorageImpl(
        storage: FlutterSecureStorage(
          aOptions: getAndroidOptions(),
        ),
      ),
    );
  }
}
