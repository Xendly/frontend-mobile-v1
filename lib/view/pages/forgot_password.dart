// === DEFAULT IMPORTS === //
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// === CUSTOM IMPORTS === //
import '../../controller/core/user_auth.dart';
import '../../view/pages/reset_password.dart';
import '../../view/shared/colors.dart';
import '../../view/shared/widgets.dart';
import '../../view/shared/widgets/solid_button.dart';
import '../../view/shared/widgets/text_input.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);
  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  // === CONTROLLER === //
  final _userAuth = Get.put(UserAuth());
  GlobalKey<FormState> formKey =
      GlobalKey<FormState>(debugLabel: "_forgotPasswordKey");

  TextEditingController? emailController = TextEditingController();

  Map<String, dynamic> data = {
    "email": "",
  };

  void onInit() {
    super.initState();
    emailController;
  }

  String? validateEmail(String value) {
    if (GetUtils.isNullOrBlank(value)!) {
      return "Provide an Email Address";
    } else if (!GetUtils.isEmail(value)) {
      return "Provide a valid Email Address";
    } else {
      return null;
    }
  }

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
          return Get.to(
            () => const ResetPassword(),
            transition: Transition.rightToLeft,
            arguments: {
              "email": data["email"],
            },
          );
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
                pageLabel("Forgot Password", context),
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
                        label: "Email",
                        hintText: "johnpsmith@gmail.com",
                        inputType: TextInputType.emailAddress,
                        borderRadius: BorderRadius.circular(10),
                        controller: emailController,
                        onSaved: (value) => data["email"] = value!,
                        validator: (value) {
                          return validateEmail(value!);
                        },
                      ),
                      const SizedBox(height: 25),
                      SolidButton(
                        text: "Send Recovery Email",
                        textColor: XMColors.light,
                        buttonColor: XMColors.primary,
                        action: () {
                          checkForgotPwdValidation();
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
