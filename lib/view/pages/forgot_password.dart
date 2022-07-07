import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xendly_mobile/controller/forgotpwd_controller.dart';
import 'package:xendly_mobile/view/shared/colors.dart';
import 'package:xendly_mobile/view/shared/widgets.dart';
import 'package:xendly_mobile/view/shared/widgets/solid_button.dart';
import 'package:xendly_mobile/view/shared/widgets/text_input.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);
  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  // === form validation === //
  var forgotPwdController = Get.put(
    ForgotPwdController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: XMColors.light,
      extendBody: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 22,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                pageLabel("Forgot Password", context),
                const SizedBox(height: 30),
                heading(
                  "Reset Your Password",
                  XMColors.dark,
                  26,
                  TextAlign.left,
                  FontWeight.w800,
                ),
                const SizedBox(height: 1),
                body(
                  "Enter your email to recover password",
                  XMColors.gray,
                  16,
                  TextAlign.left,
                  FontWeight.w500,
                ),
                const SizedBox(height: 26),
                Form(
                  key: forgotPwdController.forgotPwdFormKey,
                  child: Column(
                    children: [
                      TextInput(
                        readOnly: false,
                        label: "Email",
                        hintText: "johnpsmith@gmail.com",
                        inputType: TextInputType.emailAddress,
                        borderRadius: BorderRadius.circular(10),
                        controller: forgotPwdController.emailController,
                        onSaved: (value) =>
                            forgotPwdController.forgotPwdData["email"] = value!,
                        validator: (value) {
                          return forgotPwdController.validateEmail(value!);
                        },
                      ),
                      const SizedBox(height: 25),
                      SolidButton(
                        text: "Send Recovery Email",
                        textColor: XMColors.light,
                        buttonColor: XMColors.primary,
                        action: () {
                          forgotPwdController.checkForgotPwdValidation();
                        },
                      ),
                      const SizedBox(height: 25),
                      Align(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () => {
                            Navigator.pop(
                              context,
                            ),
                          },
                          child: body(
                            "Return to the Login",
                            XMColors.accent,
                            16,
                            TextAlign.center,
                          ),
                        ),
                      ),
                    ],
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
