import 'package:flutter/material.dart';
import 'package:substore_app/shared/app_strings/app_strings.dart';
import 'package:substore_app/shared/presentation/widgets/cards/advertising_card.dart';
import 'package:substore_app/shared/presentation/widgets/carousel/app_carousel.dart';
import 'package:substore_app/shared/typography/typography.dart';

class AdvertisingSection extends StatefulWidget {
  const AdvertisingSection({super.key});

  @override
  State<AdvertisingSection> createState() => _AdvertisingSectionState();
}

class _AdvertisingSectionState extends State<AdvertisingSection> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          XTypography.headingSmall(AppStrings.home.toYou),
          XCarousel(widgets: listOfCards(), isAnimated: true),
        ],
      ),
    );
  }
}

List<Widget> listOfCards() => <Widget>[
      AdvertisingCard(
        title: AppStrings.home.advertisingSpace,
        subtitle: AppStrings.home.advertisingSubtitle,
        onPressed: () {},
      ),
      AdvertisingCard(
        title: AppStrings.home.advertisingSpace,
        subtitle: AppStrings.home.advertisingSubtitle,
        onPressed: () {},
      ),
      AdvertisingCard(
        title: AppStrings.home.advertisingSpace,
        subtitle: AppStrings.home.advertisingSubtitle,
        onPressed: () {},
      ),
    ];
