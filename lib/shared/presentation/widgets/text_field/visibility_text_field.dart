import 'package:flutter/material.dart';
import 'package:substore_app/shared/presentation/widgets/text_field/text_field.dart';
import 'package:substore_app/shared/presentation/widgets/text_field/text_field_visibility_icon.dart';

class VisibilityTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String? title;
  final double width;
  final Color? fillColor;
  final Widget? icon;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final String? errorMessage;
  final double elevation;

  const VisibilityTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.title,
    required this.width,
    this.fillColor,
    this.icon,
    this.onChanged,
    this.validator,
    this.errorMessage,
    this.elevation = 5,
  });

  @override
  State<VisibilityTextField> createState() => _VisibilityTextFieldState();
}

class _VisibilityTextFieldState extends State<VisibilityTextField> {
  late bool showPassword;

  @override
  void initState() {
    showPassword = false;
    super.initState();
  }

  void _changePasswordVisibility() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return XTextField(
      controller: widget.controller,
      labelText: widget.labelText,
      title: widget.title,
      width: widget.width,
      obscureText: !showPassword,
      fillColor: widget.fillColor,
      icon: widget.icon,
      suffixIcon: TextFieldVisibilityIcon(visible: showPassword, onPressed: _changePasswordVisibility),
      onChanged: widget.onChanged,
      validator: widget.validator,
      errorMessage: widget.errorMessage,
      elevation: widget.elevation,
    );
  }
}
