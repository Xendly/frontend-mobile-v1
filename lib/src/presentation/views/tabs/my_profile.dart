import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/iconsax_icons.dart';
import 'package:xendly_mobile/src/domain/usecases/auth/logout_usecase.dart';
import 'package:xendly_mobile/src/presentation/view_model/auth/logout_view_model.dart';
import 'package:xendly_mobile/src/presentation/widgets/list_items/list_item_five.dart';
import 'package:xendly_mobile/src/presentation/widgets/new_title_bar.dart';

import '../../../config/routes.dart' as routes;
import '../../../domain/usecases/user/get_profile_usecase.dart';
import '../../view_model/user/get_profile_controller.dart';
import '../../widgets/notifications/snackbar.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);
  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final GetProfileController controller = Get.put(
    GetProfileController(Get.find<GetProfileUsecase>()),
  );

  final LogoutViewModel logoutController = Get.put(
    LogoutViewModel(
      Get.find<LogOutUsecase>(),
    ),
  );

  void _logout() async {
    try {
      logoutController.userLogout();
    } catch (err) {
      Get.snackbar("Error!", err.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    // call the function constantly
    controller.getProfile();

    return Scaffold(
      backgroundColor: XMColors.light,
      extendBody: true,
      appBar: const NewTitleBar(
        title: "Settings",
        suffix: Icon(
          Iconsax.setting_2,
          size: 28,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 22,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // account management
            Text(
              "ACCOUNT",
              style: textTheme.bodyMedium?.copyWith(
                color: XMColors.shade3,
                letterSpacing: 1.4,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            ListItemFive(
              title: "Manage Profile",
              subtitle: "Make changes to your profile",
              prefix: Icons.person_2_outlined,
              suffix: Icons.arrow_forward_ios_outlined,
              action: () => Get.toNamed(routes.editProfile),
            ),
            const SizedBox(height: 10),
            ListItemFive(
              title: "Account Verification",
              subtitle: "Remove all limits on your account",
              prefix: Icons.verified_outlined,
              suffix: controller.data['kyc_status'] == 'verified'
                  ? Icons.check_circle_outline
                  : controller.data['kyc_status'] == 'pending'
                      ? Icons.info_outline
                      : controller.data['kyc_status'] == "rejected"
                          ? Icons.cancel_outlined
                          : Icons.arrow_forward_ios_outlined,
              action: () {
                controller.data['kyc_status'] == 'verified'
                    ? xnSnack(
                        "Sorry",
                        "You're already verified",
                        XMColors.success1,
                        Icons.check_circle_outline,
                      )
                    : controller.data['kyc_status'] == 'pending'
                        ? xnSnack(
                            "Sorry",
                            "Your verification is pending",
                            XMColors.secondary1,
                            Icons.info_outline,
                          )
                        : Get.toNamed(routes.updateAddress);
              },
            ),
            const SizedBox(height: 10),
            ListItemFive(
              title: "Account Limitations",
              subtitle: "Control how you spending",
              prefix: Icons.money_off,
              suffix: Icons.arrow_forward_ios_outlined,
              action: () => Get.toNamed(routes.accountLimits),
            ),
            const SizedBox(height: 36),

            // finances management
            Text(
              "FINANCES",
              style: textTheme.bodyMedium?.copyWith(
                color: XMColors.shade3,
                letterSpacing: 1.4,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            ListItemFive(
              title: "Beneficiaries",
              subtitle: "Manage your saved beneficiaries",
              prefix: Icons.credit_card_outlined,
              suffix: Icons.arrow_forward_ios_outlined,
              action: () => Get.toNamed(routes.manageBeneficiaries),
            ),
            const SizedBox(height: 10),
            ListItemFive(
              title: "Payout Accounts",
              subtitle: "Manage your withdrawal accounts",
              prefix: Icons.money,
              suffix: Icons.arrow_forward_ios_outlined,
              action: () => Get.toNamed(routes.payoutAccounts),
            ),
            const SizedBox(height: 36),

            // security management
            Text(
              "SECURITY",
              style: textTheme.bodyMedium?.copyWith(
                color: XMColors.shade3,
                letterSpacing: 1.4,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            ListItemFive(
              title: "Change Password",
              subtitle: "Make changes to your profile",
              prefix: Icons.person_2_outlined,
              suffix: Icons.arrow_forward_ios_outlined,
              action: () => Get.toNamed(routes.changePassword),
            ),
            const SizedBox(height: 10),
            ListItemFive(
              title: "Change 4 Digit PIN",
              subtitle: "Verify your account with an ID",
              prefix: Icons.pin_outlined,
              suffix: Icons.arrow_forward_ios_outlined,
              action: () => Get.toNamed(routes.changePin),
            ),

            // others
            const SizedBox(height: 36), // account management
            Text(
              "OTHERS",
              style: textTheme.bodyMedium?.copyWith(
                color: XMColors.shade3,
                letterSpacing: 1.4,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            ListItemFive(
              title: "Help Center",
              subtitle: "Got questions? Send us a message",
              prefix: Icons.question_answer_outlined,
              suffix: Icons.arrow_forward_ios_outlined,
              action: () => Get.toNamed(routes.helpCenter),
            ),
            const SizedBox(height: 10),
            const ListItemFive(
              title: "Privacy Policy",
              subtitle: "Read our Terms and Conditions",
              prefix: Icons.privacy_tip_outlined,
              suffix: Icons.arrow_forward_ios_outlined,
            ),
            const SizedBox(height: 10),
            ListItemFive(
              title: "Logout",
              subtitle: "Quick controls over notifications",
              prefix: Icons.logout_rounded,
              suffix: Icons.arrow_forward_ios_outlined,
              action: () => _logout(),
            ),
          ],
        ),
      ),
    );
  }
}
