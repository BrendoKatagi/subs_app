import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:substore_app/config/environment/environment_properties.dart';
import 'package:substore_app/config/flavor_manager.dart';

class EnvironmentManager {
  EnvironmentProperties? _properties;
  final DotEnv _dotEnv;

  EnvironmentManager({required DotEnv dotEnv}) : _dotEnv = dotEnv;

  Future<void> init({required FlavorEnum flavor}) async {
    const String filePath = 'envs/';

    late String fileName;

    switch (flavor) {
      case FlavorEnum.dev:
        fileName = '$filePath.env.dev';
        break;
      case FlavorEnum.staging:
        fileName = '$filePath.env.staging';
        break;
      case FlavorEnum.prod:
        fileName = '$filePath.env.prod';
    }

    await _dotEnv.load(fileName: fileName);

    _properties = EnvironmentProperties.fromJson(_dotEnv.env);
  }

  EnvironmentProperties? get properties => _properties;
}
