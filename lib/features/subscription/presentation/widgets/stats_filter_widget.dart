import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:substore_app/features/subscription/domain/entities/enum/subscription_ticket_stats.dart';
import 'package:substore_app/features/subscription/presentation/cubit/stats_filter_cubit.dart';
import 'package:substore_app/features/subscription/presentation/cubit/stats_filter_state.dart';
import 'package:substore_app/shared/app_strings/app_strings.dart';
import 'package:substore_app/shared/typography/typography.dart';

class StatsFilterWidget extends StatelessWidget {
  const StatsFilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatsFilterCubit, StatsFilterState>(
      bloc: context.read<StatsFilterCubit>(),
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          child: Wrap(
            alignment: WrapAlignment.spaceEvenly,
            runSpacing: 12,
            children: [
              _StatsButton(
                text: AppStrings.subscription.available,
                stats: SubscriptionTicketStats.available,
              ),
              _StatsButton(
                text: AppStrings.subscription.done,
                stats: SubscriptionTicketStats.done,
              ),
              _StatsButton(
                text: AppStrings.subscription.expired,
                stats: SubscriptionTicketStats.expired,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _StatsButton extends StatelessWidget {
  final String text;
  final SubscriptionTicketStats stats;

  const _StatsButton({required this.text, required this.stats});

  @override
  Widget build(BuildContext context) {
    final statsFilterCubit = context.read<StatsFilterCubit>();

    return SizedBox(
      height: 34,
      child: TextButton(
        onPressed: () {
          statsFilterCubit.filterPlansByStats(stats);
        },
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            side: statsFilterCubit.state.stats == stats
                ? const BorderSide(width: 1.5)
                : BorderSide.none,
            borderRadius: BorderRadius.circular(5),
          ),
          foregroundColor: Colors.black,
          backgroundColor: const Color(0xFFD9D9D9),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: XTypography.headingSmallRegularBold(
            text,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
