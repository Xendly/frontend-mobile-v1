import 'package:flutter/material.dart';
import 'package:freshchat_sdk/freshchat_sdk.dart';
import 'package:freshchat_sdk/freshchat_user.dart';
import 'package:get/get.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/presentation/widgets/notifications/snackbar.dart';

import '../../domain/usecases/user/get_profile_usecase.dart';
import '../view_model/user/get_profile_controller.dart';
import '../widgets/list_items/list_item_five.dart';
import '../widgets/title_bar.dart';

class HelpAndSupport extends StatefulWidget {
  const HelpAndSupport({Key? key}) : super(key: key);

  @override
  State<HelpAndSupport> createState() => _HelpAndSupportState();
}

class _HelpAndSupportState extends State<HelpAndSupport> {
  final controller = Get.put(
    GetProfileController(Get.find<GetProfileUsecase>()),
  );

  void freshchatConfig() async {
    // initialize freshchat
    try {
      Freshchat.init(
        'fc30a38c-24f5-40c0-9bd5-8a9b59873759',
        '4e372778-88aa-4483-b6c3-2fceccd267d8',
        'msdk.freshchat.com',
        teamMemberInfoVisible: true,
        cameraCaptureEnabled: true,
        gallerySelectionEnabled: true,
        responseExpectationEnabled: true,
      );

      final FreshchatUser user = FreshchatUser(
        controller.data['id'],
        controller.data['id'],
      );

      user.setFirstName(controller.data['first_name']);
      user.setLastName(controller.data['last_name']);
      user.setEmail(controller.data['email']);
      user.setPhone("+234", controller.data['phone']);
      Freshchat.setUser(user);
    } catch (e) {
      printError(info: '$e');
    }
  }

  @override
  initState() {
    super.initState();
    freshchatConfig();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

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
                const TitleBar(
                  title: "Get Help",
                ),
                const SizedBox(height: 28),
                Text(
                  "You can verify your account using one of the documents requested below. This process takes up to 2 working days",
                  style: textTheme.bodyLarge?.copyWith(
                    height: 1.5,
                    color: XMColors.shade3,
                  ),
                ),
                const SizedBox(height: 18),
                ListItemFive(
                  title: "Chat with Us",
                  subtitle: "We respond in minutes",
                  prefix: Icons.chat_outlined,
                  suffix: Icons.arrow_forward_ios_outlined,
                  action: () => Freshchat.showConversations(),
                ),
                const SizedBox(height: 10),
                ListItemFive(
                  title: "FaQs",
                  subtitle: "Coming Soon",
                  prefix: Icons.question_mark_outlined,
                  suffix: Icons.arrow_forward_ios_outlined,
                  action: () => xnSnack(
                    "Coming soon",
                    "We're working on it",
                    XMColors.error1,
                    Icons.info_outline,
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
