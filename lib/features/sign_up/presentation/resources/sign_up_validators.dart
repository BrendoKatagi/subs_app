import 'package:substore_app/shared/app_strings/app_strings.dart';
import 'package:substore_app/shared/constants/user_validation_constants.dart';

String? validateEmail(String email) {
  return UserValidationConstants.emailRegex.hasMatch(email)
      ? null
      : AppStrings.login.invalidEmail;
}

String? validatePassword(String password) {
  return UserValidationConstants.passwordRegex.hasMatch(password)
      ? null
      : AppStrings.login.invalidPassword;
}

String? validateConfirmationPassword(
    String password, String confirmationPassword) {
  return password == confirmationPassword
      ? null
      : AppStrings.signUp.confirmationPasswordError;
}

String? validateName(String name) {
  return name.isNotEmpty ? null : AppStrings.signUp.invalidName;
}

String? validateCpf(String cpf) {
  String formattedCpf;
  final String errorMessage = AppStrings.signUp.invalidCpf;
  // Remove pontos e traços, se presentes
  formattedCpf = cpf.replaceAll(RegExp(r'[^\d]'), '');

  // Verifica se o CPF tem 11 dígitos
  if (formattedCpf.length != 11) {
    return errorMessage;
  }

  // Calcula o primeiro dígito verificador
  int soma = 0;
  for (int i = 0; i < 9; i++) {
    soma += int.parse(formattedCpf[i]) * (10 - i);
  }
  final int digitoVerificador1 = (soma % 11 < 2) ? 0 : 11 - (soma % 11);

  // Verifica o primeiro dígito verificador
  if (digitoVerificador1 != int.parse(formattedCpf[9])) {
    return errorMessage;
  }

  // Calcula o segundo dígito verificador
  soma = 0;
  for (int i = 0; i < 10; i++) {
    soma += int.parse(formattedCpf[i]) * (11 - i);
  }
  final int digitoVerificador2 = (soma % 11 < 2) ? 0 : 11 - (soma % 11);

  // Verifica o segundo dígito verificador
  if (digitoVerificador2 != int.parse(cpf[10])) {
    return errorMessage;
  }

  return null;
}

String? validateCellphone(String? cellphone) {
  return cellphone != null &&
          UserValidationConstants.cellphoneRegex.hasMatch(cellphone)
      ? null
      : AppStrings.signUp.invalidCellphone;
}
