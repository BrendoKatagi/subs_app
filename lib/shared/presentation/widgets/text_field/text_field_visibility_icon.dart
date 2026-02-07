import 'package:flutter/material.dart';
import 'package:substore_app/shared/app_colors/colors.dart';

class TextFieldVisibilityIcon extends StatelessWidget {
  final bool visible;
  final void Function()? onPressed;
  const TextFieldVisibilityIcon({super.key, required this.visible, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        visible ? Icons.visibility : Icons.visibility_off,
        color: XColors.globalLight[50],
      ),
      onPressed: onPressed,
    );
  }
}
