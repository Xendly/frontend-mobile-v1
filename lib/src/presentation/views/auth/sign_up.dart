import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:xendly_mobile/src/core/utilities/helpers/validator_helper.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/iconsax_icons.dart';
import 'package:xendly_mobile/src/data/models/country_model.dart';
import 'package:xendly_mobile/src/data/services/public_auth.dart';
import 'package:xendly_mobile/src/data/services/user_auth.dart';
import 'package:xendly_mobile/src/domain/usecases/auth/signup_usecase.dart';
import 'package:xendly_mobile/src/presentation/view_model/auth/signup_view_model.dart';
import 'package:xendly_mobile/src/presentation/widgets/inputs/xn_text_field.dart';
import 'package:xendly_mobile/src/presentation/widgets/notifications/snackbar.dart';
import 'package:xendly_mobile/src/presentation/widgets/titles/title_one.dart';

import '../../../config/routes.dart' as routes;
import '../../../theme/app_theme.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final SignUpViewModel _signUpController = Get.put(
    SignUpViewModel(
      Get.find<SignUpUseCase>(),
    ),
  );

  bool _obscurePassword = true;
  void togglePassword() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  // === FORM VALIDATION === //
  late Future<List<CountryModel>> futureCountry;
  final _publicAuth = PublicAuth();
  CountryModel? countrySelected;

  final _userAuth = Get.put(UserAuth());
  GlobalKey<FormState> formKey = GlobalKey<FormState>(debugLabel: "_signUpKey");

  bool agree = false;

  // === unsorted === //
  bool? value = false;

  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    emailController.addListener(() {
      controllerEmail.value = emailController.text;
    });
  }

  @override
  void dispose() {
    super.dispose();
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
                const TitleOne(
                  title: "Create an account",
                  subtitle: "Send and receive money quickly",
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      XnTextField(
                        label: "Firstname",
                        keyboardType: TextInputType.name,
                        controller: firstNameController,
                        onSaved: (value) => data["first_name"] = value!,
                        validator: (value) => validateFirstName(value!),
                      ),
                      const SizedBox(height: 24),
                      XnTextField(
                        label: "Lastname",
                        keyboardType: TextInputType.name,
                        controller: lastNameController,
                        onSaved: (value) => data["last_name"] = value!,
                        validator: (value) => validateLastName(value!),
                      ),
                      const SizedBox(height: 24),
                      XnTextField(
                        label: "Email",
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        onSaved: (value) => data["email"] = value!,
                        validator: (value) => validateEmail(value!),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Container(
                            height: 58,
                            width: 76,
                            decoration: BoxDecoration(
                              color: XMColors.shade5,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: XMColors.shade4,
                                width: 1.24,
                                strokeAlign: BorderSide.strokeAlignCenter,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "+234",
                                textAlign: TextAlign.center,
                                style:
                                    AppTextTheme.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: XMColors.shade1,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            flex: 3,
                            child: XnTextField(
                              label: "Phone",
                              keyboardType: TextInputType.phone,
                              controller: phoneController,
                              onSaved: (value) => data["phone"] = value!,
                              validator: (value) => validatePhone(value!),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      XnTextField(
                        label: "Username",
                        keyboardType: TextInputType.text,
                        controller: usernameController,
                        onSaved: (value) =>
                            data["username"] = value!.toLowerCase(),
                        validator: (value) => validateUsername(value!),
                      ),
                      const SizedBox(height: 24),
                      XnTextField(
                        label: "Password",
                        keyboardType: TextInputType.visiblePassword,
                        controller: passwordController,
                        onSaved: (value) => data["password"] = value!,
                        validator: (value) => validatePassword(value!),
                        iconTap: togglePassword,
                        obscureContent: _obscurePassword ? true : false,
                        icon:
                            _obscurePassword ? Iconsax.eye : Iconsax.eye_slash,
                        iconColor: XMColors.shade2,
                      ),
                      const SizedBox(height: 28),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            margin: const EdgeInsets.only(top: 2),
                            child: Checkbox(
                              value: agree,
                              onChanged: (bool? agree) {
                                setState(() {
                                  this.agree = agree ?? false;
                                });
                              },
                              activeColor: XMColors.shade0,
                              checkColor: XMColors.shade6,
                              side: const BorderSide(color: XMColors.shade3),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "I agree to Xendly's terms and conditions",
                                style: textTheme.bodyMedium?.copyWith(
                                  color: XMColors.shade1,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 28),
                      FilledButton(
                        onPressed: () => _submit(),
                        style: AppButtonTheme.filledButtonStyle,
                        child: Obx(() => _signUpController.isLoading.value
                            ? const CupertinoActivityIndicator(
                                color: AppColors.white,
                              )
                            : const Text("Create Account")),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Have an account?",
                            style: textTheme.bodyMedium?.copyWith(
                              color: XMColors.shade1,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pushNamed(
                              context,
                              routes.signIn,
                            ),
                            child: Text(
                              "Sign In",
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
      ),
    );
  }

  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController dobController;
  late TextEditingController usernameController;
  late TextEditingController passwordController;

  RxString controllerEmail = ''.obs;
  final isLoading = false.obs;

  Map<String, dynamic> data = {
    "first_name": "",
    "last_name": "",
    "email": "",
    "phone": "",
    "username": "",
    "password": "",
  };

  void _submit() async {
    final isValid = formKey.currentState!.validate();
    if (isValid) {
      if (!agree) {
        xnSnack(
          "Privacy error",
          "Please accept the privacy policy",
          XMColors.error0,
          Iconsax.info_circle,
        );
      } else {
        formKey.currentState!.save();
        try {
          await _signUpController.signUp(data);
        } catch (error) {
          xnSnack(
            "An error occurred",
            error.toString(),
            XMColors.error0,
            Iconsax.close_circle,
          );
        }
      }
    }
  }
}
