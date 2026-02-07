import 'package:flutter/material.dart';

class BaseAppBar extends AppBar {
  BaseAppBar({
    required String? profileImageUrl,
    bool showProfileImage = true,
    void Function(BuildContext)? onTap,
    super.title,
    super.centerTitle,
    super.key,
  }) : super(
          automaticallyImplyLeading: false,
          toolbarHeight: 100,
          scrolledUnderElevation: 0,
          leading: onTap != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 20, top: 12, bottom: 12),
                  child: Builder(builder: (context) {
                    return IconButton(
                      icon: const Icon(Icons.menu),
                      hoverColor: Colors.transparent,
                      onPressed: () => onTap(context),
                    );
                  }),
                )
              : null,
          actions: <Widget>[
            if (showProfileImage)
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.white,
                  backgroundImage:
                      (profileImageUrl?.isNotEmpty ?? false ? Image.network(profileImageUrl!) : Image.asset('assets/images/user-profile.png')).image,
                ),
              ),
          ],
        );
}
