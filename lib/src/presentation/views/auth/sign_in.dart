import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xendly_mobile/src/domain/usecases/auth/login_usecase.dart';
import 'package:xendly_mobile/src/presentation/view_model/auth/login_view_model.dart';
import 'package:xendly_mobile/src/presentation/widgets/inputs/xn_text_field.dart';
import 'package:xendly_mobile/src/presentation/widgets/titles/title_one.dart';
import 'package:xendly_mobile/src/theme/app_theme.dart';

import '../../../config/routes.dart' as routes;
import '../../../core/utilities/helpers/validator_helper.dart';
import '../../../core/utilities/interfaces/colors.dart';
import '../../../core/utilities/interfaces/iconsax_icons.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final formKey = GlobalKey<FormState>(debugLabel: "login");
  TextEditingController? emailController, passwordController;

  final LoginViewModel loginController = Get.put(
    LoginViewModel(
      Get.find<LoginUseCase>(),
    ),
  );

  bool _obscurePassword = true;
  void togglePassword() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  Map<String, dynamic> data = {
    "email": "",
    "password": "",
  };

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  void _submit() async {
    final isValid = formKey.currentState!.validate();
    if (isValid) {
      formKey.currentState!.save();
      try {
        loginController.userLogin(data);
      } catch (error) {
        Get.snackbar("An error occurred", error.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 22,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // page title
              const TitleOne(
                title: "Welcome back",
                subtitle: "Login your Xendly account",
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    // email field
                    XnTextField(
                      label: "Email",
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      onSaved: (value) => data["email"] = value!,
                      validator: (value) => validateEmail(value!),
                    ),
                    const SizedBox(height: 22),
                    // password field
                    XnTextField(
                      label: "Password",
                      keyboardType: TextInputType.visiblePassword,
                      controller: passwordController,
                      onSaved: (value) => data["password"] = value!,
                      validator: (value) => validatePassword(value!),
                      iconTap: togglePassword,
                      obscureContent: _obscurePassword ? true : false,
                      icon: _obscurePassword ? Iconsax.eye : Iconsax.eye_slash,
                      iconColor: XMColors.shade2,
                    ),
                    const SizedBox(height: 26),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () => {
                          Navigator.pushNamed(
                            context,
                            routes.forgotPassword,
                          ),
                        },
                        child: Text(
                          "Forgot Password?",
                          style: textTheme.bodyMedium?.copyWith(
                            color: XMColors.primary0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 38),
                    FilledButton(
                      onPressed: () => _submit(),
                      style: AppButtonTheme.filledButtonStyle,
                      child: Obx(() => loginController.isLoading.value
                          ? const CupertinoActivityIndicator(
                              color: AppColors.white,
                            )
                          : const Text("Sign In")),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: textTheme.bodyMedium?.copyWith(
                            color: XMColors.shade1,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(
                            context,
                            routes.signUp,
                          ),
                          child: Text(
                            "Create account",
                            style: textTheme.bodyMedium?.copyWith(
                              color: XMColors.primary0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
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
