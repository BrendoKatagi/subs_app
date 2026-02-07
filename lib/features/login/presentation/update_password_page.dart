import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:substore_app/config/app_routes.dart';
import 'package:substore_app/features/login/presentation/cubit/password_cubit.dart';
import 'package:substore_app/features/login/presentation/cubit/password_state.dart';
import 'package:substore_app/shared/app_strings/app_strings.dart';
import 'package:substore_app/shared/constants/user_validation_constants.dart';
import 'package:substore_app/shared/presentation/widgets/buttons/app_buttons.dart';
import 'package:substore_app/shared/presentation/widgets/overlay/app_overlay.dart';
import 'package:substore_app/shared/presentation/widgets/overlay/loading_overlay.dart';
import 'package:substore_app/shared/presentation/widgets/snack_bar/app_snack_bar.dart';
import 'package:substore_app/shared/typography/typography.dart';

class UpdatePasswordPage extends StatefulWidget {
  final String? resetToken;
  const UpdatePasswordPage({super.key, this.resetToken});

  @override
  State<UpdatePasswordPage> createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _passwordController;
  late TextEditingController _passwordConfirmationController;
  late bool _isPasswordValid;
  late bool _isValid;
  late String? resetToken;

  @override
  void initState() {
    _passwordController = TextEditingController();
    _passwordConfirmationController = TextEditingController();
    _isValid = false;
    _isPasswordValid = false;

    resetToken = widget.resetToken;

    super.initState();
  }

  void _updatePassword(BuildContext context) {
    final String password = _passwordConfirmationController.text;

    context.read<PasswordCubit>().updatePassword(newPassword: password, resetToken: resetToken!);
  }

  @override
  Widget build(BuildContext context) {
    if (resetToken == null) {
      AppRoutes.replaceToLoginPage();
    }

    return BlocProvider(
      create: (context) => GetIt.I.get<PasswordCubit>(),
      child: BlocConsumer<PasswordCubit, PasswordState>(
        listener: (context, state) {},
        listenWhen: (previous, current) {
          if (current is PasswordResetLoading) {
            AppOverlay.show(context, const LoadingOverlay());
          }

          if (previous is PasswordResetLoading && current is! PasswordResetLoading) {
            AppOverlay.dismiss();
          }

          if (previous is! PasswordUpdateError && current is PasswordUpdateError) {
            AppOverlay.dismiss();
            XSnackBar.error(error: AppStrings.login.updatePasswordError).show(context);
          }

          if (previous is! PasswordResetSuccess && current is PasswordResetSuccess) {
            XSnackBar.success(message: AppStrings.login.resetPasswordSuccess).show(context);
            AppRoutes.replaceToLoginPage();
          }

          return previous != current;
        },
        builder: (context, state) {
          return Scaffold(
            body: Form(
              key: _formKey,
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 700),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      XTypography.headingRegular(AppStrings.login.changePasswordTitle),
                      const SizedBox(height: 32),
                      TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: AppStrings.login.newPassword,
                            border: const OutlineInputBorder(),
                          ),
                          onChanged: (_) => _formKey.currentState!.validate(),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) return null;
                            final bool isValid = UserValidationConstants.passwordRegex.hasMatch(value);

                            if (!isValid) {
                              return AppStrings.login.invalidPassword;
                            }

                            setState(() {
                              _isPasswordValid = isValid;
                            });

                            return null;
                          }),
                      const SizedBox(height: 8),
                      TextFormField(
                          controller: _passwordConfirmationController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: AppStrings.login.confirmPassword,
                            border: const OutlineInputBorder(),
                          ),
                          onChanged: (_) => _formKey.currentState!.validate(),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) return null;

                            final isConfirmationPassValid = _passwordController.text == value;
                            setState(() {
                              _isValid = _isPasswordValid && isConfirmationPassValid;
                            });

                            if (!_isValid) return AppStrings.login.confirmationPasswordDoNotMatch;
                            return null;
                          }),
                      const SizedBox(height: 16),
                      XPrimaryButton(
                        AppStrings.login.updatePassword,
                        onPressed: _isValid ? () => _updatePassword(context) : null,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
