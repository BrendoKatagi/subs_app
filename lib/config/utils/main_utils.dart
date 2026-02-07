import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:substore_app/features/auth/auth_di.dart';
import 'package:substore_app/features/login/login_di.dart';
import 'package:substore_app/features/menu/menu_di.dart';
import 'package:substore_app/features/settings/settings_di.dart';
import 'package:substore_app/features/sign_up/sign_up_di.dart';
import 'package:substore_app/features/store/store_di.dart';
import 'package:substore_app/features/store_report/store_report_di.dart';
import 'package:substore_app/features/subscription/subscription_di.dart';
import 'package:substore_app/features/users/user_di.dart';
import 'package:substore_app/main_di.dart';
import 'package:substore_app/shared/client/client_di.dart';

class MainUtils {
  static Future<void> configApp() async {
    const userSecureStorageKey = 'user';

    await MainDI(dotEnv: dotenv).init();

    await ClientDI.register(userSecureStorageKey);
    await AuthDI.register(userSecureStorageKey);
    await UserDI.register();
    await LoginDI.register();
    await SignUpDI.register();
    await StoreDI.register();
    await SubscriptionDI.register();
    await SettingsDI.register();
    await StoreReportDI.register();
    await MenuDI.register();
  }
}
