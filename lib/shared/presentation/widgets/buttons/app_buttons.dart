import 'package:flutter/material.dart';
import 'package:substore_app/shared/app_colors/colors.dart';
import 'package:substore_app/shared/typography/typography.dart';

class XPrimaryButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final Widget? child;
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsetsGeometry? stylePadding;
  final Color? textColor;
  final Color? foregroundColor;
  final Color? backgroundColor;

  const XPrimaryButton(
    this.text, {
    required this.onPressed,
    this.child,
    this.contentPadding,
    this.stylePadding,
    this.textColor,
    this.foregroundColor,
    this.backgroundColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: stylePadding,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        foregroundColor: foregroundColor ?? Colors.white,
        backgroundColor: backgroundColor ?? XColors.global,
        disabledBackgroundColor: Colors.grey,
      ),
      child: Padding(
        padding: contentPadding ?? EdgeInsets.zero,
        child: child ??
            XTypography.headingSmall(text, color: textColor ?? Colors.white),
      ),
    );
  }
}

class XPrimaryIconButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final void Function()? onPressed;
  final EdgeInsetsGeometry? contentPadding;
  final Color? textColor;
  final Color? foregroundColor;
  final Color? backgroundColor;

  const XPrimaryIconButton({
    required this.text,
    required this.onPressed,
    this.icon,
    this.contentPadding,
    this.textColor,
    this.foregroundColor,
    this.backgroundColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      label: XTypography.headingSmall(text, color: textColor ?? Colors.white),
      icon: Icon(
        icon ?? Icons.chevron_right,
        size: 14,
        color: textColor ?? Colors.white,
      ),
      onPressed: onPressed,
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        foregroundColor: foregroundColor ?? Colors.white,
        backgroundColor: backgroundColor ?? XColors.global,
        disabledBackgroundColor: Colors.grey,
      ),
    );
  }
}
