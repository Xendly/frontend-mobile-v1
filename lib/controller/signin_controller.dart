import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  GlobalKey<FormState> signInFormKey =
      GlobalKey<FormState>(debugLabel: "_signInKey");

  late TextEditingController emailController;
  late TextEditingController passwordController;

  Map<String, dynamic> signInData = {
    "email": "",
    "password": "",
  };

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
  }

  // === fields validation === //
  String? validateEmail(String value) {
    if (GetUtils.isNullOrBlank(value)!) {
      return "Enter your Email Address";
    } else if (!GetUtils.isEmail(value)) {
      return "Provide a valid Email Address";
    } else {
      return null;
    }
  }

  String? validatePassword(String value) {
    if (GetUtils.isNullOrBlank(value)!) {
      return "Enter your Security Password";
    } else if (GetUtils.isLengthLessOrEqual(value, 5)) {
      return "Password must contain 5 characters";
    } else {
      return null;
    }
  }

  // === check the entire sign in === //
  void checkSignInValidation() {
    final isValid = signInFormKey.currentState!.validate();
    if (!isValid) {
      print("some fields are invalid");
    } else {
      print("all fields are valid");
      signInFormKey.currentState!.save();
    }
  }
}
