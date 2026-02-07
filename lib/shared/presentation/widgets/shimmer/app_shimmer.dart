import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:substore_app/shared/app_colors/colors.dart';

class AppShimmer extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final Widget? child;

  const AppShimmer({super.key, required this.width, required this.height, this.borderRadius = 16, this.child});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: XColors.globalLight[10]!,
      highlightColor: XColors.globalLight[30]!,
      child: SizedBox(
        width: width,
        height: height,
        child: child ??
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
            ),
      ),
    );
  }
}
