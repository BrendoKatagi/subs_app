import 'package:flutter/material.dart';
import 'package:substore_app/shared/app_colors/colors.dart';
import 'package:substore_app/shared/app_strings/app_strings.dart';
import 'package:substore_app/shared/presentation/widgets/buttons/app_buttons.dart';
import 'package:substore_app/shared/widgets/app_bar/base_app_bar.dart';

class DefaultAppBar extends BaseAppBar {
  DefaultAppBar({
    required VoidCallback onPressed,
    required super.profileImageUrl,
    super.key,
  }) : super(
          centerTitle: false,
          title: XPrimaryIconButton(
            text: AppStrings.shared.back,
            icon: Icons.chevron_left,
            backgroundColor: XColors.textFieldBackground[10],
            textColor: XColors.global[50],
            foregroundColor: XColors.global[50],
            onPressed: onPressed,
          ),
          showProfileImage: false,
        );
}
