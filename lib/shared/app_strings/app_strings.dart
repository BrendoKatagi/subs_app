import 'package:substore_app/features/home/presentation/resources/home_strings.dart';
import 'package:substore_app/features/login/presentation/resources/login_strings.dart';
import 'package:substore_app/features/profile/resources/profile_strings.dart';
import 'package:substore_app/features/settings/presentation/resources/settings_strings.dart';
import 'package:substore_app/features/sign_up/presentation/resources/sign_up_strings.dart';
import 'package:substore_app/features/store/resources/store_strings.dart';
import 'package:substore_app/features/store_report/presentation/resources/store_report_strings.dart';
import 'package:substore_app/features/subscription/resources/subscription_strings.dart';
import 'package:substore_app/shared/presentation/resources/shared_strings.dart';

class AppStrings {
  AppStrings._();

  static const LoginStrings login = LoginStrings.instance;
  static const HomeStrings home = HomeStrings.instance;
  static const ProfileStrings profile = ProfileStrings.instance;
  static const SubscriptionStrings subscription = SubscriptionStrings.instance;
  static const SignUpStrings signUp = SignUpStrings.instance;
  static const SharedStrings shared = SharedStrings.instance;
  static const StoreStrings store = StoreStrings.instance;
  static const SettingsStrings settings = SettingsStrings.instance;
  static const StoreReportStrings storeReport = StoreReportStrings.instance;
}

extension PluralExtension on int {
  String plural(String singularWord, String pluralWord) {
    return this == 1 ? '$this $singularWord' : '$this $pluralWord';
  }
}
