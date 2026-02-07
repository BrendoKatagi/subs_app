import 'package:flutter/material.dart';
import 'package:substore_app/shared/app_colors/colors.dart';
import 'package:substore_app/shared/typography/typography.dart';

class XTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? title;
  final double width;
  final bool obscureText;
  final Color? fillColor;
  final Widget? icon;
  final Widget? suffixIcon;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final String? errorMessage;
  final double elevation;

  const XTextField({
    required this.controller,
    required this.width,
    required this.labelText,
    super.key,
    this.obscureText = false,
    this.title,
    this.fillColor,
    this.icon,
    this.onChanged,
    this.validator,
    this.errorMessage,
    this.elevation = 5,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: width),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...buildTitle(),
          Material(
            elevation: elevation,
            borderRadius: const BorderRadius.all(Radius.circular(100)),
            child: TextFormField(
              controller: controller,
              obscureText: obscureText,
              onChanged: onChanged,
              validator: validator,
              decoration: InputDecoration(
                filled: true,
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100), borderSide: const BorderSide(color: XColors.border)),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100), borderSide: const BorderSide(color: XColors.border)),
                errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100), borderSide: const BorderSide(color: XColors.warning)),
                fillColor: fillColor ?? XColors.textFieldBackground,
                labelText: labelText,
                labelStyle: const TextStyle(color: Color(0xFF9D9D9D)),
                contentPadding: const EdgeInsets.only(left: 22),
                prefixIcon: icon,
                suffixIcon: suffixIcon,
              ),
            ),
          ),
          if (errorMessage != null)
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 14, left: 10),
                child: XTypography.paragraphRegular(errorMessage ?? '', color: Colors.red),
              ),
            ),
        ],
      ),
    );
  }

  List<Widget> buildTitle() {
    return <Widget>[
      Padding(
        padding: const EdgeInsets.only(left: 10),
        child: XTypography.headingSmall(title!),
      ),
      const SizedBox(height: 8),
    ];
  }
}
