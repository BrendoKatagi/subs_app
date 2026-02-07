import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:substore_app/config/app_routes.dart';
import 'package:substore_app/features/subscription/domain/entities/enum/subscription_stats.dart';
import 'package:substore_app/features/subscription/domain/entities/store.dart';
import 'package:substore_app/features/subscription/presentation/cubit/stats_filter_cubit.dart';
import 'package:substore_app/features/subscription/presentation/cubit/stats_filter_state.dart';
import 'package:substore_app/features/subscription/presentation/widgets/plan_card_widget.dart';
import 'package:substore_app/features/subscription/presentation/widgets/plan_check_in_widget.dart';
import 'package:substore_app/features/subscription/presentation/widgets/stats_filter_widget.dart';
import 'package:substore_app/shared/app_colors/colors.dart';
import 'package:substore_app/shared/app_strings/app_strings.dart';
import 'package:substore_app/shared/extensions/build_context_extensions.dart';
import 'package:substore_app/shared/typography/typography.dart';
import 'package:substore_app/shared/widgets/app_bar/default_app_bar.dart';

const profileImageSize = 72.0;

class StorePage extends StatelessWidget {
  const StorePage({super.key});

  @override
  Widget build(BuildContext context) {
    final stateContext = GoRouterState.of(context);
    if (stateContext.extra == null) AppRoutes.pop(context);

    final store = stateContext.extra! as Store;

    return Scaffold(
      appBar: DefaultAppBar(
        onPressed: () => AppRoutes.pop(context),
        profileImageUrl: context.getUserImage(),
      ),
      body: Container(
        color: XColors.textFieldBackground[10],
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(20),
                  ),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20).copyWith(top: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 180,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        image: DecorationImage(
                          image:
                              (store.coverImageUrl?.isNotEmpty ?? false ? Image.network(store.coverImageUrl!) : Image.asset('assets/images/store-cover.webp'))
                                  .image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    Row(
                      children: [
                        Container(
                          height: profileImageSize,
                          width: profileImageSize,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(profileImageSize),
                            ),
                            image: DecorationImage(
                              image: (store.profileImageUrl?.isNotEmpty ?? false
                                      ? Image.network(store.profileImageUrl!)
                                      : Image.asset('assets/images/user-profile.png'))
                                  .image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            XTypography.headingSmallRegularBold(store.name ?? '-'),
                            if (store.rate != null) ...[
                              const SizedBox(height: 4),
                              RatingBar(
                                ignoreGestures: true,
                                initialRating: store.rate!,
                                allowHalfRating: true,
                                itemSize: 28,
                                ratingWidget: RatingWidget(
                                  full: const Icon(
                                    Icons.star,
                                    color: Color(0xFF1C1B1F),
                                  ),
                                  half: const Icon(
                                    Icons.star_half,
                                    color: Color(0xFF1C1B1F),
                                  ),
                                  empty: const Icon(
                                    Icons.star_border,
                                    color: Color(0xFF1C1B1F),
                                  ),
                                ),
                                onRatingUpdate: (_) {},
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    XTypography.headingSmallRegularBold(
                      AppStrings.subscription.select,
                    ),
                    const SizedBox(height: 12),
                    BlocProvider(
                      create: (context) => StatsFilterCubit(
                        subscriptionPlans: store.subscriptionPlans
                            ?.where(
                              (element) => element.subscriptionStats == SubscriptionStats.subscripted,
                            )
                            .toList(),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          StatsFilterWidget(),
                          Divider(
                            color: Color(0xFFBCBCBC),
                            height: 36,
                          ),
                          _PlanCheckInSection(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30).copyWith(top: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 35),
                    if (store.bio?.isNotEmpty ?? false) ...[
                      XTypography.headingSmall(
                        AppStrings.subscription.about,
                        fontWeight: FontWeight.w700,
                      ),
                      const SizedBox(height: 8),
                      XTypography.headingSmall(store.bio ?? ''),
                      const SizedBox(height: 16),
                    ],
                    XTypography.headingSmall(
                      AppStrings.subscription.otherPlans,
                      fontWeight: FontWeight.w700,
                    ),
                    const SizedBox(height: 14),
                    Wrap(
                      runSpacing: 20,
                      children: store.subscriptionPlans != null
                          ? store.subscriptionPlans!
                              .map(
                                (e) => PlanCardWidget(
                                  storeName: store.name ?? '',
                                  pageUrl: store.pageUrl,
                                  subscriptionPlan: e,
                                ),
                              )
                              .toList()
                          : [],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PlanCheckInSection extends StatelessWidget {
  const _PlanCheckInSection();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<StatsFilterCubit>();

    return BlocBuilder<StatsFilterCubit, StatsFilterState>(
      bloc: cubit,
      builder: (context, state) {
        final plans = cubit.state.subscriptionPlans;
        final widgets = <Widget>[];

        for (final plan in plans) {
          for (final ticket in plan.subscriptionTickets!) {
            widgets.add(
              PlanCheckInWidget(
                subscriptionPlan: plan,
                subscriptionTicket: ticket,
              ),
            );
          }
        }

        if (widgets.isEmpty) {
          return XTypography.headingSmallRegular(
            AppStrings.subscription.emptyTicketsMessage,
            color: XColors.global[50]!,
          );
        }

        return Wrap(runSpacing: 18, children: widgets);
      },
    );
  }
}
