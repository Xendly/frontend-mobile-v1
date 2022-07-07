import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:xendly_mobile/controller/signin_controller.dart';
import 'package:xendly_mobile/view/pages/sign_up.dart';
import 'package:xendly_mobile/view/shared/colors.dart';
import 'package:xendly_mobile/view/shared/widgets.dart';
import 'package:xendly_mobile/view/shared/widgets/custom_checkbox.dart';
import 'package:xendly_mobile/view/shared/widgets/password_input.dart';
import 'package:xendly_mobile/view/shared/widgets/solid_button.dart';
import 'package:xendly_mobile/view/shared/widgets/text_input.dart';
import "package:xendly_mobile/view/shared/routes.dart" as routes;

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // === form validation === //
  var signInController = Get.put(SignInController());

  // === hide password === //
  bool _obscureText = true;
  void togglePassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
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
                  key: signInController.signInFormKey,
                  child: Column(
                    children: [
                      TextInput(
                        readOnly: false,
                        label: "Email",
                        hintText: "johnpsmith@gmail.com",
                        inputType: TextInputType.emailAddress,
                        borderRadius: BorderRadius.circular(10),
                        controller: signInController.emailController,
                        onSaved: (value) =>
                            signInController.signInData["email"] = value!,
                        validator: (value) {
                          return signInController.validateEmail(value!);
                        },
                      ),
                      const SizedBox(height: 25),
                      PasswordInput(
                        label: "Password",
                        hintText: "*******",
                        controller: signInController.passwordController,
                        onSaved: (value) =>
                            signInController.signInData["password"] = value!,
                        validator: (value) {
                          return signInController.validatePassword(value!);
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
                        buttonColor: XMColors.primary,
                        action: () {
                          signInController.checkSignInValidation();
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
