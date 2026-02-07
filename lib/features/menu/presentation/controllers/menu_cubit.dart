import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:substore_app/features/auth/domain/usecases/get_user_logged_usecase.dart';
import 'package:substore_app/features/menu/domain/enums/menu_permissions_enum.dart';
import 'package:substore_app/features/menu/domain/menu_items_helper.dart';
import 'package:substore_app/features/users/domain/entities/user.dart';
import 'package:substore_app/shared/utils/cubit_utils.dart';

part 'menu_state.dart';

class MenuCubit extends Cubit<MenuState> {
  final GetUserLoggedUseCase getUserLoggedUseCase;

  MenuCubit(this.getUserLoggedUseCase) : super(const MenuInitial());

  late List<MenuPermissionsEnum> _menuPermissions;

  Future<void> init() async {
    safeEmit(const MenuLoading());
    try {
      final User? user = await getUserLoggedUseCase.call();
      final List<MenuPermissionsEnum> menuPermissions = MenuItemsHelper.menuPermissionsByUserType(user);
      _menuPermissions = menuPermissions;
      safeEmit(MenuInitial(menuPermissions: _menuPermissions));
    } catch (error) {
      addError(error);
      safeEmit(const MenuInitial());
    }
  }
}
