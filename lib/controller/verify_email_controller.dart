import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xendly_mobile/controller/core/user_auth.dart';
import 'package:xendly_mobile/view/shared/colors.dart';

class VerifyEmailController extends GetxController {
  final _userAuth = Get.put(UserAuth());
  GlobalKey<FormState> formKey =
      GlobalKey<FormState>(debugLabel: "_verifyEmailKey");

  late TextEditingController tokenController;

  Map<String, dynamic> data = {
    "token": "",
    "email": "",
  };

  @override
  void onInit() {
    super.onInit();
    tokenController = TextEditingController();
  }

  @override
  void onClose() {
    tokenController.dispose();
  }

  // === fields validation === //
  String? validateTokenCode(String value) {
    if (GetUtils.isNullOrBlank(value)!) {
      return "Fill in your six digit code";
    } else if (!GetUtils.isNumericOnly(value)) {
      return "Provide a valid six digit code";
    } else if (GetUtils.isLengthLessThan(value, 6)) {
      return "Fill in all the fields, idiot!";
    }
  }

  // === CHECK THE WHOLE VALIDATION === //
  void checkTokenValidation() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      printInfo(info: "code not verified");
    } else {
      formKey.currentState!.save();
      printInfo(
          info: "code verified - token => ${data['token']}, ${data['email']}");
      try {
        final result = await _userAuth.verifyEmail(data);
        if (result['statusCode'] == 200 || result["statusCode"] == 201) {
          printInfo(
            info:
                ">>> Your code is either invalid or expired <<< >>> ${result['message']} <<<",
          );
          Get.snackbar(
            result["status"],
            result["message"],
            backgroundColor: Colors.green,
            colorText: XMColors.light,
            duration: const Duration(seconds: 5),
          );
        } else {
          printInfo(
            info:
                ">>> Your code is either invalid or expired <<< >>> ${result['message']} <<<",
          );
          Get.snackbar(
            result["status"],
            result["message"],
            backgroundColor: Colors.red,
            colorText: XMColors.light,
            duration: const Duration(seconds: 5),
          );
        }
      } catch (error) {
        Get.snackbar("Error", "Unknown Error Occured, Try Again!");
        return printInfo(
          info: "Unknown Error Occured, Try Again! - $error",
        );
      }
    }

    // if (isValid) {
    //   print("valid");
    //   // formKey.currentState.save();
    //   // await _userAuth.verifyEmail(data);
    //   // Get.offNamed(routes.SIGN_UP_SUCCESS);
    // } else {
    //   print("not valid");
    // }
    // if (!isValid) {
    //   printInfo(info: "Some fields are not valid");
    // } else {
    //   // formKey.currentState!.save();
    //   printInfo(info: "Verification fields are valid");
    //   // try {
    //   //   final result = await _userAuth.registerUser(data);
    //   //   if (result['statusCode'] == 200 || result["statusCode"] == 201) {
    //   //     printInfo(info: "${result["message"]}");
    //   //     Get.snackbar(
    //   //       result["status"],
    //   //       result["message"],
    //   //       backgroundColor: Colors.green,
    //   //       colorText: XMColors.light,
    //   //       duration: const Duration(seconds: 5),
    //   //     );
    //   //     return Get.toNamed(routes.verifyEmail);
    //   //   } else {
    //   //     printInfo(info: "${result["message"]}");
    //   //     if (result["message"] != null || result["status"] != "failed") {
    //   //       Get.snackbar(
    //   //         result["status"],
    //   //         result["message"],
    //   //       );
    //   //     } else {
    //   //       Get.closeAllSnackbars();
    //   //       Get.snackbar(
    //   //         result["status"].toString(),
    //   //         result["message"],
    //   //         backgroundColor: XMColors.danger,
    //   //         colorText: XMColors.light,
    //   //         duration: const Duration(seconds: 5),
    //   //       );
    //   //     }
    //   //   }
    //   // } catch (error) {
    //   //   Get.snackbar("Error", "Unknown Error Occured, Try Again!");
    //   //   return printInfo(
    //   //     info: "Unknown Error Occured, Try Again!",
    //   //   );
    //   // }
    // }
  }
}
