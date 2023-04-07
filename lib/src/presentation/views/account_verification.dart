import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/presentation/widgets/list_items/list_item_five.dart';
import 'package:xendly_mobile/src/presentation/widgets/title_bar.dart';
import '../../config/routes.dart' as routes;

class AccountVerification extends StatefulWidget {
  const AccountVerification({Key? key}) : super(key: key);
  @override
  State<AccountVerification> createState() => _AccountVerificationState();
}

class _AccountVerificationState extends State<AccountVerification> {
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
                  title: "Account Verification",
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
                  title: "Virtual NIN (vNIN)",
                  subtitle: "Not Verified",
                  prefix: Icons.note_outlined,
                  suffix: Icons.check_circle_outline,
                  action: () => Get.toNamed(routes.editProfile),
                ),
                const SizedBox(height: 10),
                ListItemFive(
                  title: "International Passport",
                  subtitle: "Not Verified",
                  prefix: Icons.closed_caption_off,
                  suffix: Icons.cancel_outlined,
                  action: () => Get.toNamed(routes.editProfile),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // void _showAddressSheet() {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Wrap(
  //         crossAxisAlignment: WrapCrossAlignment.center,
  //         alignment: WrapAlignment.center,
  //         children: [
  //           Container(
  //             padding: const EdgeInsets.symmetric(
  //               horizontal: 20,
  //               vertical: 38,
  //             ),
  //             child: Form(
  //               key: formKey,
  //               child: Column(
  //                 children: [
  //                   Text(
  //                     "Update Address Information",
  //                     textAlign: TextAlign.center,
  //                     style: Theme.of(context).textTheme.subtitle1!.copyWith(
  //                           fontWeight: FontWeight.w600,
  //                         ),
  //                   ),
  //                   const SizedBox(height: 12),
  //                   Text(
  //                     "Get access to a virtual account that you can use to pay for your bills and other services.",
  //                     textAlign: TextAlign.center,
  //                     style: Theme.of(context).textTheme.bodyText1!.copyWith(
  //                           color: XMColors.gray,
  //                         ),
  //                   ),
  //                   const SizedBox(height: 26),
  //                   TextInput(
  //                     readOnly: false,
  //                     label: "Streer Address",
  //                     hintText: "No, 85, Ajanaku Street, Tanke",
  //                     inputType: TextInputType.streetAddress,
  //                     borderRadius: BorderRadius.circular(10),
  //                     controller: streetController,
  //                     onSaved: (value) => _streetAddress = value,
  //                     validator: (value) => streetValidate(value!),
  //                   ),
  //                   const SizedBox(height: 26),
  //                   TextInput(
  //                     readOnly: false,
  //                     label: "City",
  //                     hintText: "Ilorin",
  //                     inputType: TextInputType.text,
  //                     borderRadius: BorderRadius.circular(10),
  //                     controller: cityController,
  //                     onSaved: (value) => _city = value,
  //                     validator: (value) => cityValidate(value!),
  //                   ),
  //                   const SizedBox(height: 20),
  //                   RoundedButton(
  //                     text: "Update Address",
  //                     action: () => updateAddress(),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  // void _showPhoneSheet() {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Wrap(
  //         crossAxisAlignment: WrapCrossAlignment.center,
  //         alignment: WrapAlignment.center,
  //         children: [
  //           Container(
  //             padding: const EdgeInsets.symmetric(
  //               horizontal: 20,
  //               vertical: 38,
  //             ),
  //             child: Form(
  //               key: formKey,
  //               child: Column(
  //                 children: [
  //                   Text(
  //                     "Update Phone Number",
  //                     textAlign: TextAlign.center,
  //                     style: Theme.of(context).textTheme.subtitle1!.copyWith(
  //                           fontWeight: FontWeight.w600,
  //                         ),
  //                   ),
  //                   const SizedBox(height: 12),
  //                   Text(
  //                     "Get access to a virtual account that you can use to pay for your bills and other services.",
  //                     textAlign: TextAlign.center,
  //                     style: Theme.of(context).textTheme.bodyText1!.copyWith(
  //                           color: XMColors.gray,
  //                         ),
  //                   ),
  //                   const SizedBox(height: 26),
  //                   TextInput(
  //                     readOnly: false,
  //                     label: "Phone Number",
  //                     hintText: "902584237",
  //                     inputType: TextInputType.text,
  //                     borderRadius: BorderRadius.circular(10),
  //                     controller: cityController,
  //                     onSaved: (value) => _city = value,
  //                     validator: (value) => cityValidate(value!),
  //                   ),
  //                   const SizedBox(height: 20),
  //                   RoundedButton(
  //                     text: "Update Phone",
  //                     action: () => updateAddress(),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}
