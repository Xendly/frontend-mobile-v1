import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xendly_mobile/controller/core/user_auth.dart';
import 'package:xendly_mobile/view/shared/colors.dart';
import 'package:xendly_mobile/view/shared/routes.dart' as routes;

class CreatePinController extends GetxController {
  final _userAuth = Get.put(UserAuth());
  GlobalKey<FormState> formKey =
      GlobalKey<FormState>(debugLabel: "_createPinKey");

  var pinController = TextEditingController();

  final isLoading = false.obs;

  Map<String, dynamic> data = {
    "pin": "",
  };

  @override
  void onInit() {
    super.onInit();
    pinController;
  }

  // @override
  // void onClose() {
  //   pinController.dispose();
  // }

  // === fields validation === //
  String? validateTransactionPin(String value) {
    if (GetUtils.isNullOrBlank(value)!) {
      return "Fill in your four digit code";
    } else if (!GetUtils.isNumericOnly(value)) {
      return "Provide a valid four digit code";
    } else if (GetUtils.isLengthLessThan(value, 4)) {
      return "4 digit code must be 4!";
    }
  }

  // === CHECK THE WHOLE VALIDATION === //
  void checkPinValidation() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      printInfo(info: "pin is not valid");
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
          return Get.toNamed(
            routes.createPIN,
          );
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
}
