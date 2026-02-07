part of 'settings_cubit.dart';

sealed class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

final class SettingsInitial extends SettingsState {
  const SettingsInitial();
}

final class SettingsLoading extends SettingsState {
  const SettingsLoading();
}

class SettingsDeleteUserError extends SettingsState {
  const SettingsDeleteUserError();
}

class SettingsDeleteUserNotAllowedError extends SettingsState {
  const SettingsDeleteUserNotAllowedError();
}

class SettingsDeleteUserSuccess extends SettingsState {
  const SettingsDeleteUserSuccess();
}

class SettingsDeleteUserLoading extends SettingsState {
  const SettingsDeleteUserLoading();
}
