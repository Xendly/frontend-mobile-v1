import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:xendly_mobile/controller/core/user_auth.dart';
import 'package:xendly_mobile/controller/create_pin_controller.dart';
import 'package:xendly_mobile/view/shared/colors.dart';
import 'package:xendly_mobile/view/shared/widgets.dart';
import 'package:xendly_mobile/view/shared/widgets/solid_button.dart';
import 'package:xendly_mobile/view/shared/routes.dart' as routes;

class CreatePIN extends StatefulWidget {
  const CreatePIN({Key? key}) : super(key: key);
  @override
  State<CreatePIN> createState() => _CreatePINState();
}

class _CreatePINState extends State<CreatePIN> {
  // TextEditingController textEditingController = TextEditingController();
  var createPinController = Get.put(CreatePinController());

  @override
  Widget build(BuildContext context) {
    final _userAuth = Get.put(UserAuth());

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
              pageLabel("Create Your PIN", context),
              const Spacer(),
              heading2(
                "Create your 4-Digit PIN",
                XMColors.dark,
              ),
              const SizedBox(height: 15),
              strongBody(
                "Secure your account and ensure transactions faster with a 4-Digit PIN code",
                XMColors.gray,
                FontWeight.w500,
                TextAlign.center,
              ),
              const SizedBox(height: 18),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: createPinController.formKey,
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
                    controller: createPinController.pinController,
                    onSaved: (value) {
                      createPinController.data["pin"] = value;
                    },
                    validator: (value) {
                      return createPinController.validateTransactionPin(value!);
                    },
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.underline,
                      fieldWidth: 60,
                      activeColor: XMColors.primary,
                      selectedColor: XMColors.primary,
                      inactiveColor: XMColors.gray,
                      activeFillColor: XMColors.primary,
                      selectedFillColor: XMColors.none,
                    ),
                    keyboardType: TextInputType.number,
                  ),
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
                text: "Submit Security PIN",
                textColor: XMColors.light,
                buttonColor: XMColors.primary,
                action: () {
                  createPinController.checkPinValidation();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
