import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xendly_mobile/src/core/constants.dart';
import 'package:xendly_mobile/src/core/constants/widget_constants.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/iconsax_icons.dart';
import 'package:xendly_mobile/src/domain/usecases/auth/reset_password_usecase.dart';
import 'package:xendly_mobile/src/presentation/view_model/auth/reset_password_controller.dart';

import '../../core/utilities/helpers/validator_helper.dart';
import '../../theme/app_theme.dart';
import '../widgets/inputs/xn_text_field.dart';
import '../widgets/notifications/snackbar.dart';
import '../widgets/titles/title_one.dart';

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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: Constants.horizontalPadding,
            vertical: 22,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TitleOne(
                title: "Reset Password",
                subtitle: "Enter a new password",
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    XnTextField(
                      label: "Verification Code",
                      keyboardType: TextInputType.number,
                      controller: emailController,
                      onSaved: (value) => {
                        data["token"] = value,
                        data["email"] = Get.parameters["email"],
                      },
                      validator: (value) => validateToken(value!),
                    ),
                    const SizedBox(height: 22),
                    XnTextField(
                      label: "Your New Password",
                      keyboardType: TextInputType.visiblePassword,
                      controller: passwordController,
                      onSaved: (value) => data["password"] = value!,
                      validator: (value) => validatePassword(value!),
                      iconTap: togglePassword,
                      obscureContent: _obscureText ? true : false,
                      icon: _obscureText ? Iconsax.eye : Iconsax.eye_slash,
                      iconColor: XMColors.shade2,
                    ),
                    const SizedBox(height: 26),
                    FilledButton(
                      onPressed: () => _submit(),
                      style: AppButtonTheme.filledButtonStyle,
                      child: Obx(() => _controller.isLoading.value
                          ? const CupertinoActivityIndicator(
                              color: AppColors.white,
                            )
                          : const Text("Proceed")),
                    ),
                    const SizedBox(height: 20),
                    WidgetConstants.backToLogin(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
