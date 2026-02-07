part of 'menu_cubit.dart';

sealed class MenuState extends Equatable {
  final List<MenuPermissionsEnum> menuPermissions;
  const MenuState({this.menuPermissions = const <MenuPermissionsEnum>[]});

  @override
  List<Object> get props => [];
}

final class MenuInitial extends MenuState {
  const MenuInitial({super.menuPermissions});
}

final class MenuLoading extends MenuState {
  const MenuLoading({super.menuPermissions});
}
