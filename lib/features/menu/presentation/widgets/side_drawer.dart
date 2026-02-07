import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:substore_app/config/app_routes.dart';
import 'package:substore_app/features/auth/cubit/auth_user_cubit.dart';
import 'package:substore_app/features/menu/domain/enums/menu_permissions_enum.dart';
import 'package:substore_app/features/menu/presentation/controllers/menu_cubit.dart';
import 'package:substore_app/shared/app_colors/colors.dart';
import 'package:substore_app/shared/app_strings/app_strings.dart';
import 'package:substore_app/shared/presentation/widgets/buttons/app_buttons.dart';
import 'package:substore_app/shared/typography/typography.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({super.key});

  List<Widget> menuOptions(BuildContext context, {required List<MenuPermissionsEnum> menuPermissions}) =>
      menuPermissions.map((permission) => _menuItems[permission]?.call(context) ?? const SizedBox.shrink()).toList();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: BlocProvider<AuthUserCubit>.value(
        value: GetIt.I.get<AuthUserCubit>(),
        child: BlocProvider<MenuCubit>(
          create: (context) => GetIt.I.get()..init(),
          child: BlocBuilder<MenuCubit, MenuState>(
            builder: (context, state) {
              final List<MenuPermissionsEnum> menuPermissions = state.menuPermissions;
              return SafeArea(
                top: false,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          DrawerHeader(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                end: Alignment.bottomRight,
                                colors: <Color>[XColors.substore, XColors.substore[20]!],
                              ),
                            ),
                            child: XTypography.headingRegular('Menu', color: XColors.substore[20]!),
                          ),
                          ...menuOptions(context, menuPermissions: menuPermissions),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: XPrimaryIconButton(
                            text: AppStrings.home.logout,
                            icon: Icons.logout,
                            onPressed: () => context.read<AuthUserCubit>()..logout(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Map<MenuPermissionsEnum, Widget Function(BuildContext)> get _menuItems => <MenuPermissionsEnum, Widget Function(BuildContext)>{
        MenuPermissionsEnum.customerSettings: (BuildContext context) => DrawerItem(
              icon: Icons.settings,
              title: AppStrings.shared.settings,
              onTap: () => AppRoutes.navigateToCustomerSettingsPage(context),
            ),
        MenuPermissionsEnum.storeSettings: (BuildContext context) => DrawerItem(
              icon: Icons.settings,
              title: AppStrings.shared.settings,
              onTap: () => AppRoutes.navigateToStoreSettingsPage(context),
            ),
        MenuPermissionsEnum.storeReport: (BuildContext context) => DrawerItem(
              icon: Icons.bar_chart,
              title: AppStrings.shared.dashboard,
              onTap: () => AppRoutes.navigateToStoreReportPage(context),
            ),
      };
}

class DrawerItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const DrawerItem({super.key, required this.title, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          Icon(icon, color: Colors.grey),
          const SizedBox(width: 12),
          Text(title, overflow: TextOverflow.ellipsis),
        ],
      ),
      onTap: onTap,
    );
  }
}
