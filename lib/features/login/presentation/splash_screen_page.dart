import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:substore_app/features/auth/cubit/auth_user_cubit.dart';
import 'package:substore_app/shared/app_colors/colors.dart';

class SplashScreenPage extends StatelessWidget {
  const SplashScreenPage({super.key});

  Future<void> checkUserLogged() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    await GetIt.I.get<AuthUserCubit>().getUserLogged();
  }

  @override
  Widget build(BuildContext context) {
    checkUserLogged();

    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: XColors.global[20],
        ),
      ),
    );
  }
}
