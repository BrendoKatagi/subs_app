import 'package:flutter/material.dart';
import 'package:substore_app/shared/app_colors/colors.dart';
import 'package:substore_app/shared/typography/typography.dart';

class XSnackBar {
  final Widget content;
  final Color color;

  const XSnackBar({
    required this.content,
    this.color = XColors.global,
  });

  factory XSnackBar.error({required String error}) => XSnackBar(
        content: XTypography.headingSmallRegular(error, color: Colors.white),
        color: XColors.warning,
      );

  factory XSnackBar.success({required String message}) => XSnackBar(
        content: XTypography.headingSmallRegular(message, color: Colors.white),
        color: XColors.success,
      );

  SnackBar snackBar() => SnackBar(
        content: content,
        backgroundColor: color,
      );

  void show(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => ScaffoldMessenger.of(context).showSnackBar(snackBar()));
  }
}
