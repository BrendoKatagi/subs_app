import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:substore_app/features/login/presentation/cubit/password_cubit.dart';
import 'package:substore_app/features/login/presentation/cubit/password_state.dart';
import 'package:substore_app/shared/app_strings/app_strings.dart';
import 'package:substore_app/shared/constants/user_validation_constants.dart';
import 'package:substore_app/shared/presentation/widgets/buttons/app_buttons.dart';
import 'package:substore_app/shared/presentation/widgets/overlay/app_overlay.dart';
import 'package:substore_app/shared/presentation/widgets/overlay/loading_overlay.dart';
import 'package:substore_app/shared/presentation/widgets/snack_bar/app_snack_bar.dart';
import 'package:substore_app/shared/typography/typography.dart';

class PasswordResetPage extends StatefulWidget {
  const PasswordResetPage({super.key});

  @override
  State<PasswordResetPage> createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late bool _isValid;

  @override
  void initState() {
    _emailController = TextEditingController();
    _isValid = false;

    super.initState();
  }

  void _resetPassword(BuildContext context) {
    final String email = _emailController.text;
    context.read<PasswordCubit>().resetPassword(email: email);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PasswordCubit>(
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

          if (previous is! PasswordResetError && current is PasswordResetError) {
            AppOverlay.dismiss();
            XSnackBar.error(error: AppStrings.login.resetPasswordError).show(context);
          }

          if (previous is! PasswordResetSuccess && current is PasswordResetSuccess) {
            AppOverlay.dismiss();
            XSnackBar.success(message: AppStrings.login.resetPasswordSuccess).show(context);
          }
          return previous != current;
        },
        builder: (context, state) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Form(
                key: _formKey,
                child: Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 700),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        XTypography.headingRegular(AppStrings.login.changePasswordTitle),
                        const SizedBox(height: 8),
                        XTypography.paragraphRegular(AppStrings.login.changePasswordDescription, textAlign: TextAlign.center),
                        const SizedBox(height: 32),
                        Container(
                          constraints: const BoxConstraints(maxWidth: 500),
                          child: TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                              labelText: AppStrings.login.email,
                              border: const OutlineInputBorder(),
                            ),
                            onChanged: (_) => _formKey.currentState!.validate(),
                            validator: _emailValidator,
                          ),
                        ),
                        const SizedBox(height: 36),
                        XPrimaryButton(
                          AppStrings.login.changePassword,
                          onPressed: _isValid ? () => _resetPassword(context) : null,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  String? _emailValidator(String? value) {
    if (value == null) return null;
    final bool isValid = UserValidationConstants.emailRegex.hasMatch(value);
    setState(() {
      _isValid = isValid;
    });

    if (!isValid) {
      return AppStrings.login.invalidEmail;
    }

    return null;
  }
}
