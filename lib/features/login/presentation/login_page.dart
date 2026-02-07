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
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final AuthUserCubit _authCubit;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _authCubit = GetIt.I.get<AuthUserCubit>();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool get _isFormValid {
    return _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;
  }

  void _onFieldChanged() => setState(() {});

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) return;
    _authCubit.login(email: _emailController.text, password: _passwordController.text);
  }

  void _handleLoadingState(AuthUserState current) {
    if (current is AuthUserStateLoginLoading) {
      AppOverlay.show(context, const LoadingOverlay());
    }
  }

  void _handleDismissLoading(AuthUserState previous, AuthUserState current) {
    final wasLoading = previous is AuthUserStateLoginLoading;
    final isDoneLoading = current is! AuthUserStateLoginLoading;
    if (wasLoading && isDoneLoading) {
      AppOverlay.dismiss();
    }
  }

  void _handleErrorState(AuthUserState current) {
    if (current is AuthUserStateLoginError) {
      AppOverlay.dismiss();
      AppOverlay.dismiss(); // Ensure overlay is dismissed
      XSnackBar.error(error: AppStrings.login.loginError).show(context);
    }
  }

  void _handleInvalidState(AuthUserState current) {
    if (current is AuthUserStateLoginInvalid) {
      XSnackBar.error(error: current.errorMessage ?? AppStrings.login.loginError).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _authCubit,
      child: Scaffold(
        body: BlocListener<AuthUserCubit, AuthUserState>(
          listener: (context, state) {
            _handleLoadingState(state);
            if (context.mounted) _handleDismissLoading(state, state);
            _handleErrorState(state);
            _handleInvalidState(state);
          },
          child: _buildFormContent(),
        ),
      ),
    );
  }

  Widget _buildFormContent() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          const Spacer(),
          _buildLoginForm(),
          _buildFooterLogo(),
        ],
      ),
    );
  }

  Widget _buildLoginForm() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      constraints: const BoxConstraints(maxWidth: 600),
      child: Wrap(
        runSpacing: 21,
        children: <Widget>[
          _buildTitle(),
          _buildEmailField(),
          _buildPasswordField(),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: XTypography.headingRegularBold(AppStrings.login.login, maxLines: 1),
    );
  }

  Widget _buildEmailField() {
    return XTextField(
      controller: _emailController,
      width: 700,
      labelText: AppStrings.login.email,
      fillColor: XColors.textFieldBackground[20],
      onChanged: (_) => _onFieldChanged(),
    );
  }

  Widget _buildPasswordField() {
    return BlocBuilder<AuthUserCubit, AuthUserState>(
      builder: (context, state) {
        final errorMessage = state is AuthUserStateLoginInvalid ? (state.errorMessage ?? '') : '';
        return VisibilityTextField(
          controller: _passwordController,
          width: 700,
          labelText: AppStrings.login.password,
          fillColor: XColors.textFieldBackground[20],
          onChanged: (_) => _onFieldChanged(),
          errorMessage: errorMessage,
        );
      },
    );
  }

  Widget _buildActionButtons() {
    final isSmallDevice = context.isSmallDevice();
    return Flex(
      direction: isSmallDevice ? Axis.vertical : Axis.horizontal,
      mainAxisAlignment: isSmallDevice ? MainAxisAlignment.center : MainAxisAlignment.spaceBetween,
      children: [
        XPrimaryButton(
          AppStrings.login.loginButton,
          onPressed: _isFormValid ? _onSubmit : null,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        ),
        if (isSmallDevice) const SizedBox(height: 10),
        _buildNavigationLinks(),
      ],
    );
  }

  Widget _buildNavigationLinks() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildLink(
          text: AppStrings.login.signIn,
          onTap: () => AppRoutes.navigateToSignUpPage(context),
        ),
        XTypography.paragraphRegular(AppStrings.login.signInDivider),
        _buildLink(
          text: AppStrings.login.forgotMyPassword,
          onTap: () => AppRoutes.navigateToResetPasswordPage(context),
        ),
      ],
    );
  }

  Widget _buildLink({required String text, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: XTypography.paragraphRegular(text),
    );
  }

  Widget _buildFooterLogo() {
    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: 80,
          padding: const EdgeInsets.only(bottom: 20),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/logo_dark.png'),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
