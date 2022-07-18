import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:xendly_mobile/controller/core/user_auth.dart';
import 'package:xendly_mobile/view/pages/sign_in.dart';
import 'package:xendly_mobile/view/shared/widgets/password_input.dart';

// === CUSTOM IMPORTS === //
import '../../view/shared/colors.dart';
import '../../view/shared/widgets.dart';
import '../../view/shared/widgets/solid_button.dart';
import '../../view/shared/widgets/text_input.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);
  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  // === UNSORTED === //
  bool? value = false;
  bool _obscureText = true;
  void togglePassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  // === CONTROLLER === //
  final _userAuth = Get.put(UserAuth());
  GlobalKey<FormState> formKey =
      GlobalKey<FormState>(debugLabel: "_resetPasswordKey");

  TextEditingController? emailController = TextEditingController();
  TextEditingController? passwordController = TextEditingController();

  RxString controllerEmail = ''.obs;
  final isLoading = false.obs;

  Map<String, dynamic> data = {
    "email": "",
    "token": "",
    "password": "",
  };

  void onInit() {
    super.initState();
    emailController;
    passwordController;
  }

  // String? validateEmail(String value) {
  //   if (GetUtils.isNullOrBlank(value)!) {
  //     return "Enter your Email Address";
  //   } else if (!GetUtils.isEmail(value)) {
  //     return "Provide a valid Email Address";
  //   } else {
  //     return null;
  //   }
  // }

  String? validateToken(String value) {
    if (GetUtils.isNullOrBlank(value)!) {
      return "Enter your Verification Code";
    } else if (GetUtils.isLengthLessThan(value, 3)) {
      return "Code must contain 6 characters";
    } else if (GetUtils.isLengthGreaterThan(value, 6)) {
      return "Code must contain 6 characters";
    } else if (!GetUtils.isNumericOnly(value)) {
      return "Code must contain only digits";
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
  void checkResetPasswordValidation() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      printInfo(info: "Some fields are not valid");
    } else {
      formKey.currentState!.save();
      isLoading.toggle();
      try {
        final result = await _userAuth.resetPassword(data);
        isLoading.toggle();
        if (result['statusCode'] == 200 || result["statusCode"] == 201) {
          printInfo(info: "${result["message"]}");
          Get.snackbar(
            result["status"],
            result["message"],
            backgroundColor: Colors.green,
            colorText: XMColors.light,
            duration: const Duration(seconds: 5),
          );
          return Get.to(
            const SignIn(),
            arguments: {
              "email": data["email"],
              "password": data["password"],
            },
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
              backgroundColor: XMColors.red,
              colorText: XMColors.light,
              duration: const Duration(seconds: 5),
            );
          }
        }
      } catch (error) {
        isLoading.toggle();
        Get.snackbar("Error", "Unknown Error Occured, Try Again!");
        return printInfo(
          info: "Unknown Error Occured, Try Again!",
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: XMColors.light,
      extendBody: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 22,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                pageLabel("Reset Password", context),
                const SizedBox(height: 30),
                heading(
                  "Reset Your Password",
                  XMColors.dark,
                  26,
                  TextAlign.left,
                  FontWeight.w800,
                ),
                const SizedBox(height: 1),
                body(
                  "Enter your email to recover password",
                  XMColors.gray,
                  16,
                  TextAlign.left,
                  FontWeight.w500,
                ),
                const SizedBox(height: 26),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextInput(
                        readOnly: false,
                        label: "Token Code",
                        hintText: "0000",
                        inputType: TextInputType.number,
                        borderRadius: BorderRadius.circular(10),
                        controller: emailController,
                        onSaved: (value) => {
                          data["token"] = value,
                          data["email"] = Get.arguments["email"],
                        },
                        validator: (value) {
                          return validateToken(value!);
                        },
                      ),
                      const SizedBox(height: 25),
                      PasswordInput(
                        label: "Password for Security",
                        hintText: "*******",
                        controller: passwordController,
                        onSaved: (value) => data["password"] = value!,
                        validator: (value) {
                          return validatePassword(value!);
                        },
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 17),
                          child: GestureDetector(
                            onTap: togglePassword,
                            child: _obscureText
                                ? SvgPicture.asset(
                                    "assets/icons/eye.svg",
                                    width: 22,
                                    height: 22,
                                  )
                                : SvgPicture.asset(
                                    "assets/icons/eye-slash.svg",
                                    width: 22,
                                    height: 22,
                                  ),
                          ),
                        ),
                        obscureText: _obscureText ? true : false,
                      ),
                      const SizedBox(height: 30),
                      SolidButton(
                        text: "Send Recovery Email",
                        textColor: XMColors.light,
                        buttonColor: XMColors.primary,
                        action: () => {
                          checkResetPasswordValidation(),
                        },
                      ),
                      const SizedBox(height: 25),
                      Align(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () => {
                            Navigator.pop(
                              context,
                            ),
                          },
                          child: body(
                            "Return to the Login",
                            XMColors.accent,
                            16,
                            TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
