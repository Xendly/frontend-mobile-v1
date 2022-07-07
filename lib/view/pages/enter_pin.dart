import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:xendly_mobile/view/shared/colors.dart';
import 'package:xendly_mobile/view/shared/widgets.dart';
import 'package:xendly_mobile/view/shared/widgets/solid_button.dart';
import 'package:xendly_mobile/view/shared/routes.dart' as routes;

class EnterPIN extends StatefulWidget {
  const EnterPIN({Key? key}) : super(key: key);
  @override
  State<EnterPIN> createState() => _EnterPINState();
}

class _EnterPINState extends State<EnterPIN> {
  TextEditingController textEditingController = TextEditingController();
  String currentText = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: XMColors.light,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              pageLabel("Enter Transaction PIN", context),
              const Spacer(),
              heading2(
                "Enter your 4-Digit PIN",
                XMColors.dark,
              ),
              const SizedBox(height: 15),
              strongBody(
                "Provide your 4-Digit transaction PIN code to confirm this payment",
                XMColors.gray,
                FontWeight.w500,
                TextAlign.center,
              ),
              const SizedBox(height: 18),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: PinCodeTextField(
                  length: 4,
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
                    fieldWidth: 60,
                    activeColor: XMColors.primary,
                    selectedColor: XMColors.primary,
                    inactiveColor: XMColors.gray,
                    activeFillColor: XMColors.primary,
                    selectedFillColor: XMColors.none,
                  ),
                  controller: textEditingController,
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(height: 15),
              strongBody(
                "Ensure your transaction PIN is not shared to anyone else to protect your account",
                XMColors.gray,
                FontWeight.w500,
                TextAlign.center,
              ),
              const Spacer(),
              SolidButton(
                text: "Confirm Transaction",
                textColor: XMColors.light,
                buttonColor: XMColors.primary,
                action: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        insetPadding:
                            const EdgeInsets.symmetric(horizontal: 25),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 65,
                            horizontal: 18,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // action icon
                              const SizedBox(
                                height: 24,
                              ),
                              heading(
                                "Transaction in Progress",
                                XMColors.dark,
                                22,
                                TextAlign.center,
                                FontWeight.w700,
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              bodyText(
                                "We are verifying yout transaction, this may take a few minutes",
                                XMColors.gray,
                                FontWeight.w500,
                                TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
