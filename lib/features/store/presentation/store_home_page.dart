// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get_it/get_it.dart';
import 'package:substore_app/config/app_routes.dart';
import 'package:substore_app/features/auth/cubit/auth_user_cubit.dart';
import 'package:substore_app/features/auth/cubit/auth_user_state.dart';
import 'package:substore_app/features/menu/presentation/widgets/side_drawer.dart';
import 'package:substore_app/features/store/domain/usecases/send_check_in_data_usecase.dart';
import 'package:substore_app/features/store/presentation/check_in_modal.dart';
import 'package:substore_app/shared/app_colors/colors.dart';
import 'package:substore_app/shared/app_strings/app_strings.dart';
import 'package:substore_app/shared/extensions/build_context_extensions.dart';
import 'package:substore_app/shared/presentation/widgets/buttons/app_buttons.dart';
import 'package:substore_app/shared/presentation/widgets/overlay/app_overlay.dart';
import 'package:substore_app/shared/presentation/widgets/overlay/loading_overlay.dart';
import 'package:substore_app/shared/presentation/widgets/snack_bar/app_snack_bar.dart';
import 'package:substore_app/shared/typography/typography.dart';
import 'package:substore_app/shared/utils/url_utils.dart';
import 'package:substore_app/shared/widgets/app_bar/base_app_bar.dart';

const profileImageSize = 72.0;

class StoreHomePage extends StatelessWidget {
  const StoreHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> sendCheckInData(String checkInData) async {
      try {
        AppOverlay.show(context, const LoadingOverlay());

        await GetIt.I.get<SendCheckIndDataUseCase>()(checkInData);

        XSnackBar.success(message: AppStrings.store.checkInSuccess).show(context);
        await GetIt.I.get<AuthUserCubit>().getUserLogged();
      } catch (err) {
        XSnackBar.error(error: AppStrings.store.checkInError).show(context);
      } finally {
        await AppOverlay.dismiss();
      }
    }

    return Builder(builder: (pageContext) {
      return BlocProvider.value(
        value: BlocProvider.of<AuthUserCubit>(pageContext)..getUserLogged(),
        child: BlocConsumer<AuthUserCubit, AuthUserState>(
          listener: (_, __) {},
          listenWhen: (previous, current) {
            if (current is AuthUserStateLoginLoading) {
              AppOverlay.show(pageContext, const LoadingOverlay());
            }

            if (previous is AuthUserStateLoginLoading && current is! AuthUserStateLoginLoading) {
              AppOverlay.dismiss();
            }

            return previous != current;
          },
          builder: (context, state) {
            final store = pageContext.getUserLogged()?.store;

            return Scaffold(
              backgroundColor: XColors.textFieldBackground[10],
              appBar: BaseAppBar(
                profileImageUrl: context.getUserImage(),
                showProfileImage: false,
                onTap: (BuildContext context) => Scaffold.of(context).openDrawer(),
              ),
              drawer: const SideDrawer(),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(32).copyWith(bottom: 16),
                  child: store != null
                      ? CustomScrollView(
                          slivers: [
                            SliverFillRemaining(
                              hasScrollBody: false,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 180,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                                      image: DecorationImage(
                                        image: (store.coverImageUrl?.isNotEmpty ?? false
                                                ? Image.network(store.coverImageUrl!)
                                                : Image.asset('assets/images/store-cover.webp'))
                                            .image,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  // const SizedBox(height: 25),
                                  const Divider(
                                    color: Color(0xFFBCBCBC),
                                    height: 72,
                                  ),
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
                                          if (store.name != null) XTypography.headingSmallRegularBold(store.name!),
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
                                  if (store.bio != null) ...[
                                    const SizedBox(height: 25),
                                    XTypography.headingSmall(
                                      store.bio!,
                                      textAlign: TextAlign.justify,
                                    ),
                                  ],
                                  const SizedBox(height: 32),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      XPrimaryButton(
                                        AppStrings.store.checkIn,
                                        onPressed: () {
                                          CheckInModal.show(context, sendCheckInData);
                                        },
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                                      ),
                                      const SizedBox(width: 6),
                                      Flexible(
                                        child: XPrimaryButton(
                                          AppStrings.store.support,
                                          foregroundColor: const Color(0xFF1C1C1C),
                                          textColor: const Color(0xFF1C1C1C),
                                          backgroundColor: Colors.transparent,
                                          onPressed: () {
                                            openUrl('${AppStrings.store.supportUrl}${store.name}');
                                          },
                                          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 40),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          XPrimaryButton(
                                            AppStrings.store.myCheckIns,
                                            foregroundColor: const Color(0xFF1C1C1C),
                                            textColor: const Color(0xFF1C1C1C),
                                            backgroundColor: Colors.transparent,
                                            onPressed: () {
                                              AppRoutes.navigateToCheckInsPage(context);
                                            },
                                            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : Container(),
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
