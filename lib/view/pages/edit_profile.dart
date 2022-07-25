import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xendly_mobile/view/shared/colors.dart';
import 'package:xendly_mobile/view/shared/widgets/buttons/rounded.dart';
import 'package:xendly_mobile/view/shared/widgets/page_title.dart';
import 'package:xendly_mobile/view/shared/widgets/text_input.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: XMColors.light,
      extendBody: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 24,
              horizontal: 18,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PageTitleIcons(
                  prefixIcon: "assets/icons/bold/icl-arrow-left-2.svg",
                  title: "Edit Profile",
                  prefixIconColor: XMColors.dark,
                  prefixIconAction: () => Get.back(),
                ),
                const SizedBox(height: 38),
                const Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      "https://c4.wallpaperflare.com/wallpaper/928/876/859/thor-ragnarok-4k-amazing-desktop-wallpaper-preview.jpg",
                    ),
                    foregroundImage: NetworkImage(
                      "https://c4.wallpaperflare.com/wallpaper/928/876/859/thor-ragnarok-4k-amazing-desktop-wallpaper-preview.jpg",
                    ),
                    radius: 55,
                  ),
                ),
                const SizedBox(height: 44),
                Text(
                  "Account Information",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: XMColors.gray,
                      ),
                ),
                const SizedBox(height: 20),
                Container(
                  color: XMColors.gray_90,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 24,
                  ),
                  child: Column(
                    children: [
                      TextInput(
                        readOnly: true,
                        label: "Full Name",
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(
                            left: 17,
                            right: 0,
                          ),
                          child: Text(
                            "Ibrahim Ibrahim",
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: XMColors.dark,
                                    ),
                          ),
                        ),
                        inputType: TextInputType.name,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      const SizedBox(height: 20),
                      TextInput(
                        readOnly: true,
                        label: "Email Address",
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(
                            left: 17,
                            right: 0,
                          ),
                          child: Text(
                            "kaden.ellis@fillnoo.com",
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: XMColors.dark,
                                    ),
                          ),
                        ),
                        inputType: TextInputType.name,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      const SizedBox(height: 20),
                      TextInput(
                        readOnly: true,
                        label: "Phone Number",
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(
                            left: 17,
                            right: 0,
                          ),
                          child: Text(
                            "+23478456234",
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: XMColors.dark,
                                    ),
                          ),
                        ),
                        inputType: TextInputType.name,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      const SizedBox(height: 20),
                      TextInput(
                        readOnly: true,
                        label: "Address",
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(
                            left: 17,
                            right: 0,
                          ),
                          child: Text(
                            "Not Provided",
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: XMColors.gray,
                                    ),
                          ),
                        ),
                        inputType: TextInputType.name,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  "Account Limitations",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: XMColors.gray,
                      ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: XMColors.gray_90,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Adding Cash",
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: XMColors.primary_20,
                                    ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Unlimited",
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: XMColors.dark,
                                    ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 26),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Recieving Cash",
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: XMColors.primary_20,
                                    ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Unlimited",
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: XMColors.dark,
                                    ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 26),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Withdrawals & Payments",
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: XMColors.primary_20,
                                    ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "For today, 7 days and 30 days",
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: XMColors.dark,
                                    ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                RoundedButton(
                  text: "Save Changes",
                  action: () => log(
                    "Save Changes",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
