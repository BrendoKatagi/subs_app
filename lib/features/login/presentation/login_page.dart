import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:substore_app/config/app_routes.dart';
import 'package:substore_app/features/auth/cubit/auth_user_cubit.dart';
import 'package:substore_app/features/auth/cubit/auth_user_state.dart';
import 'package:substore_app/shared/app_colors/colors.dart';
import 'package:substore_app/shared/app_strings/app_strings.dart';
import 'package:substore_app/shared/extensions/view_port.dart';
import 'package:substore_app/shared/presentation/widgets/buttons/app_buttons.dart';
import 'package:substore_app/shared/presentation/widgets/overlay/app_overlay.dart';
import 'package:substore_app/shared/presentation/widgets/overlay/loading_overlay.dart';
import 'package:substore_app/shared/presentation/widgets/snack_bar/app_snack_bar.dart';
import 'package:substore_app/shared/presentation/widgets/text_field/text_field.dart';
import 'package:substore_app/shared/presentation/widgets/text_field/visibility_text_field.dart';
import 'package:substore_app/shared/typography/typography.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late bool isValid;
  late AuthUserCubit authCubit;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    isValid = false;
    authCubit = GetIt.I.get<AuthUserCubit>();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onSubmitPress(BuildContext context) {
    final String email = _emailController.text;
    final String password = _passwordController.text;

    authCubit.login(email: email, password: password);
  }

  void _onChanged() {
    final bool isNotEmpty = _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;
    if (isNotEmpty != isValid) {
      setState(() {
        isValid = isNotEmpty;
      });
    }
  }

  bool _listener(AuthUserState previous, AuthUserState current) {
    if (current is AuthUserStateLoginLoading) {
      AppOverlay.show(context, const LoadingOverlay());
    }

    if ((previous is AuthUserStateLoginLoading && current is! AuthUserStateLoginLoading) ||
        (previous is AuthUserStateLoginLoading && current is AuthUserStateLogged)) {
      AppOverlay.dismiss();
    }

    if (previous is! AuthUserStateLoginError && current is AuthUserStateLoginError) {
      AppOverlay.dismiss();
      XSnackBar.error(error: AppStrings.login.loginError).show(context);
    }

    return loginStates.contains(current.runtimeType);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: authCubit,
      child: BlocConsumer<AuthUserCubit, AuthUserState>(
        listener: (context, state) {},
        listenWhen: _listener,
        buildWhen: (_, current) => loginStates.contains(current.runtimeType),
        builder: (BuildContext context, AuthUserState state) {
          return Scaffold(
            body: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: Wrap(
                      runSpacing: 21,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: XTypography.headingRegularBold(AppStrings.login.login, maxLines: 1),
                        ),
                        XTextField(
                          controller: _emailController,
                          width: 700,
                          labelText: AppStrings.login.email,
                          fillColor: XColors.textFieldBackground[20],
                          onChanged: (String value) {
                            _onChanged();
                          },
                        ),
                        VisibilityTextField(
                          controller: _passwordController,
                          width: 700,
                          labelText: AppStrings.login.password,
                          fillColor: XColors.textFieldBackground[20],
                          onChanged: (String value) {
                            _onChanged();
                          },
                          errorMessage: state is AuthUserStateLoginInvalid ? state.errorMessage : null,
                        ),
                        Flex(
                          direction: context.isSmallDevice() ? Axis.vertical : Axis.horizontal,
                          mainAxisAlignment: context.isSmallDevice() ? MainAxisAlignment.center : MainAxisAlignment.spaceBetween,
                          children: [
                            XPrimaryButton(
                              AppStrings.login.loginButton,
                              onPressed: isValid ? () => _onSubmitPress(context) : null,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                            ),
                            Visibility(visible: context.isSmallDevice(), child: const SizedBox(height: 10)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(onTap: () => AppRoutes.navigateToSignUpPage(context), child: XTypography.paragraphRegular(AppStrings.login.signIn)),
                                XTypography.paragraphRegular(AppStrings.login.signInDivider),
                                InkWell(
                                  onTap: () => AppRoutes.navigateToResetPasswordPage(context),
                                  child: XTypography.paragraphRegular(AppStrings.login.forgotMyPassword),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: 80,
                        padding: const EdgeInsets.only(bottom: 20),
                        decoration: const BoxDecoration(
                          image: DecorationImage(image: AssetImage('assets/images/logo_dark.png'), fit: BoxFit.contain),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
