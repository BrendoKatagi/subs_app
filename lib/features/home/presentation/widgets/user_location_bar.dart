import 'package:flutter/material.dart';
import 'package:substore_app/shared/app_colors/colors.dart';
import 'package:substore_app/shared/typography/typography.dart';

class UserLocationBar extends StatelessWidget {
  const UserLocationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
      decoration: BoxDecoration(
          color: XColors.global[50],
          borderRadius: const BorderRadius.all(Radius.circular(100))),
      child: Row(
        children: [
          Icon(Icons.place, color: XColors.globalLight[10]),
          const SizedBox(width: 10),
          XTypography.paragraphRegular(
            'São José dos Campos',
            color: XColors.globalLight[10]!,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
