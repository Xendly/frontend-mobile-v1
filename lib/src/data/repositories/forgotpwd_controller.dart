import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/data/services/user_auth.dart';
import 'package:xendly_mobile/src/presentation/views/reset_password.dart';

class ForgotPwdController extends GetxController {
  final _userAuth = Get.put(UserAuth());
  GlobalKey<FormState> formKey =
      GlobalKey<FormState>(debugLabel: "_forgotPasswordKey");

  late TextEditingController emailController;

  Map<String, dynamic> data = {
    "email": "",
  };

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
  }

  // @override
  // void onClose() {
  //   emailController.dispose();
  // }

  // === fields validation === //
  String? validateEmail(String value) {
    if (GetUtils.isNullOrBlank(value)!) {
      return "Provide an Email Address";
    } else if (!GetUtils.isEmail(value)) {
      return "Provide a valid Email Address";
    } else {
      return null;
    }
  }

  // === check the entire sign in === //
  void checkForgotPwdValidation() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      printInfo(info: "some fields are invalid");
    } else {
      printInfo(info: "all fields are valid");
      formKey.currentState!.save();
      try {
        final result = await _userAuth.forgotPassword(data);
        if (result["statusCode"] == 200) {
          printInfo(info: "${result["message"]}, ${result["status"]}");
          Get.snackbar(
            result["status"],
            result["message"],
            backgroundColor: Colors.green,
            colorText: XMColors.light,
            duration: const Duration(seconds: 5),
          );
          return Get.to(() => ResetPassword(),
              transition: Transition.rightToLeft,
              arguments: {
                "email": data["email"],
              });
          //   const ResetPassword(),
          //   arguments: {
          //     "email": data["email"],
          //   },
          // );
        } else {
          printInfo(info: "${result["message"]}, ${result["statusCode"]}");
          if (result["message"] != null || result["status"] != "failed") {
            Get.closeAllSnackbars();
            Get.snackbar(
              result["status"].toString(),
              result["message"],
              backgroundColor: Colors.red,
              colorText: XMColors.light,
              duration: const Duration(seconds: 5),
            );
          } else {
            Get.closeAllSnackbars();
            Get.snackbar(
              result["status"].toString(),
              result["message"],
              backgroundColor: Colors.red,
              colorText: XMColors.light,
              duration: const Duration(seconds: 5),
            );
            Get.snackbar(
              result["status"],
              result["message"],
              backgroundColor: Colors.red,
              colorText: XMColors.light,
              duration: const Duration(seconds: 5),
            );
          }
        }
      } catch (error) {
        printInfo(info: error.toString());
      }
    }
  }
}
