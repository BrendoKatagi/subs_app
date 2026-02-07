import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:substore_app/config/app_routes.dart';
import 'package:substore_app/features/subscription/domain/entities/enum/subscription_ticket_stats.dart';
import 'package:substore_app/features/subscription/domain/entities/subscription_plan.dart';
import 'package:substore_app/features/subscription/domain/entities/subscription_ticket.dart';
import 'package:substore_app/features/subscription/presentation/cubit/check_in_cubit.dart';
import 'package:substore_app/shared/app_colors/colors.dart';
import 'package:substore_app/shared/app_strings/app_strings.dart';
import 'package:substore_app/shared/extensions/date_time_extensions.dart';
import 'package:substore_app/shared/presentation/widgets/buttons/app_buttons.dart';
import 'package:substore_app/shared/presentation/widgets/buttons/copy_button.dart';
import 'package:substore_app/shared/presentation/widgets/snack_bar/app_snack_bar.dart';
import 'package:substore_app/shared/typography/typography.dart';
import 'package:substore_app/shared/utils/brightness_utils.dart';

class PlanCheckInWidget extends StatelessWidget {
  final SubscriptionPlan subscriptionPlan;
  final SubscriptionTicket subscriptionTicket;

  const PlanCheckInWidget({
    required this.subscriptionPlan,
    required this.subscriptionTicket,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final CheckInCubit checkInCubit = GetIt.I.get();
    String getButtonLabel(SubscriptionTicketStats stats) {
      switch (stats) {
        case SubscriptionTicketStats.available:
          return AppStrings.subscription.checkIn;
        case SubscriptionTicketStats.done:
          return AppStrings.subscription.done;
        case SubscriptionTicketStats.expired:
          return AppStrings.subscription.expired;
      }
    }

    return BlocProvider<CheckInCubit>(
      create: (context) => checkInCubit,
      child: BlocConsumer<CheckInCubit, CheckInState>(
        listener: (_, __) {},
        listenWhen: (previous, current) {
          if (current is CheckInSuccess) {
            Navigator.of(context).pop();
            AppRoutes.replaceToHomePage();
            XSnackBar.success(message: AppStrings.subscription.checkInSuccess).show(context);
          }
          if (current is CheckInError) {
            Navigator.of(context).pop();
            XSnackBar.error(error: AppStrings.subscription.checkInError).show(context);
          }
          return previous != current;
        },
        builder: (context, state) {
          void onModalShow(String checkInData) {
            resetScreenBrightness();

            checkInCubit.listenToCheckIn(checkInData);
          }

          void onModalComplete() {
            resetScreenBrightness();

            checkInCubit.cancelCheckInSubscription();
          }

          void showCheckInQrCodeModal(String checkInData) {
            onModalShow(checkInData);

            showModalBottomSheet<void>(
              context: context,
              isScrollControlled: true,
              builder: (context) {
                return SizedBox(
                  height: 450,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            XTypography.headingRegularBold(
                              AppStrings.subscription.checkIn,
                            ),
                            const SizedBox(height: 12),
                            QrImageView(
                              data: checkInData,
                              size: 250,
                            ),
                            const SizedBox(height: 8),
                            SelectionArea(child: XTypography.headingRegular(checkInData, textAlign: TextAlign.center)),
                            const SizedBox(height: 8),
                            Visibility(visible: !kIsWeb, child: CopyButton(textToCopy: checkInData)),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ).whenComplete(onModalComplete);
          }

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    XTypography.headingSmallRegular(
                      subscriptionPlan.title,
                      color: XColors.global[20]!,
                    ),
                    XTypography.headingSmallRegularBold(
                      subscriptionTicket.title,
                      color: XColors.global[20]!,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    _PlanDateInfo(subscriptionTicket),
                  ],
                ),
              ),
              XPrimaryButton(
                getButtonLabel(subscriptionTicket.subscriptionTicketStats),
                stylePadding: EdgeInsets.zero,
                onPressed: subscriptionTicket.subscriptionTicketStats == SubscriptionTicketStats.available
                    ? () {
                        showCheckInQrCodeModal(subscriptionTicket.checkInData!);
                      }
                    : null,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _PlanDateInfo extends StatelessWidget {
  final SubscriptionTicket subscriptionTicket;

  const _PlanDateInfo(this.subscriptionTicket);

  @override
  Widget build(BuildContext context) {
    if (subscriptionTicket.subscriptionTicketStats == SubscriptionTicketStats.available) {
      return XTypography.headingSmallRegular(
        AppStrings.subscription.expiresIn(subscriptionTicket.expireDate),
        color: XColors.global[20]!,
      );
    }
    if (subscriptionTicket.subscriptionTicketStats == SubscriptionTicketStats.done) {
      return XTypography.headingSmallRegular(
        subscriptionTicket.checkInDateTime!.toFormattedString('às'),
        color: XColors.global[20]!,
      );
    }

    return XTypography.headingSmallRegular(
      AppStrings.subscription.expiredIn(subscriptionTicket.expireDate),
      color: XColors.global[20]!,
    );
  }
}
