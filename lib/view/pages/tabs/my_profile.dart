import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:xendly_mobile/controller/core/user_auth.dart';
import 'package:xendly_mobile/model/user_model.dart';
import 'package:xendly_mobile/view/shared/colors.dart';
import 'package:xendly_mobile/view/shared/widgets/buttons/rounded.dart';
import 'package:xendly_mobile/view/shared/widgets/list_item.dart';
import 'package:xendly_mobile/view/shared/widgets/tabPage_title.dart';
import "../../shared/routes.dart" as routes;

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);
  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  // === PROFILE API === //
  late Future<UserProfile> userProfile;
  final userAuth = UserAuth();
  late int currentUser;

  @override
  void initState() {
    super.initState();
    userProfile = userAuth.getProfile();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const _divider = Divider(
      height: 12,
      color: XMColors.none,
    );

    return Scaffold(
      backgroundColor: XMColors.light,
      extendBody: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
          child: Column(
            children: [
              TabPageTitle(
                title: Text(
                  "My Profile",
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: XMColors.dark,
                      ),
                ),
                suffix: [
                  SvgPicture.asset(
                    "assets/icons/notification.svg",
                    width: 24,
                    height: 24,
                    color: XMColors.dark,
                  ),
                ],
              ),
              const SizedBox(height: 32),
              FutureBuilder<UserProfile>(
                future: userProfile,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        // Row(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     ClipRRect(
                        //       borderRadius: BorderRadius.circular(12),
                        //       child: Image.network(
                        //         "https://c4.wallpaperflare.com/wallpaper/928/876/859/thor-ragnarok-4k-amazing-desktop-wallpaper-preview.jpg",
                        //         width: 65,
                        //         height: 65,
                        //         fit: BoxFit.cover,
                        //       ),
                        //     ),
                        //     const SizedBox(width: 16),
                        //     Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         const SizedBox(height: 3),
                        //         Text(
                        //           "${snapshot.data!.firstName} ${snapshot.data!.lastName}",
                        //           style: Theme.of(context)
                        //               .textTheme
                        //               .headline6!
                        //               .copyWith(
                        //                 fontWeight: FontWeight.w700,
                        //               ),
                        //         ),
                        //         const SizedBox(height: 3),
                        //         Text(
                        //           "${snapshot.data!.email}",
                        //           style: Theme.of(context)
                        //               .textTheme
                        //               .bodyText1!
                        //               .copyWith(
                        //                 fontWeight: FontWeight.w600,
                        //                 color: XMColors.gray,
                        //               ),
                        //         ),
                        //       ],
                        //     ),
                        //   ],
                        // ),
                        const CircleAvatar(
                          backgroundImage: NetworkImage(
                            "https://c4.wallpaperflare.com/wallpaper/928/876/859/thor-ragnarok-4k-amazing-desktop-wallpaper-preview.jpg",
                          ),
                          foregroundImage: NetworkImage(
                            "https://c4.wallpaperflare.com/wallpaper/928/876/859/thor-ragnarok-4k-amazing-desktop-wallpaper-preview.jpg",
                          ),
                          radius: 55,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "${snapshot.data!.firstName} ${snapshot.data!.lastName}",
                          style:
                              Theme.of(context).textTheme.headline5!.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                        ),
                        Text(
                          "${snapshot.data!.email}",
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: XMColors.gray,
                                  ),
                        ),
                      ],
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
              const SizedBox(height: 24),
              RoundedButton(
                text: "Edit Personal Profile",
                action: () => Navigator.pushNamed(
                  context,
                  routes.editProfile,
                ),
              ),
              const SizedBox(height: 12),
              const ListItem(
                title: "Alerts & Notifications",
              ),
              _divider,
              ListItem(
                title: "Privacy & Security",
                action: () => {
                  Get.toNamed(routes.personalSecurity),
                },
              ),
              _divider,
              ListItem(
                title: "Files & Documents",
                action: () => {
                  Get.toNamed(routes.filesAndDocs),
                },
              ),
              _divider,
              ListItem(
                title: "Help & Support",
                action: () => Navigator.pushNamed(
                  context,
                  routes.helpAndSupport,
                ),
              ),
              const SizedBox(height: 14),
              const Divider(
                color: XMColors.gray_70,
                thickness: 1.5,
              ),
              const SizedBox(height: 14),
              Text(
                "Sign Out",
                style: Theme.of(context).textTheme.subtitle2!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: XMColors.red,
                    ),
              ),
              const SizedBox(height: 14),
              const Divider(
                color: XMColors.gray_70,
                thickness: 1.5,
              ),
              const SizedBox(height: 26),
              Text(
                "Xendly v1.0.0",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: XMColors.lightGray,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
