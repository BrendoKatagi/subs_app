import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:substore_app/shared/app_strings/app_strings.dart';
import 'package:substore_app/shared/presentation/widgets/buttons/app_buttons.dart';

class CopyButton extends StatefulWidget {
  final String textToCopy;

  const CopyButton({super.key, required this.textToCopy});

  @override
  State<CopyButton> createState() => _CopyButtonState();
}

class _CopyButtonState extends State<CopyButton> {
  final Duration copyMessageDuration = const Duration(seconds: 2);
  late String text;

  @override
  void initState() {
    text = AppStrings.shared.copy;
    super.initState();
  }

  void setText(String currentText) => setState(() {
        text = currentText;
      });

  Future<void> onTap() async {
    await Clipboard.setData(ClipboardData(text: widget.textToCopy));
    setText(AppStrings.shared.copied);
    await Future<void>.delayed(copyMessageDuration);
    setText(AppStrings.shared.copy);
  }

  @override
  Widget build(BuildContext context) {
    return XPrimaryIconButton(
      text: text,
      onPressed: onTap,
      icon: Icons.copy,
    );
  }
}
