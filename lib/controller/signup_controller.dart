import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xendly_mobile/controller/core/user_auth.dart';
import 'package:xendly_mobile/view/shared/colors.dart';

class SignUpController extends GetxController {
  final _userAuth = Get.put(UserAuth());
  GlobalKey<FormState> formKey = GlobalKey<FormState>(debugLabel: "_signUpKey");

  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController countryController;
  late TextEditingController phoneController;
  late TextEditingController dobController;
  late TextEditingController passwordController;

  Map<String, dynamic> data = {
    "firstName": "",
    "lastName": "",
    "email": "",
    "country": "",
    "phoneNo": "",
    "dob": "",
    "password": "",
  };

  @override
  void onInit() {
    super.onInit();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    countryController = TextEditingController();
    phoneController = TextEditingController();
    dobController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    countryController.dispose();
    phoneController.dispose();
    dobController.dispose();
    passwordController.dispose();
  }

  // === fields validation === //
  String? validateFirstName(String value) {
    if (GetUtils.isNullOrBlank(value)!) {
      return "Enter your First Name";
    } else if (!GetUtils.isAlphabetOnly(value)) {
      return "Provide a valid First Name";
    } else {
      return null;
    }
  }

  String? validateLastName(String value) {
    if (GetUtils.isNullOrBlank(value)!) {
      return "Enter your Last Name";
    } else if (!GetUtils.isAlphabetOnly(value)) {
      return "Provide a valid Last Name";
    } else {
      return null;
    }
  }

  String? validateEmail(String value) {
    if (GetUtils.isNullOrBlank(value)!) {
      return "Enter your Email Address";
    } else if (!GetUtils.isEmail(value)) {
      return "Provide a valid Email Address";
    } else {
      return null;
    }
  }

  String? validateCountry(String? value) {
    if (GetUtils.isNullOrBlank(value)!) {
      return "Select your Country of Residence";
    } else {
      return null;
    }
  }

  String? validatePhone(String value) {
    if (GetUtils.isNullOrBlank(value)!) {
      return "Enter your Phone Number";
    } else if (!GetUtils.isNum(value)) {
      return "Provide a valid Phone Number";
    } else {
      return null;
    }
  }

  String? validateDob(String value) {
    if (GetUtils.isNullOrBlank(value)!) {
      return "Enter your Date of Birth";
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

  // === CHECK THE WHOLE VALIDATION === //
  void checkSignUpValidation() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      printInfo(info: "Some fields are not valid");
    } else {
      formKey.currentState!.save();
      try {
        final result = await _userAuth.registerUser(data);
        if (result['statusCode'] == 200 || result["statusCode"] == 201) {
          printInfo(info: "${result["message"]}");
          Get.snackbar(
            result["status"],
            result["message"],
            backgroundColor: Colors.green,
            colorText: XMColors.light,
            duration: const Duration(seconds: 5),
          );
        } else {
          printInfo(info: "${result["message"]}");
          if (result["message"] != null || result["status"] != "failed") {
            Get.snackbar(
              result["status"],
              result["message"],
            );
          } else {
            Get.closeAllSnackbars();
            Get.snackbar(
              result["status"].toString(),
              result["message"],
              backgroundColor: XMColors.danger,
              colorText: XMColors.light,
              duration: const Duration(seconds: 5),
            );
          }
        }
      } catch (error) {
        Get.snackbar("Error", "Unknown Error Occured, Try Again!");
        return printInfo(
          info: "Unknown Error Occured, Try Again!",
        );
      }
    }
  }
}
