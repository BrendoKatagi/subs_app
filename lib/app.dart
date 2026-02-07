import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:substore_app/config/app_routes.dart';
import 'package:substore_app/features/auth/cubit/auth_user_cubit.dart';
import 'package:substore_app/features/auth/cubit/auth_user_state.dart';
import 'package:substore_app/l10n/l10n.dart';
import 'package:substore_app/shared/app_colors/colors.dart';
import 'package:substore_app/shared/app_strings/app_strings.dart';

class App extends StatelessWidget {
  const App({super.key});

  void checkUserLogged(
    _,
    AuthUserState state,
  ) {
    if (state is AuthUserStateNotLogged) {
      AppRoutes.replaceToLoginPage();
      return;
    }

    if (state is AuthUserStateLogged) {
      if (state.user.storeUser != null) {
        AppRoutes.replaceToStoreHomePage();
      } else {
        AppRoutes.replaceToHomePage();
      }
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthUserCubit>.value(
      value: GetIt.I.get<AuthUserCubit>(),
      child: BlocListener<AuthUserCubit, AuthUserState>(
        listener: checkUserLogged,
        listenWhen: (_, current) => authStates.contains(current.runtimeType),
        child: MaterialApp.router(
          title: AppStrings.shared.substore,
          routerConfig: AppRoutes.router,
          theme: ThemeData(
            primaryColor: XColors.global,
            fontFamily: GoogleFonts.montserrat().fontFamily,
            colorScheme: ColorScheme.fromSeed(seedColor: XColors.global),
          ),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      ),
    );
  }
}
