import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xendly_mobile/controller/core/user_auth.dart';
import 'package:xendly_mobile/view/shared/colors.dart';

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
        final result = await _userAuth.loginUser(data);
        if (result["statusCode"] == 200) {
          printInfo(info: "${result["message"]}, ${result["status"]}");
          Get.snackbar(
            result["status"],
            result["message"],
            backgroundColor: Colors.green,
            colorText: XMColors.light,
            duration: const Duration(seconds: 5),
          );
          // return Get.to(
          //   const Home(),
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
