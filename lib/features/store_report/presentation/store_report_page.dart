import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:substore_app/config/app_routes.dart';
import 'package:substore_app/features/store_report/domain/entities/plans_active.dart';
import 'package:substore_app/features/store_report/domain/entities/store_report.dart';
import 'package:substore_app/features/store_report/presentation/controllers/store_report_cubit.dart';
import 'package:substore_app/features/store_report/presentation/widgets/active_plan_card.dart';
import 'package:substore_app/features/store_report/presentation/widgets/quick_report_item.dart';
import 'package:substore_app/shared/app_colors/colors.dart';
import 'package:substore_app/shared/app_strings/app_strings.dart';
import 'package:substore_app/shared/presentation/widgets/errors/error_page.dart';
import 'package:substore_app/shared/presentation/widgets/shimmer/app_shimmer.dart';
import 'package:substore_app/shared/typography/typography.dart';
import 'package:substore_app/shared/widgets/app_bar/default_app_bar.dart';

class StoreReportPage extends StatelessWidget {
  const StoreReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StoreReportCubit>(
      create: (context) => GetIt.I.get()..getStoreReportData(),
      child: Scaffold(
        appBar: DefaultAppBar(
          profileImageUrl: null,
          onPressed: () => AppRoutes.pop(context),
        ),
        body: BlocBuilder<StoreReportCubit, StoreReportState>(
          builder: (context, state) {
            if (state is StoreReportError) {
              return ErrorPage(title: AppStrings.storeReport.reportLoadErrorTitle, description: AppStrings.storeReport.reportLoadErrorDescription);
            }

            if (state is StoreReportInvalidParamsError) {
              return ErrorPage(title: AppStrings.storeReport.invalidDataErrorTitle, description: AppStrings.storeReport.invalidDataErrorDescription);
            }

            if (state is StoreReportData || state is StoreReportLoading) {
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: XColors.globalLight[20],
                  borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
                ),
                child: Builder(builder: (context) {
                  if (state is StoreReportLoading) {
                    return Column(children: <Widget>[QuickReportView.loading(), const SizedBox(height: 24), ActivePlansList.loading()]);
                  }

                  final StoreReport storeReport = (state as StoreReportData).storeReport;
                  return SingleChildScrollView(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: double.infinity,
                      child: Column(
                        children: <Widget>[
                          QuickReportView(storeReport: storeReport),
                          const SizedBox(height: 24),
                          ActivePlansList(
                            activePlans: storeReport.activePlans,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class QuickReportView extends StatelessWidget {
  final StoreReport? storeReport;
  final bool isLoading;
  const QuickReportView({super.key, required this.storeReport, this.isLoading = false});

  factory QuickReportView.loading() => const QuickReportView(storeReport: null, isLoading: true);

  @override
  Widget build(BuildContext context) {
    if (isLoading || storeReport == null) {
      return Wrap(
        children: List<Widget>.generate(6, (_) => QuickReportItem.loading()),
      );
    }

    return Wrap(
      children: storeReport!.storeQuickValues.entries
          .map(
            (MapEntry<String, String> report) => QuickReportItem(
              title: report.key,
              value: report.value,
              isLoading: isLoading,
            ),
          )
          .toList() as List<Widget>,
    );
  }
}

class ActivePlansList extends StatelessWidget {
  final List<ActivePlan>? activePlans;
  final bool isLoading;
  const ActivePlansList({super.key, required this.activePlans, this.isLoading = false});

  factory ActivePlansList.loading() => const ActivePlansList(activePlans: null, isLoading: true);

  @override
  Widget build(BuildContext context) {
    final storeActivePlans = activePlans ?? const <ActivePlan>[];
    const int defaultListLength = 3;
    return Expanded(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            XTypography.headingRegular('Planos ativos:'),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: isLoading ? defaultListLength : storeActivePlans.length,
                itemBuilder: (BuildContext context, int index) {
                  if (isLoading) return const AppShimmer(width: double.infinity, height: 120);

                  return ActivePlanCard(activePlan: storeActivePlans[index]);
                },
                separatorBuilder: (_, __) => const SizedBox(height: 4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
