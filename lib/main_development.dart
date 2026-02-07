import 'package:substore_app/app.dart';
import 'package:substore_app/bootstrap.dart';
import 'package:substore_app/config/flavor_manager.dart';

Future<void> main() async {
  FlavorManager.appFlavor = FlavorEnum.dev;

  await bootstrap(() => const App());
}
