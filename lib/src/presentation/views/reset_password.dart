import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/domain/usecases/auth/reset_password_usecase.dart';
import 'package:xendly_mobile/src/presentation/view_model/auth/reset_password_controller.dart';
import 'package:xendly_mobile/src/presentation/widgets/password_input.dart';
import 'package:xendly_mobile/src/presentation/widgets/text_input.dart';
import 'package:xendly_mobile/src/presentation/widgets/widgets.dart';

import '../../core/utilities/helpers/validator_helper.dart';
import '../widgets/notifications/snackbar.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);
  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final formKey = GlobalKey<FormState>(debugLabel: "reset_password");

  bool _obscureText = true;
  void togglePassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  TextEditingController? emailController = TextEditingController();
  TextEditingController? passwordController = TextEditingController();

  final _controller = Get.put(
    ResetPasswordController(Get.find<ResetPasswordUsecase>()),
  );

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

  void _submit() async {
    final isValid = formKey.currentState!;
    if (isValid.validate()) {
      formKey.currentState!.save();
      try {
        _controller.resetPassword(data);
      } catch (e) {
        xnSnack(
          "An error occurred",
          e.toString(),
          XMColors.error1,
          Icons.close,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

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
                          data["email"] = Get.parameters["email"],
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
                      ElevatedButton(
                        onPressed: () => _submit(),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.only(bottom: 2),
                          fixedSize: const Size(0, 64),
                        ),
                        child: Obx(
                          () {
                            return _controller.isLoading.value
                                ? const CupertinoActivityIndicator(
                                    color: XMColors.shade6,
                                  )
                                : Text(
                                    "Confirm Reset",
                                    style: textTheme.bodyLarge
                                        ?.copyWith(color: XMColors.shade6),
                                  );
                          },
                        ),
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
