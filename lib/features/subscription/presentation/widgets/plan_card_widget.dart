import 'package:flutter/material.dart';
import 'package:substore_app/features/subscription/domain/entities/enum/subscription_stats.dart';
import 'package:substore_app/features/subscription/domain/entities/subscription_plan.dart';
import 'package:substore_app/shared/app_strings/app_strings.dart';
import 'package:substore_app/shared/extensions/double_extensions.dart';
import 'package:substore_app/shared/presentation/widgets/buttons/app_buttons.dart';
import 'package:substore_app/shared/typography/typography.dart';
import 'package:substore_app/shared/utils/url_utils.dart';

class PlanCardWidget extends StatelessWidget {
  final String storeName;
  final String? pageUrl;
  final SubscriptionPlan subscriptionPlan;

  const PlanCardWidget({
    required this.subscriptionPlan,
    required this.storeName,
    this.pageUrl,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textColor =
        subscriptionPlan.subscriptionStats == SubscriptionStats.subscripted
            ? const Color(0xFFB9B9B9)
            : Colors.black;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          XTypography.headingRegular(subscriptionPlan.title, color: textColor),
          XTypography.headingRegularBold(storeName, color: textColor),
          const SizedBox(height: 10),
          if (subscriptionPlan.description != null)
            XTypography.headingSmall(subscriptionPlan.description!,
                color: textColor),
          const SizedBox(height: 28),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              XPrimaryIconButton(
                text: subscriptionPlan.subscriptionStats ==
                        SubscriptionStats.subscripted
                    ? AppStrings.subscription.cancelSubscription
                    : AppStrings.subscription.knowMore,
                onPressed: () {
                  if (subscriptionPlan.subscriptionStats ==
                      SubscriptionStats.available) {
                    final url = pageUrl != null && pageUrl!.isNotEmpty
                        ? pageUrl!
                        : '${AppStrings.subscription.knowMoreUrl}${subscriptionPlan.title}%20da%20loja%20$storeName';

                    openUrl(url);
                  } else {
                    openUrl(
                        '${AppStrings.subscription.cancelPlanUrl}${subscriptionPlan.title}%20da%20loja%20$storeName');
                  }
                },
              ),
              const SizedBox(width: 8),
              Flexible(
                child: XTypography.headingRegular(
                  textAlign: TextAlign.center,
                  'R\$ ${subscriptionPlan.monthlyPrice.toFormattedNumber()} / mês',
                  color: textColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
