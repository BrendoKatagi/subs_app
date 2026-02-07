import 'package:substore_app/features/menu/domain/enums/menu_permissions_enum.dart';
import 'package:substore_app/features/users/domain/entities/enum/roles.dart';
import 'package:substore_app/features/users/domain/entities/user.dart';

class MenuItemsHelper {
  static List<MenuPermissionsEnum> menuPermissionsByUserType(User? user) => _roleSettings[user?.role ?? Role.none] ?? <MenuPermissionsEnum>[];

  static Map<Role, List<MenuPermissionsEnum>> get _roleSettings => <Role, List<MenuPermissionsEnum>>{
        Role.admin: <MenuPermissionsEnum>[MenuPermissionsEnum.storeSettings, MenuPermissionsEnum.storeReport],
        Role.user: <MenuPermissionsEnum>[MenuPermissionsEnum.customerSettings],
        Role.partner: <MenuPermissionsEnum>[MenuPermissionsEnum.storeSettings],
        Role.merchant: <MenuPermissionsEnum>[MenuPermissionsEnum.storeSettings, MenuPermissionsEnum.storeReport],
        Role.none: <MenuPermissionsEnum>[MenuPermissionsEnum.customerSettings],
      };
}
