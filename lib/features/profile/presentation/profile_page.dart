import 'package:flutter/material.dart';
import 'package:substore_app/features/profile/domain/model/profile.dart';
import 'package:substore_app/shared/app_strings/app_strings.dart';
import 'package:substore_app/shared/typography/typography.dart';
import 'package:substore_app/shared/widgets/list_item/list_menu_item.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _profile = Profile(
      'Nome Sobrenome',
      'email@gmail.com',
      '(11) 9999-99999',
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
      'assets/images/profile.png');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 72,
                    width: 72,
                    child: CircleAvatar(
                      radius: 24,
                      backgroundImage: AssetImage(_profile.imageUrl),
                    ),
                  ),
                  const SizedBox(width: 20),
                  XTypography.headingRegularBold(_profile.name),
                ],
              ),
              const SizedBox(height: 20),
              XTypography.headingSmallRegularBold(AppStrings.profile.aboutYou,
                  textAlign: TextAlign.left),
              const SizedBox(height: 8),
              XTypography.headingSmall(_profile.description),
              const SizedBox(height: 24),
              XTypography.headingSmallRegularBold(AppStrings.profile.settings),
              const SizedBox(height: 4),
              ListMenuItem(
                text: AppStrings.profile.personalData,
                icon: Icons.person,
                onTap: () {},
              ),
              const Divider(color: Colors.black12, height: 1),
              ListMenuItem(
                text: AppStrings.profile.changePassword,
                icon: Icons.key,
                onTap: () {},
              ),
              const Divider(color: Colors.black12, height: 1),
              ListMenuItem(
                text: AppStrings.profile.logout,
                icon: Icons.logout,
                onTap: () {},
              ),
              const Divider(color: Colors.black12, height: 1),
            ],
          ),
        ),
      ),
    );
  }
}
