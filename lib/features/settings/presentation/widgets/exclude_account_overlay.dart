import 'package:flutter/material.dart';
import 'package:substore_app/shared/app_strings/app_strings.dart';
import 'package:substore_app/shared/presentation/widgets/overlay/information_options_overlay.dart';

class ExcludeAccountOverlay {
  final VoidCallback onActionButtonTap;
  const ExcludeAccountOverlay({required this.onActionButtonTap});

  void show(BuildContext context) => InformationOptionsOverlay.show(
        context,
        title: AppStrings.settings.areYouSure,
        description: AppStrings.settings.excludeAccountDescription,
        actionButtonText: AppStrings.settings.delete,
        icon: const Icon(Icons.help_outline_outlined, color: Colors.blue, size: 50),
        onActionButtonTap: onActionButtonTap,
      );
}
