import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:xendly_mobile/src/core/utilities/helpers/validator_helper.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/config/routes.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/iconsax_icons.dart';
import 'package:xendly_mobile/src/data/models/account_summary.dart';
import 'package:xendly_mobile/src/data/services/accounts_service.dart';
import 'package:xendly_mobile/src/presentation/widgets/buttons/rounded.dart';
import 'package:xendly_mobile/src/presentation/widgets/buttons/solid_button.dart';
import 'package:xendly_mobile/src/presentation/widgets/inputs/xn_text_field.dart';
import 'package:xendly_mobile/src/presentation/widgets/list_item_3.dart';
import 'package:xendly_mobile/src/presentation/widgets/list_items/list_item_four.dart';
import 'package:xendly_mobile/src/presentation/widgets/title_bar.dart';

import 'package:xendly_mobile/src/presentation/widgets/list_items/list_item_five.dart';

import '../../../config/routes.dart' as routes;

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);
  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>(debugLabel: "_signInKey");
  TextEditingController? emailController = TextEditingController();
  TextEditingController? passwordController = TextEditingController();

  void _submit() async {
    final isValid = formKey.currentState!.validate();
    if (isValid) {
      formKey.currentState!.save();
      try {
        printInfo(info: "Everything is ok...just send!");
        // loginController.userLogin(data);
      } catch (error) {
        Get.snackbar("Error", "Unknown Error Occured, Try Again!");
      }
    }
  }

  bool _obscurePassword = true;
  void togglePassword() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  Map<String, dynamic> data = {
    "email": "",
    "password": "",
  };

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: XMColors.light,
      extendBody: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 24,
            horizontal: 18,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TitleBar(
                title: "Change Password",
              ),
              const SizedBox(height: 46),
              XnTextField(
                label: "Old Password",
                keyboardType: TextInputType.visiblePassword,
                // controller: passwordController,
                onSaved: (value) => data["password"] = value!,
                validator: (value) => validatePassword(value!),
                iconTap: togglePassword,
                obscureContent: _obscurePassword ? true : false,
                icon: _obscurePassword ? Iconsax.eye : Iconsax.eye_slash,
                iconColor: XMColors.shade2,
              ),
              const SizedBox(height: 24),
              XnTextField(
                label: "New Password",
                keyboardType: TextInputType.visiblePassword,
                // controller: passwordController,
                onSaved: (value) => data["password"] = value!,
                validator: (value) => validatePassword(value!),
                iconTap: togglePassword,
                obscureContent: _obscurePassword ? true : false,
                icon: _obscurePassword ? Iconsax.eye : Iconsax.eye_slash,
                iconColor: XMColors.shade2,
              ),
              const SizedBox(height: 24),
              XnTextField(
                label: "Confirm New Password",
                keyboardType: TextInputType.visiblePassword,
                // controller: passwordController,
                onSaved: (value) => data["password"] = value!,
                validator: (value) => validatePassword(value!),
                iconTap: togglePassword,
                obscureContent: _obscurePassword ? true : false,
                icon: _obscurePassword ? Iconsax.eye : Iconsax.eye_slash,
                iconColor: XMColors.shade2,
              ),
              const SizedBox(height: 26),
              XnSolidButton(
                content: Text(
                  "Change Password",
                  style: textTheme.bodyText1?.copyWith(
                    color: XMColors.shade6,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                backgroundColor: XMColors.primary,
                action: () => _submit(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
