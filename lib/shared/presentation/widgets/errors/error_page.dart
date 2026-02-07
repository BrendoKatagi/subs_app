import 'package:flutter/material.dart';
import 'package:substore_app/shared/app_colors/colors.dart';
import 'package:substore_app/shared/typography/typography.dart';

class ErrorPage extends StatelessWidget {
  final String title;
  final String description;

  const ErrorPage({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: XColors.globalLight[5],
      body: SafeArea(
        child: Expanded(
            child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.report, color: XColors.globalLight[30], size: 50),
                const SizedBox(height: 16),
                XTypography.headingRegularBold(title, color: XColors.globalLight[50]!, maxLines: 2),
                const SizedBox(height: 8),
                XTypography.headingRegular(description, textAlign: TextAlign.center, color: XColors.global[30]!),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
