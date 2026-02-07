import 'package:flutter/material.dart';
import 'package:substore_app/shared/presentation/widgets/shimmer/app_shimmer.dart';
import 'package:substore_app/shared/typography/typography.dart';

class QuickReportItem extends StatelessWidget {
  final String title;
  final String? value;
  final bool isLoading;

  const QuickReportItem({super.key, required this.title, this.value, required this.isLoading});

  factory QuickReportItem.loading() => const QuickReportItem(isLoading: true, title: '');

  @override
  Widget build(BuildContext context) {
    final String formattedValue = value ?? '-';
    return Card(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      child: SizedBox(
        width: 155,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _LoadingText(text: XTypography.headingSmall(title, textAlign: TextAlign.center, overflow: TextOverflow.ellipsis), isLoading: isLoading),
              const SizedBox(height: 4),
              _LoadingText(text: XTypography.headingSmall(formattedValue, fontSize: 14), isLoading: isLoading),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoadingText extends StatelessWidget {
  final Text text;
  final bool isLoading;

  const _LoadingText({required this.text, required this.isLoading});
  @override
  Widget build(BuildContext context) {
    return isLoading ? const AppShimmer(width: 80, height: 20) : text;
  }
}
