import 'package:flutter/material.dart';
import 'package:substore_app/shared/app_colors/colors.dart';
import 'package:substore_app/shared/app_strings/app_strings.dart';
import 'package:substore_app/shared/presentation/widgets/buttons/app_buttons.dart';
import 'package:substore_app/shared/typography/typography.dart';

class AdvertisingCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final void Function()? onPressed;

  const AdvertisingCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: XColors.globalLight[20],
      child: SizedBox(
        height: 200,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              XTypography.headingSmallRegularBold(title),
              const SizedBox(height: 7),
              XTypography.headingSmall(subtitle),
              const Spacer(),
              if (onPressed != null)
                SizedBox(
                  width: 130,
                  child: XPrimaryIconButton(
                    text: AppStrings.shared.learnMore,
                    onPressed: onPressed,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
