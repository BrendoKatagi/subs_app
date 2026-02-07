import 'package:flutter/material.dart';
import 'package:substore_app/config/app_routes.dart';
import 'package:substore_app/shared/app_colors/colors.dart';
import 'package:substore_app/shared/app_strings/app_strings.dart';
import 'package:substore_app/shared/presentation/widgets/buttons/app_buttons.dart';
import 'package:substore_app/shared/typography/typography.dart';

class RegistrationSuccessModal extends StatelessWidget {
  const RegistrationSuccessModal({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.check_circle_outline,
                    color: XColors.global[50], size: 24),
                XTypography.headingRegularBold(
                  AppStrings.signUp.registrationConcluded,
                ),
                const SizedBox(height: 12),
                XTypography.paragraphRegular(AppStrings.signUp.nowYouCanAccess,
                    textAlign: TextAlign.center),
                const SizedBox(height: 25),
                XPrimaryButton(
                  AppStrings.signUp.loginAction,
                  onPressed: AppRoutes.replaceToLoginPage,
                  contentPadding: const EdgeInsets.all(8),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  static void show(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return const RegistrationSuccessModal();
      },
    );
  }
}
