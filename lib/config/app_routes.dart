import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:substore_app/features/home/presentation/home_page.dart';
import 'package:substore_app/features/login/presentation/login_page.dart';
import 'package:substore_app/features/login/presentation/password_reset_page.dart';
import 'package:substore_app/features/login/presentation/splash_screen_page.dart';
import 'package:substore_app/features/login/presentation/update_password_page.dart';
import 'package:substore_app/features/profile/presentation/profile_page.dart';
import 'package:substore_app/features/settings/presentation/settings_page.dart';
import 'package:substore_app/features/sign_up/presentation/sign_up_page.dart';
import 'package:substore_app/features/store/presentation/check_ins_page.dart';
import 'package:substore_app/features/store/presentation/store_home_page.dart';
import 'package:substore_app/features/store_report/presentation/store_report_page.dart';
import 'package:substore_app/features/subscription/domain/entities/store.dart';
import 'package:substore_app/features/subscription/presentation/store_page.dart';

class AppRoutes {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // root paths
  static const String rootPagePath = '/';
  static const String loginPagePath = '/login';
  static const String homePagePath = '/home';
  static const String storeHomePagePath = '/store';

  // login paths
  static const String signUpPagePath = 'sign-up';
  static const String passwordResetPagePath = 'reset-password';
  static const String updatePasswordPagePath = 'update-password';

  // customer user paths
  static const String profilePagePath = 'profile';
  static const String storePagePath = 'store';

  // store user paths
  static const String checkInsPagePath = 'check-ins';

  // settings paths
  static const String settingsPagePath = 'settings';
  static const String storeReportPagePath = 'store-report';

  static GoRoute _transitionGoRoute({
    required String path,
    required Widget Function(BuildContext, GoRouterState) pageBuilder,
  }) =>
      GoRoute(
        path: path,
        pageBuilder: (context, state) {
          if (kIsWeb) {
            return MaterialPage(
              key: state.pageKey,
              child: pageBuilder(context, state),
            );
          }

          return Platform.isIOS
              ? CupertinoPage(
                  key: state.pageKey,
                  child: pageBuilder(context, state),
                )
              : MaterialPage(
                  key: state.pageKey,
                  child: pageBuilder(context, state),
                );
        },
      );

  static final router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: rootPagePath,
    routes: [
      _transitionGoRoute(
        path: rootPagePath,
        pageBuilder: (context, state) => const SplashScreenPage(),
      ),
      GoRoute(
        path: loginPagePath,
        builder: (context, state) => const LoginPage(),
        routes: [
          _transitionGoRoute(
            path: signUpPagePath,
            pageBuilder: (context, state) => const SignUpPage(),
          ),
        ],
      ),
      GoRoute(
        path: homePagePath,
        builder: (context, state) => const HomePage(),
        routes: [
          _transitionGoRoute(
            path: profilePagePath,
            pageBuilder: (context, state) => const ProfilePage(),
          ),
          _transitionGoRoute(
            path: storePagePath,
            pageBuilder: (context, state) => const StorePage(),
          ),
          _transitionGoRoute(
            path: settingsPagePath,
            pageBuilder: (context, state) => const SettingsPage(),
          ),
        ],
      ),
      GoRoute(
        path: storeHomePagePath,
        builder: (context, state) => const StoreHomePage(),
        routes: [
          _transitionGoRoute(
            path: checkInsPagePath,
            pageBuilder: (context, state) => const CheckInsPage(),
          ),
          _transitionGoRoute(
            path: settingsPagePath,
            pageBuilder: (context, state) => const SettingsPage(),
          ),
          _transitionGoRoute(
            path: storeReportPagePath,
            pageBuilder: (context, state) => const StoreReportPage(),
          ),
        ],
      ),
      GoRoute(
        path: loginPagePath,
        builder: (context, state) => const PasswordResetPage(),
        routes: [
          _transitionGoRoute(
            path: passwordResetPagePath,
            pageBuilder: (context, state) => const PasswordResetPage(),
          ),
        ],
      ),
      GoRoute(
        path: '$loginPagePath/$updatePasswordPagePath',
        builder: (context, state) {
          final Map<String, String> queryParameters = state.uri.queryParameters;
          final String? resetToken = queryParameters['resetToken'];
          return UpdatePasswordPage(resetToken: resetToken);
        },
      ),
    ],
  );

  static void pushAndRemoveUntil(String path, {Object? extra}) {
    while (navigatorKey.currentContext!.canPop()) {
      navigatorKey.currentContext!.pop();
    }
    navigatorKey.currentContext!.go(path, extra: extra);
  }

  static void clearHistoryAndNavigate(String path) {
    while (navigatorKey.currentContext!.canPop()) {
      navigatorKey.currentContext!.pop();
    }
    navigatorKey.currentContext!.pushReplacement(path);
  }

  static void replaceToLoginPage() => clearHistoryAndNavigate(loginPagePath);

  static void navigateToSignUpPage(BuildContext context) {
    context.go('$loginPagePath/$signUpPagePath');
  }

  static void navigateToHomePage() {
    navigatorKey.currentContext!.go(homePagePath);
  }

  static void replaceToHomePage() {
    pushAndRemoveUntil(homePagePath);
  }

  static void navigateToStorePage(BuildContext context, Store store) {
    context.go('$homePagePath/$storePagePath', extra: store);
  }

  static void navigateToStoreHomePage() {
    navigatorKey.currentContext!.go(storeHomePagePath);
  }

  static void replaceToStoreHomePage() {
    pushAndRemoveUntil(storeHomePagePath);
  }

  static void navigateToCheckInsPage(BuildContext context) {
    context.go('$storeHomePagePath/$checkInsPagePath');
  }

  static void navigateToResetPasswordPage(BuildContext context) {
    context.go('$loginPagePath/$passwordResetPagePath');
  }

  static void navigateToUpdatePasswordPage(BuildContext context) {
    context.go('$loginPagePath/$updatePasswordPagePath');
  }

  static void navigateToCustomerSettingsPage(BuildContext context) {
    context.go('$homePagePath/$settingsPagePath');
  }

  static void navigateToStoreSettingsPage(BuildContext context) {
    context.go('$storeHomePagePath/$settingsPagePath');
  }

  static void navigateToStoreReportPage(BuildContext context) {
    context.go('$storeHomePagePath/$storeReportPagePath');
  }

  static void pop(BuildContext context) {
    context.pop();
  }

  static void Function(BuildContext)? pageNavigationFunction(String page) {
    final Map<String, void Function(BuildContext)> pageNavigation = <String, void Function(BuildContext)>{
      AppRoutes.passwordResetPagePath: AppRoutes.navigateToResetPasswordPage,
    };

    return pageNavigation[page];
  }
}
