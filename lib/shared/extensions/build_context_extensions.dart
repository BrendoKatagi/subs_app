import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:substore_app/features/auth/cubit/auth_user_cubit.dart';
import 'package:substore_app/features/auth/cubit/auth_user_state.dart';
import 'package:substore_app/features/users/domain/entities/user.dart';

extension BuildContextExtensions on BuildContext {
  User? getUserLogged() {
    final AuthUserState state = BlocProvider.of<AuthUserCubit>(this).state;
    if (state is! AuthUserStateLogged) return null;
    return state.user;
  }

  // TODO update to userImage prop
  String? getUserImage() => null;
  // String getUserImage() => getUserLogged().name;
}
