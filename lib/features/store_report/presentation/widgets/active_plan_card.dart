import 'package:flutter/material.dart';
import 'package:substore_app/features/store_report/domain/entities/plans_active.dart';
import 'package:substore_app/shared/app_strings/app_strings.dart';
import 'package:substore_app/shared/extensions/int_extensions.dart';
import 'package:substore_app/shared/typography/typography.dart';

class ActivePlanCard extends StatelessWidget {
  final ActivePlan activePlan;
  const ActivePlanCard({super.key, required this.activePlan});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: _ActivePlanTitle(activePlan: activePlan),
          subtitle: _ActivePlanSubtitle(activePlan: activePlan),
          tileColor: Colors.white,
        ),
      ),
    );
  }
}

class _ActivePlanTitle extends StatelessWidget {
  final ActivePlan activePlan;

  const _ActivePlanTitle({required this.activePlan});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              XTypography.headingSmallRegular(activePlan.title ?? '', overflow: TextOverflow.ellipsis),
              XTypography.paragraphRegularMedium(activePlan.userName ?? '', overflow: TextOverflow.ellipsis, fontWeight: FontWeight.w500),
            ],
          ),
        ),
        XTypography.headingRegular(activePlan.price != null ? activePlan.price!.toFormattedReais() : ''),
      ],
    );
  }
}

class _ActivePlanSubtitle extends StatelessWidget {
  final ActivePlan activePlan;

  const _ActivePlanSubtitle({required this.activePlan});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          XTypography.paragraphRegularMedium(AppStrings.storeReport.tickets),
          const SizedBox(height: 4),
          XTypography.paragraphRegular(AppStrings.storeReport.ticketsTypeCount(activePlan), overflow: TextOverflow.ellipsis, fontSize: 13, maxLines: 2),
        ],
      ),
    );
  }
}
