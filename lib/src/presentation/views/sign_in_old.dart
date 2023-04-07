import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/config/utilities.dart';
import 'package:xendly_mobile/src/data/services/auth_service.dart';
import 'package:xendly_mobile/src/presentation/widgets/widgets.dart';
import 'package:xendly_mobile/src/presentation/widgets/widgets.dart';
import 'package:xendly_mobile/src/presentation/widgets/bottomSheet.dart';
import 'package:xendly_mobile/src/presentation/widgets/buttons/rounded.dart';
import 'package:xendly_mobile/src/presentation/widgets/dropdown_input.dart';
import 'package:xendly_mobile/src/presentation/widgets/password_input.dart';
import 'package:xendly_mobile/src/presentation/widgets/safe_area.dart';
import 'package:xendly_mobile/src/presentation/widgets/solid_button.dart';
import 'package:xendly_mobile/src/presentation/widgets/tabPage_title.dart';
import 'package:xendly_mobile/src/presentation/widgets/text_input.dart';
import 'package:xendly_mobile/src/presentation/widgets/title_bar.dart';
import 'package:xendly_mobile/src/presentation/widgets/wallets_item.dart';
import 'package:xendly_mobile/src/data/models/beneficiary_model.dart';
import 'package:xendly_mobile/src/data/models/country_model.dart';
import 'package:xendly_mobile/src/data/models/transaction_model_old.dart';
import 'package:xendly_mobile/src/data/models/user_model_old.dart';
import 'package:xendly_mobile/src/data/services/beneficiary_auth.dart';
import 'package:xendly_mobile/src/data/services/public_auth.dart';
import 'package:xendly_mobile/src/data/services/token_storage.dart';
import 'package:xendly_mobile/src/data/services/transaction_service.dart';
import 'package:xendly_mobile/src/data/services/user_auth.dart';
import 'package:xendly_mobile/src/data/services/wallet_auth.dart';
import 'package:xendly_mobile/src/presentation/views/create_pin.dart';
import '../../config/routes.dart' as routes;

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // === UNSORTED === //
  bool _obscureText = true;
  void togglePassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

// === CONTROLLER === //
  final _userAuth = Get.put(AuthService());
  GlobalKey<FormState> formKey = GlobalKey<FormState>(debugLabel: "_signInKey");

  TextEditingController? emailController = TextEditingController();
  TextEditingController? passwordController = TextEditingController();

  RxString controllerEmail = ''.obs;
  final isLoading = false.obs;

  Map<String, dynamic> data = {
    "email": "",
    "password": "",
  };

  void onInit() {
    super.initState();
    emailController;
    passwordController;
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

  void checkSignInValidation() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      printInfo(info: "some fields are invalid");
    } else {
      formKey.currentState!.save();
      isLoading.toggle();
      try {
        final result = await _userAuth.loginUser(data);
        isLoading.toggle();
        if (result["statusCode"] == 200) {
          printInfo(info: "Status => ${result['status']}");
          printInfo(info: "Status Code => ${result['statusCode']}");
          printInfo(info: "Message => ${result['message']}");
          TokenStorage().storeToken(result["token"]["token"]);
          printInfo(
            info: "Bearer Token from Storage => ${TokenStorage().readToken()}",
          );

          Get.snackbar(
            result["status"],
            result["message"],
            backgroundColor: Colors.green,
            colorText: XMColors.light,
            duration: const Duration(seconds: 5),
          );

          printInfo(info: "Logged User Data >>> ${result['data']} <<<");
          bool? hasPincode = result["data"]["has_pincode"] as bool;
          printInfo(info: "Pincode $hasPincode");

          return hasPincode
              ? Get.toNamed(routes.home)
              : Get.to(
                  const CreatePIN(),
                  arguments: hasPincode,
                  //   arguments: {
                  //     "has_pincode": hasPincode,
                  //   },
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
                pageLabel("Login your Account", context),
                const SizedBox(height: 30),
                heading(
                  "Log In Your Account",
                  XMColors.dark,
                  26,
                  TextAlign.left,
                  FontWeight.w800,
                ),
                const SizedBox(height: 1),
                body(
                  "Sign into Xendly in just a minute",
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
                      PasswordInput(
                        label: "Password",
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
                      const SizedBox(height: 22),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () => {
                            Navigator.pushNamed(
                              context,
                              routes.forgotPassword,
                            ),
                          },
                          child: body(
                            "Forgot Password?",
                            XMColors.accent,
                            16,
                            TextAlign.end,
                          ),
                        ),
                      ),
                      const SizedBox(height: 36),
                      SolidButton(
                        text: "Sign In",
                        textColor: XMColors.light,
                        isLoading: isLoading.value,
                        buttonColor: XMColors.primary,
                        action: () {
                          checkSignInValidation();
                        },
                      ),
                      const SizedBox(height: 25),
                      Align(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () => {
                            Get.offAndToNamed(routes.signUp),
                          },
                          child: richText(
                            "Don't have an account? ",
                            "Create one",
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
