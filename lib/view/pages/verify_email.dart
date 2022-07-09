import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:xendly_mobile/controller/core/constants.dart';
import 'package:xendly_mobile/controller/core/user_auth.dart';
import 'package:xendly_mobile/controller/verify_email_controller.dart';
import 'package:xendly_mobile/view/shared/colors.dart';
import 'package:xendly_mobile/view/shared/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:xendly_mobile/view/shared/widgets/solid_button.dart';
import 'package:xendly_mobile/view/shared/routes.dart' as routes;

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({Key? key}) : super(key: key);
  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  TextEditingController textEditingController = TextEditingController();
  final _userAuth = Get.put(UserAuth());
  // === FORM VALIDATION === //
  var verifyEmailController = Get.put(VerifyEmailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: XMColors.light,
      extendBody: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              pageLabel("Email Verification", context),
              const Spacer(),
              heading2(
                "Verify your Email",
                XMColors.dark,
              ),
              const SizedBox(height: 25),
              strongBody(
                "We sent the verification code to your email inbox at ${Get.arguments["email"]}",
                XMColors.gray,
                FontWeight.w500,
                TextAlign.center,
              ),
              const SizedBox(height: 15),
              Form(
                key: verifyEmailController.formKey,
                child: PinCodeTextField(
                  length: 6,
                  onChanged: (value) {},
                  appContext: context,
                  textStyle: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    color: XMColors.primary,
                  ),
                  cursorColor: XMColors.primary,
                  cursorHeight: 17,
                  onSaved: (value) {
                    verifyEmailController.data["token"] = value;
                    verifyEmailController.data["email"] =
                        Get.arguments["email"];
                  },
                  validator: (value) {
                    return verifyEmailController.validateTokenCode(value!);
                  },
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.underline,
                    fieldWidth: 52,
                    activeColor: XMColors.primary,
                    selectedColor: XMColors.primary,
                    inactiveColor: XMColors.gray,
                    activeFillColor: XMColors.primary,
                    selectedFillColor: XMColors.none,
                  ),
                  enablePinAutofill: true,
                  errorTextSpace: 16,
                  controller: textEditingController,
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  body(
                    "Didn't receive the code?",
                    XMColors.gray,
                    16,
                  ),
                  const SizedBox(width: 8),
                  InkWell(
                    onTap: () {
                      if (Get.arguments?['email'] != null) {
                        verifyEmailController.resendOtp(Get.arguments['email']);
                        print(Get.arguments);
                      }
                    },
                    child: body(
                      "Resend",
                      XMColors.primary,
                      16,
                      TextAlign.left,
                      FontWeight.w600,
                    ),
                  )
                ],
              ),
              const Spacer(),
              SolidButton(
                text: "Proceed to Create PIN",
                textColor: XMColors.light,
                buttonColor: XMColors.primary,
                action: () {
                  verifyEmailController.checkTokenValidation();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
