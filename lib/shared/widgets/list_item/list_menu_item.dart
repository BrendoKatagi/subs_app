import 'package:flutter/material.dart';
import 'package:substore_app/shared/typography/typography.dart';

class ListMenuItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final void Function()? onTap;

  const ListMenuItem(
      {super.key, required this.text, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 48,
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 12),
            XTypography.headingSmallRegular(text),
            const Spacer(),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}
