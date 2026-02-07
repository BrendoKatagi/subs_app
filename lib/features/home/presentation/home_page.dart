import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
// import 'package:substore_app/features/home/presentation/widgets/advertising_section.dart';
import 'package:substore_app/features/home/presentation/widgets/subscription_card.dart';
import 'package:substore_app/features/home/presentation/widgets/user_location_bar.dart';
import 'package:substore_app/features/menu/presentation/widgets/side_drawer.dart';
import 'package:substore_app/features/subscription/domain/entities/store.dart';
import 'package:substore_app/features/subscription/domain/usecases/get_user_subscriptions_usecase.dart';
import 'package:substore_app/shared/app_strings/app_strings.dart';
import 'package:substore_app/shared/extensions/build_context_extensions.dart';
// import 'package:substore_app/shared/presentation/widgets/text_field/text_field.dart';
import 'package:substore_app/shared/typography/typography.dart';
import 'package:substore_app/shared/widgets/app_bar/base_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController searchController;

  @override
  void initState() {
    searchController = TextEditingController();
    super.initState();
  }

  Future<List<Store>?> getUserSubscriptionPlans() async {
    try {
      return await GetIt.I.get<GetUserSubscriptionsUseCase>()();
    } catch (error) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: const UserLocationBar(),
        profileImageUrl: context.getUserImage(),
        onTap: (BuildContext context) => Scaffold.of(context).openDrawer(),
      ),
      drawer: const SideDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              XTypography.headingRegularBold(
                AppStrings.home.subscriptionManager,
              ),
              const SizedBox(height: 10),
              // XTypography.paragraphRegular(AppStrings.home.checkYourPlans),
              // const SizedBox(height: 20),
              // XTextField(
              //   controller: searchController,
              //   width: double.infinity,
              //   labelText: AppStrings.home.searchThroughSubscriptions,
              //   icon: const Icon(Icons.search),
              // ),
              // const SizedBox(height: 30),
              // const AdvertisingSection(),
              // const SizedBox(height: 30),
              XTypography.paragraphRegular(AppStrings.home.yourSubscriptions),
              const SizedBox(height: 10),
              FutureBuilder(
                future: getUserSubscriptionPlans(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 25),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  if (snapshot.hasData) {
                    final cards = <Widget>[];
                    final stores = snapshot.data!;

                    if (stores.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: XTypography.paragraphRegular(
                          AppStrings.home.emptySubscriptions,
                        ),
                      );
                    }

                    for (final store in stores) {
                      store.availablePlans?.forEach((subscriptionPlan) {
                        cards.add(
                          SubscriptionCard(
                            store: store,
                            subscriptionPlan: subscriptionPlan,
                          ),
                        );
                      });
                    }

                    return Wrap(runSpacing: 20, children: cards);
                  }

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: XTypography.paragraphRegular(
                      AppStrings.home.error,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
