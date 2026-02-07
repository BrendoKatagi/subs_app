import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:substore_app/config/app_routes.dart';
import 'package:substore_app/features/auth/cubit/auth_user_cubit.dart';
import 'package:substore_app/features/settings/presentation/controllers/settings_cubit.dart';
import 'package:substore_app/features/settings/presentation/widgets/exclude_account_overlay.dart';
import 'package:substore_app/features/settings/presentation/widgets/settings_item.dart';
import 'package:substore_app/shared/app_colors/colors.dart';
import 'package:substore_app/shared/app_strings/app_strings.dart';
import 'package:substore_app/shared/presentation/widgets/overlay/app_overlay.dart';
import 'package:substore_app/shared/presentation/widgets/overlay/error_overlay.dart';
import 'package:substore_app/shared/typography/typography.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  Future<void> onDeleteTap(BuildContext context) async {
    await context.read<SettingsCubit>().deleteUser();
  }

  Future<void> logout(BuildContext context) async {
    Navigator.pop(context);
    if (context.mounted) await context.read<AuthUserCubit>().logout();
  }

  Future<PackageInfo> _getPackageInfo() {
    return PackageInfo.fromPlatform();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthUserCubit>.value(
      value: GetIt.I.get(),
      child: BlocProvider<SettingsCubit>(
        create: (context) => GetIt.I.get(),
        child: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            return BlocListener<SettingsCubit, SettingsState>(
              listener: (_, __) {},
              listenWhen: (previous, current) {
                if (previous is! SettingsDeleteUserError && current is SettingsDeleteUserError) {
                  Navigator.pop(context);
                  AppOverlay.show(context, const ErrorOverlay());
                }
                if (previous is! SettingsDeleteUserNotAllowedError && current is SettingsDeleteUserNotAllowedError) {
                  Navigator.pop(context);
                  ErrorOverlay(description: AppStrings.settings.youHaveAvailablePlans).show(context);
                }
                if (previous is! SettingsDeleteUserSuccess && current is SettingsDeleteUserSuccess) logout(context);
                return previous != current;
              },
              child: Scaffold(
                backgroundColor: XColors.globalLight[25],
                appBar: AppBar(
                  backgroundColor: XColors.globalLight[25],
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => AppRoutes.pop(context),
                  ),
                  title: XTypography.headingRegular(AppStrings.settings.settings),
                ),
                body: Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _SectionTitle(title: AppStrings.settings.account),
                      Expanded(
                        child: ListView(
                          children: <Widget>[
                            SettingsItem(
                              icon: Icons.person_remove,
                              title: AppStrings.settings.excludeAccount,
                              onTap: () => ExcludeAccountOverlay(onActionButtonTap: () => onDeleteTap(context)).show(context),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: FutureBuilder(
                            future: _getPackageInfo(),
                            builder: (BuildContext context, AsyncSnapshot<PackageInfo> snapshot) {
                              return Align(
                                alignment: Alignment.bottomLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: XTypography.paragraphRegular(snapshot.hasData ? 'Versão: ${snapshot.data?.version}' : ''),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: XTypography.headingSmallRegular(title),
    );
  }
}
