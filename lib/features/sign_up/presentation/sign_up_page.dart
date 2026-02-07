import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:substore_app/config/app_routes.dart';
import 'package:substore_app/features/sign_up/presentation/controllers/sign_up_cubit.dart';
import 'package:substore_app/features/sign_up/presentation/resources/sign_up_validators.dart';
import 'package:substore_app/features/store_user/registration_success_modal.dart';
import 'package:substore_app/features/users/data/models/user_registration_model.dart';
import 'package:substore_app/shared/app_colors/colors.dart';
import 'package:substore_app/shared/app_strings/app_strings.dart';
import 'package:substore_app/shared/extensions/view_port.dart';
import 'package:substore_app/shared/presentation/widgets/buttons/app_buttons.dart';
import 'package:substore_app/shared/presentation/widgets/overlay/app_overlay.dart';
import 'package:substore_app/shared/presentation/widgets/overlay/loading_overlay.dart';
import 'package:substore_app/shared/presentation/widgets/snack_bar/app_snack_bar.dart';
import 'package:substore_app/shared/presentation/widgets/text_field/text_field.dart';
import 'package:substore_app/shared/typography/typography.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _passwordConfirmationController;
  late TextEditingController _nameController;
  late TextEditingController _cpfController;
  late TextEditingController _cellphoneController;

  late String? emailErrorMessage;
  late String? passwordErrorMessage;
  late String? confirmationPasswordErrorMessage;
  late String? nameErrorMessage;
  late String? cpfErrorMessage;
  late String? cellphoneErrorMessage;
  late bool isValid;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmationController.dispose();
    _nameController.dispose();
    _cpfController.dispose();
    _cellphoneController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _passwordConfirmationController = TextEditingController();
    _nameController = TextEditingController();
    _cpfController = TextEditingController();
    _cellphoneController = TextEditingController();

    emailErrorMessage = null;
    passwordErrorMessage = null;
    confirmationPasswordErrorMessage = null;
    nameErrorMessage = null;
    cpfErrorMessage = null;
    cellphoneErrorMessage = null;

    isValid = false;
    super.initState();
  }

  void validator(String value, InputType type) {
    late String? errorMessage;
    final validator = typeToValidatorMap[type];

    if (validator != null) {
      errorMessage = validator(value);
    }

    switch (type) {
      case InputType.email:
        setState(() {
          emailErrorMessage = errorMessage;
        });
        break;
      case InputType.name:
        setState(() {
          nameErrorMessage = errorMessage;
        });
        break;
      case InputType.cpf:
        setState(() {
          cpfErrorMessage = errorMessage;
        });
        break;
      case InputType.cellphone:
        setState(() {
          cellphoneErrorMessage = errorMessage;
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpCubit>(
      create: (context) => GetIt.I.get<SignUpCubit>(),
      child: BlocConsumer<SignUpCubit, SignUpState>(
        listener: (BuildContext context, SignUpState state) {},
        listenWhen: (SignUpState previous, SignUpState current) {
          if (current is SignUpLoading) {
            AppOverlay.show(context, const LoadingOverlay());
          }

          if (previous is SignUpLoading && current is SignUpSuccess) {
            AppOverlay.dismiss();
            RegistrationSuccessModal.show(context);
          }

          if (previous is! SignUpError && current is SignUpError) {
            AppOverlay.dismiss();
            XSnackBar.error(error: AppStrings.signUp.signUpError).show(context);
          }
          return current != previous;
        },
        builder: (BuildContext context, SignUpState state) {
          final double textFieldWidth = context.isMediumDevice() ? 350 : 600;
          final Size pageSize = MediaQuery.of(context).size;
          return Scaffold(
            body: SafeArea(
              child: Align(
                alignment: Alignment.topCenter,
                child: Form(
                  key: _formKey,
                  child: SizedBox(
                    width: double.infinity,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Container(
                              constraints: const BoxConstraints(maxWidth: 600),
                              child: Column(
                                children: <Widget>[
                                  Wrap(
                                    direction: Axis.vertical,
                                    spacing: 24,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(top: 30, left: 10, bottom: 16),
                                        child: SizedBox(
                                          width: pageSize.width,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              XTypography.headingRegularBold(AppStrings.signUp.almostThere, maxLines: 1),
                                              const SizedBox(height: 8),
                                              XTypography.paragraphRegular(AppStrings.signUp.registerOrLogin, fontSize: 14, maxLines: 2),
                                            ],
                                          ),
                                        ),
                                      ),
                                      XTextField(
                                        controller: _nameController,
                                        width: textFieldWidth,
                                        labelText: AppStrings.signUp.nameAndSurname,
                                        fillColor: XColors.textFieldBackground[20],
                                        onChanged: (String value) {
                                          validator(value, InputType.name);
                                          _onChanged();
                                        },
                                        errorMessage: nameErrorMessage,
                                        elevation: 0,
                                      ),
                                      XTextField(
                                        controller: _emailController,
                                        width: textFieldWidth,
                                        labelText: AppStrings.login.email,
                                        fillColor: XColors.textFieldBackground[20],
                                        onChanged: (String value) {
                                          validator(value, InputType.email);
                                          _onChanged();
                                        },
                                        errorMessage: emailErrorMessage,
                                        elevation: 0,
                                      ),
                                      XTextField(
                                        controller: _cpfController,
                                        width: textFieldWidth,
                                        labelText: AppStrings.shared.cpf,
                                        fillColor: XColors.textFieldBackground[20],
                                        onChanged: (String value) {
                                          validator(value, InputType.cpf);
                                          _onChanged();
                                        },
                                        errorMessage: cpfErrorMessage,
                                        elevation: 0,
                                      ),
                                      XTextField(
                                        controller: _cellphoneController,
                                        width: textFieldWidth,
                                        labelText: AppStrings.signUp.cellphoneLabel,
                                        fillColor: XColors.textFieldBackground[20],
                                        onChanged: (String value) {
                                          validator(value, InputType.cellphone);
                                          _onChanged();
                                        },
                                        errorMessage: cellphoneErrorMessage,
                                        elevation: 0,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10, top: 34),
                                        child: SizedBox(
                                          width: pageSize.width,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              XTypography.headingSmallRegular(AppStrings.signUp.defineYourPassword),
                                              XTypography.paragraphRegular(AppStrings.signUp.passwordRules, color: XColors.globalLight[50]!),
                                            ],
                                          ),
                                        ),
                                      ),
                                      XTextField(
                                        controller: _passwordController,
                                        width: textFieldWidth,
                                        labelText: AppStrings.login.password,
                                        fillColor: XColors.textFieldBackground[20],
                                        obscureText: true,
                                        onChanged: (String value) {
                                          passwordValidator(value);
                                          _onChanged();
                                        },
                                        errorMessage: passwordErrorMessage,
                                        elevation: 0,
                                      ),
                                      XTextField(
                                        controller: _passwordConfirmationController,
                                        width: textFieldWidth,
                                        labelText: AppStrings.signUp.confirmYouPassword,
                                        fillColor: XColors.textFieldBackground[20],
                                        obscureText: true,
                                        onChanged: (String value) {
                                          confirmPasswordValidator(value);
                                          _onChanged();
                                        },
                                        errorMessage: confirmationPasswordErrorMessage,
                                        elevation: 0,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 12,
                                          bottom: 20,
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            XPrimaryButton(
                                              AppStrings.signUp.signUp,
                                              onPressed: isValid ? () => _onSubmitPress(context) : null,
                                              contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                            ),
                                            const SizedBox(width: 24),
                                            InkWell(
                                                onTap: AppRoutes.replaceToLoginPage,
                                                child: XTypography.paragraphRegularBold(AppStrings.signUp.alreadyRegistered)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 70),
                          Flexible(
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
                          const SizedBox(height: 30)
                        ],
                      ),
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

  void passwordValidator(String password) {
    final errorMessage = validatePassword(password);
    final confirmationMessage = validateConfirmationPassword(password, _passwordConfirmationController.text);

    setState(() {
      passwordErrorMessage = errorMessage;
      confirmationPasswordErrorMessage = confirmationMessage;
    });
  }

  void confirmPasswordValidator(String password) {
    final errorMessage = validateConfirmationPassword(_passwordController.text, password);

    setState(() {
      confirmationPasswordErrorMessage = errorMessage;
    });
  }

  void _onSubmitPress(BuildContext context) {
    final SignUpCubit cubit = context.read<SignUpCubit>();
    final String email = _emailController.text;
    final String password = _passwordController.text;
    final String name = _nameController.text;
    final String cpf = _cpfController.text.replaceAll(RegExp(r'[^\d]'), '');
    final String cellphone = _cellphoneController.text;

    final registerParams = UserRegistrationModel(
      email: email,
      name: name,
      cpf: cpf,
      phoneNumber: cellphone,
      password: password,
    );

    cubit.signUp(registerParams);
  }

  void _onChanged() {
    final bool isNotEmpty = _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _passwordConfirmationController.text.isNotEmpty &&
        _nameController.text.isNotEmpty &&
        _cpfController.text.isNotEmpty &&
        _cellphoneController.text.isNotEmpty;

    final List<String?> validatorTexts = [
      emailErrorMessage,
      passwordErrorMessage,
      confirmationPasswordErrorMessage,
      nameErrorMessage,
      cpfErrorMessage,
      cellphoneErrorMessage,
    ];

    final bool isValidated = validatorTexts.every((element) => element == null);
    final bool validation = isNotEmpty && isValidated;

    if (validation != isValid) {
      setState(() {
        isValid = validation;
      });
    }
  }
}

enum InputType {
  name,
  email,
  cpf,
  cellphone,
}

Map<InputType, String? Function(String)> typeToValidatorMap = {
  InputType.name: validateName,
  InputType.email: validateEmail,
  InputType.cpf: validateCpf,
  InputType.cellphone: validateCellphone,
};
