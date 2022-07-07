import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:xendly_mobile/view/shared/colors.dart';
import 'package:xendly_mobile/view/shared/widgets.dart';
import 'package:xendly_mobile/view/shared/widgets/solid_button.dart';
import 'package:xendly_mobile/view/shared/routes.dart' as routes;

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({Key? key}) : super(key: key);
  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  TextEditingController textEditingController = TextEditingController();
  String currentText = "";
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
                "We sent the verification code to your email inbox at johnsmith90@gmail.com",
                XMColors.gray,
                FontWeight.w500,
                TextAlign.center,
              ),
              const SizedBox(height: 15),
              PinCodeTextField(
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
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.underline,
                  fieldWidth: 52,
                  activeColor: XMColors.primary,
                  selectedColor: XMColors.primary,
                  inactiveColor: XMColors.gray,
                  activeFillColor: XMColors.primary,
                  selectedFillColor: XMColors.none,
                ),
                controller: textEditingController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 15),
              richText(
                "And in case you missed it, you can resend the verification code in ",
                "05:36s",
                TextAlign.center,
              ),
              const Spacer(),
              SolidButton(
                text: "Proceed to Create PIN",
                textColor: XMColors.light,
                buttonColor: XMColors.primary,
                action: () {
                  Navigator.pushNamed(context, routes.createPIN);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
