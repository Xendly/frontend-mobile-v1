import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPwdController extends GetxController {
  GlobalKey<FormState> forgotPwdFormKey =
      GlobalKey<FormState>(debugLabel: "_forgotPasswordKey");

  late TextEditingController emailController;

  Map<String, dynamic> forgotPwdData = {
    "email": "",
  };

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
  }

  @override
  void onClose() {
    emailController.dispose();
  }

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
  void checkForgotPwdValidation() {
    final isValid = forgotPwdFormKey.currentState!.validate();
    if (!isValid) {
      print("some fields are invalid");
    } else {
      print("all fields are valid");
      forgotPwdFormKey.currentState!.save();
    }
  }
}
