import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:substore_app/config/app_routes.dart';
import 'package:substore_app/features/store/domain/usecases/get_check_ins_usecase.dart';
import 'package:substore_app/features/store/presentation/widgets/check_in_widget.dart';
import 'package:substore_app/shared/app_colors/colors.dart';
import 'package:substore_app/shared/app_strings/app_strings.dart';
import 'package:substore_app/shared/extensions/build_context_extensions.dart';
import 'package:substore_app/shared/typography/typography.dart';
import 'package:substore_app/shared/widgets/app_bar/default_app_bar.dart';

class CheckInsPage extends StatelessWidget {
  const CheckInsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        onPressed: () => AppRoutes.pop(context),
        profileImageUrl: context.getUserImage(),
      ),
      backgroundColor: XColors.textFieldBackground[10],
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            XTypography.headingRegularBold(AppStrings.store.myCheckIns),
            const SizedBox(height: 24),
            FutureBuilder(
              future: GetIt.I.get<GetCheckInsUseCase>()(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return XTypography.headingSmallRegular(
                    AppStrings.store.unexpectedError,
                  );
                }

                if (snapshot.hasData) {
                  final checkInList = snapshot.data!;
                  final checkInListLength = checkInList.length;

                  if (checkInListLength == 0) {
                    return XTypography.headingSmallRegular(
                      AppStrings.store.noCheckIns,
                    );
                  }

                  return Expanded(
                    child: ListView.separated(
                      itemCount: checkInListLength,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 16),
                      itemBuilder: (context, index) => CheckInWidget(
                        checkIn: checkInList[index],
                      ),
                    ),
                  );
                }

                return Center(
                    child: CircularProgressIndicator(
                  color: XColors.global[20],
                ));
              },
            )
          ],
        ),
      ),
    );
  }
}
