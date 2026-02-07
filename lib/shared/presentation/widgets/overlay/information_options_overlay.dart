import 'package:flutter/material.dart';
import 'package:substore_app/config/app_routes.dart';
import 'package:substore_app/shared/app_strings/app_strings.dart';
import 'package:substore_app/shared/typography/typography.dart';

class InformationOptionsOverlay extends StatelessWidget {
  final String title;
  final String description;
  final String actionButtonText;
  final Icon icon;
  final VoidCallback onActionButtonTap;
  final Color? actionButtonColor;

  const InformationOptionsOverlay({
    super.key,
    required this.title,
    required this.description,
    required this.actionButtonText,
    required this.icon,
    required this.onActionButtonTap,
    this.actionButtonColor,
  });

  static void show(
    BuildContext context, {
    required String title,
    required String description,
    required String actionButtonText,
    required Icon icon,
    required VoidCallback onActionButtonTap,
    Color? actionButtonColor,
  }) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return InformationOptionsOverlay(
          title: title,
          description: description,
          actionButtonText: actionButtonText,
          actionButtonColor: actionButtonColor,
          icon: icon,
          onActionButtonTap: onActionButtonTap,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final safeBottomInsets = MediaQuery.of(context).viewInsets.bottom;
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(32)),
      ),
      padding: const EdgeInsets.all(32),
      height: 300 + safeBottomInsets,
      child: Column(
        children: [
          Expanded(
              child: Align(
            child: Column(
              children: [
                const Icon(Icons.help_outline_outlined, color: Colors.blue, size: 50),
                const SizedBox(height: 12),
                XTypography.headingRegularBold(title),
                const SizedBox(height: 12),
                XTypography.paragraphRegularMedium(
                  description,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () => AppRoutes.pop(context),
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.blue,
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
                          side: const BorderSide(color: Colors.blue)),
                      child: XTypography.paragraphRegularMedium(AppStrings.shared.cancel, color: Colors.blue, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(width: 40),
                    TextButton(
                      onPressed: onActionButtonTap,
                      style: TextButton.styleFrom(
                        backgroundColor: actionButtonColor ?? Colors.red,
                      ),
                      child: XTypography.paragraphRegularMedium(actionButtonText, color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
