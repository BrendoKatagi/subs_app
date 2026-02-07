import 'package:flutter/material.dart';
import 'package:substore_app/config/app_routes.dart';
import 'package:substore_app/shared/app_strings/app_strings.dart';
import 'package:substore_app/shared/presentation/widgets/buttons/app_buttons.dart';
import 'package:substore_app/shared/typography/typography.dart';

class ErrorOverlay extends StatelessWidget {
  final String? title;
  final String? description;
  final VoidCallback? onPop;

  const ErrorOverlay({super.key, this.title, this.description, this.onPop});

  void show(BuildContext context) => showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return ErrorOverlay(
            title: title,
            description: description,
            onPop: onPop,
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    final safeBottomInsets = MediaQuery.of(context).viewInsets.bottom;
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(32)),
      ),
      height: 300 + safeBottomInsets,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        children: [
          const Icon(Icons.error, color: Color.fromARGB(255, 243, 228, 90), size: 40),
          const SizedBox(height: 16),
          XTypography.headingRegular(title ?? AppStrings.shared.ops),
          const SizedBox(height: 16),
          XTypography.paragraphRegularMedium(description ?? AppStrings.shared.somethingIsWrong, textAlign: TextAlign.center),
          const SizedBox(height: 32),
          XPrimaryButton(AppStrings.shared.ok, onPressed: () async {
            AppRoutes.pop(context);
            onPop?.call();
          }),
        ],
      ),
    );
  }
}
