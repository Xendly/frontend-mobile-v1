import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/data/services/auth_service.dart';
import 'package:xendly_mobile/src/data/services/user_auth.dart';
import 'package:xendly_mobile/src/presentation/views/home.dart';

class SignInController extends GetxController {
  final _userAuth = Get.put(AuthService());
  GlobalKey<FormState> signInFormKey =
      GlobalKey<FormState>(debugLabel: "_signInKey");

  late TextEditingController emailController;
  late TextEditingController passwordController;

  RxString controllerEmail = ''.obs;
  final isLoading = false.obs;

  Map<String, dynamic> data = {
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
    String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
    RegExp regExp = RegExp(pattern);
    if (GetUtils.isNullOrBlank(value)!) {
      return "Enter your Security Password";
    } else if (GetUtils.isLengthLessOrEqual(value, 7)) {
      return "Password must contain 8 characters";
    } else if (!regExp.hasMatch(value)) {
      return "Password must include:\n- 1 uppercase\n- 1 lowercase\n- 1 number";
    } else {
      return null;
    }
  }

  // === check the entire sign in === //
  void checkSignInValidation() async {
    final isValid = signInFormKey.currentState!.validate();
    if (!isValid) {
      printInfo(info: "some fields are invalid");
    } else {
      signInFormKey.currentState!.save();
      isLoading.toggle();
      try {
        final result = await _userAuth.loginUser(data);
        isLoading.toggle();
        if (result["statusCode"] == 200) {
          printInfo(info: "${result["message"]}");
          Get.snackbar(
            result["status"],
            result["message"],
            backgroundColor: Colors.green,
            colorText: XMColors.light,
            duration: const Duration(seconds: 5),
          );
          return Get.to(
            const Home(),
            arguments: {
              "email": data["email"],
            },
          );
        } else {
          printInfo(info: "${result["message"]}");
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
      } catch (error) {}
    }
  }
}
