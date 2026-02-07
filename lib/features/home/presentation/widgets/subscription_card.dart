import 'package:flutter/material.dart';
import 'package:substore_app/config/app_routes.dart';
import 'package:substore_app/features/subscription/domain/entities/store.dart';
import 'package:substore_app/features/subscription/domain/entities/subscription_plan.dart';
import 'package:substore_app/shared/app_colors/colors.dart';
import 'package:substore_app/shared/app_strings/app_strings.dart';
import 'package:substore_app/shared/typography/typography.dart';

class SubscriptionCard extends StatelessWidget {
  final Store store;
  final SubscriptionPlan subscriptionPlan;

  const SubscriptionCard({
    required this.store,
    required this.subscriptionPlan,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      surfaceTintColor: Colors.white,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          AppRoutes.navigateToStorePage(context, store);
        },
        child: Row(
          children: <Widget>[
            SubscriptionCardHeader(imagePath: store.coverImageUrl),
            const SizedBox(width: 16),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    XTypography.headingSmallRegular(
                      subscriptionPlan.title,
                      color: XColors.global[20]!,
                    ),
                    XTypography.headingSmallRegularBold(
                      store.name!,
                      color: XColors.global[20]!,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Icon(
                          Icons.label,
                          size: 18,
                          color: XColors.globalLight[10],
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: XTypography.paragraphRegular(
                            subscriptionPlan.availableTickets.plural(
                              AppStrings.home.availableTicket,
                              AppStrings.home.availableTickets,
                            ),
                            color: XColors.global[100]!,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SubscriptionCardHeader extends StatelessWidget {
  final String? imagePath;

  const SubscriptionCardHeader({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 93,
      width: 120,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        image: DecorationImage(
          image: (imagePath?.isNotEmpty ?? false ? Image.network(imagePath!) : Image.asset('assets/images/store-cover.webp')).image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
