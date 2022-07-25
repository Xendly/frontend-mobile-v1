import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../controller/core/user_auth.dart';
import '../../controller/create_pin_controller.dart';
import '../../view/shared/colors.dart';
import '../../view/shared/widgets.dart';
import '../../view/shared/widgets/solid_button.dart';
import '../../view/shared/routes.dart' as routes;

class CreatePIN extends StatefulWidget {
  const CreatePIN({Key? key}) : super(key: key);
  @override
  State<CreatePIN> createState() => _CreatePINState();
}

class _CreatePINState extends State<CreatePIN> {
  GlobalKey<FormState> formKey =
      GlobalKey<FormState>(debugLabel: "_createPinKey");

  var pinController = TextEditingController();

  final isLoading = false.obs;

  Map<String, dynamic> data = {
    "pin": "",
  };

  @override
  void initState() {
    super.initState();
    pinController;

    printInfo(info: "Pincode bool from Login => ${Get.arguments}");

    if (Get.arguments) {
      Future.microtask(() => Get.toNamed(routes.home));
    } else {
      Future.microtask(() => Get.toNamed(routes.createPIN));
    }
  }

  // === fields validation === //
  String? validateTransactionPin(String value) {
    if (GetUtils.isNullOrBlank(value)!) {
      return "Enter your Transaction PIN";
    } else if (!GetUtils.isNumericOnly(value)) {
      return "PIN must contain only digits";
    } else if (GetUtils.isLengthLessThan(value, 4)) {
      return "PIN must contain 4 characters";
    }
  }

  @override
  Widget build(BuildContext context) {
    final _userAuth = Get.put(UserAuth());

    // === CHECK THE WHOLE VALIDATION === //
    void checkPinValidation() async {
      final isValid = formKey.currentState!.validate();
      if (!isValid) {
        printInfo(info: "pin is not valid");
        printInfo(info: "Data sent from Login >>> ${Get.arguments} <<<");
      } else {
        formKey.currentState!.save();
        isLoading.toggle();
        printInfo(info: "pin is valid => ${data['pin']}");
        try {
          final result = await _userAuth.createTransactionPin(data);
          isLoading.toggle();
          if (result['statusCode'] == 200 || result["statusCode"] == 201) {
            printInfo(
              info: ">>> ${result['message']} <<<",
            );
            Get.snackbar(
              result["status"],
              result["message"],
              backgroundColor: Colors.green,
              colorText: XMColors.light,
              duration: const Duration(seconds: 5),
            );
            // return Get.toNamed(
            //   routes.createPIN,
            // );
          } else {
            printInfo(
              info: ">>> ${result['message']} ==> ${result['statusCode']} <<<",
            );
            Get.snackbar(
              result["status"],
              result["message"],
              backgroundColor: Colors.red,
              colorText: XMColors.light,
              duration: const Duration(seconds: 5),
            );
          }
          //   final result = await _userAuth.createTransactionPin(data);
          //   if (result['statusCode'] == 200 || result["statusCode"] == 201) {
          //     printInfo(
          //       info: ">>> ${result['message']} <<<",
          //     );
          //     Get.snackbar(
          //       result["status"],
          //       result["message"],
          //     );
          //   } else {
          //     printInfo(
          //       info: ">>> ${result['message']} <<<",
          //     );
          //     Get.snackbar(
          //       result["status"],
          //       result["message"],
          //     );
          //   }
        } catch (error) {
          printInfo(info: ">>> $error <<<");
          Get.snackbar(
            "Error",
            error.toString(),
          );
        }
      }
    }

    if (Get.arguments != true) {
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
                    key: formKey,
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
                      controller: pinController,
                      onSaved: (value) {
                        data["pin"] = value;
                      },
                      validator: (value) {
                        return validateTransactionPin(value!);
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
                      enablePinAutofill: true,
                      errorTextSpace: 16,
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
                    checkPinValidation();
                  },
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return const Scaffold(
        body: Center(
          child: Text("You already have a PIN"),
        ),
      );
      // return
    }
  }
}
