import 'package:flutter/material.dart';
import 'package:substore_app/features/store/domain/entities/check_in.dart';
import 'package:substore_app/shared/app_colors/colors.dart';
import 'package:substore_app/shared/extensions/date_time_extensions.dart';
import 'package:substore_app/shared/typography/typography.dart';

class CheckInWidget extends StatelessWidget {
  final CheckIn checkIn;

  const CheckInWidget({required this.checkIn, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      decoration: const BoxDecoration(
        color: Color(0xFFD9D9D9),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          XTypography.headingSmallRegularBold(
            checkIn.checkInData!,
            color: XColors.global[20]!,
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    XTypography.headingSmallRegular(
                      checkIn.title,
                      color: XColors.global[20]!,
                    ),
                    const SizedBox(height: 4),
                    XTypography.paragraphRegular(
                      checkIn.checkInDateTime!.toFormattedString('às'),
                      color: XColors.global[20]!,
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    XTypography.headingSmallRegular(
                      checkIn.userName,
                      color: XColors.global[20]!,
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
