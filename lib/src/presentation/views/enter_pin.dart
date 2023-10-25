import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import "../../config/routes.dart" as routes;
import '../../core/utilities/helpers/validator_helper.dart';
import '../../core/utilities/interfaces/colors.dart';
import '../../domain/usecases/auth/logout_usecase.dart';
import '../../domain/usecases/auth/verify_pin_usecase.dart';
import '../../presentation/view_model/auth/logout_view_model.dart';
import '../../presentation/view_model/auth/verify_pin_controller.dart';
import '../../presentation/widgets/buttons/solid_button.dart';
import '../../presentation/widgets/titles/title_one.dart';

class EnterPIN extends StatefulWidget {
  const EnterPIN({Key? key}) : super(key: key);
  @override
  State<EnterPIN> createState() => _EnterPINState();
}

class _EnterPINState extends State<EnterPIN> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>(debugLabel: "enter_pin");
  TextEditingController pinController = TextEditingController();

  final VerifyPinController verifyPinController = Get.put(
    VerifyPinController(
      Get.find<VerifyPinUseCase>(),
    ),
  );

  final LogoutViewModel logoutController = Get.put(
    LogoutViewModel(
      Get.find<LogOutUsecase>(),
    ),
  );

  @override
  void initState() {
    super.initState();
    pinController;
  }

  void _submit() async {
    final isValid = formKey.currentState!.validate();
    if (isValid) {
      formKey.currentState!.save();
      try {
        await verifyPinController.verifyPin(data);
        if (verifyPinController.message.value == "Transaction pin verified") {
          Get.offAndToNamed(routes.home);
        }
      } catch (error) {
        Get.snackbar("An error occured", error.toString());
      }
    }
  }

  void _logout() async {
    try {
      logoutController.userLogout();
    } catch (err) {
      Get.snackbar("Error!", err.toString());
    }
  }

  Map<String, dynamic> data = {
    "pin": "",
  };

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      extendBody: true,
      backgroundColor: XMColors.light,
      body: SafeArea(
        child: SingleChildScrollView(
          // child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const TitleOne(
                title: "Enter Pin Code",
                subtitle:
                    "Use your pin code for easy login and to confirm transactions",
              ),
              Form(
                key: formKey,
                child: PinCodeTextField(
                  length: 4,
                  obscureText: true,
                  blinkWhenObscuring: true,
                  onChanged: (value) {},
                  appContext: context,
                  textStyle: textTheme.titleMedium?.copyWith(
                    color: XMColors.shade1,
                  ),
                  cursorColor: XMColors.primary,
                  cursorHeight: 17,
                  controller: pinController,
                  onSaved: (value) => data["pin"] = value,
                  validator: (value) => validatePin(value!),
                  errorTextSpace: 24.0,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(8),
                    fieldWidth: 64.0,
                    fieldHeight: 60.0,
                    activeColor: XMColors.shade4,
                    selectedColor: XMColors.primary,
                    inactiveColor: XMColors.shade4,
                    activeFillColor: XMColors.shade6,
                    selectedFillColor: XMColors.shade6,
                  ),
                  enablePinAutofill: true,
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(height: 22),
              XnSolidButton(
                content: Obx(() {
                  return verifyPinController.isLoading.value
                      ? const CupertinoActivityIndicator(
                          color: XMColors.shade6,
                        )
                      : Text(
                          "Continue",
                          style: textTheme.bodyLarge?.copyWith(
                            color: XMColors.shade6,
                            fontWeight: FontWeight.w500,
                          ),
                        );
                }),
                backgroundColor: XMColors.primary,
                action: () => _submit(),
              ),
              const SizedBox(height: 24.0),
              XnSolidButton(
                backgroundColor: XMColors.error3.withOpacity(.2),
                borderColor: XMColors.error3.withOpacity(.2),
                content: Obx(() {
                  return logoutController.isLoading.value
                      ? const CupertinoActivityIndicator(
                          color: XMColors.error0,
                        )
                      : Text(
                          "Logout",
                          style: textTheme.bodyLarge?.copyWith(
                            color: XMColors.error0,
                            fontWeight: FontWeight.w600,
                          ),
                        );
                }),
                action: () => _logout(),
              ),
            ],
          ),
        ),
        // ),
      ),
    );
  }
}
