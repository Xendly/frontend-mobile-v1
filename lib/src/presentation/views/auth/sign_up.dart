import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:xendly_mobile/src/core/utilities/helpers/validator_helper.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/config/utilities.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/iconsax_icons.dart';
import 'package:xendly_mobile/src/domain/usecases/auth/signup_usecase.dart';
import 'package:xendly_mobile/src/presentation/view_model/auth/signup_view_model.dart';
import 'package:xendly_mobile/src/presentation/widgets/buttons/solid_button.dart';
import 'package:xendly_mobile/src/presentation/widgets/inputs/xn_text_field.dart';
import 'package:xendly_mobile/src/presentation/widgets/notifications/snackbar.dart';
import 'package:xendly_mobile/src/presentation/widgets/titles/title_one.dart';
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
import 'package:xendly_mobile/src/data/models/wallet_model_old.dart';
import 'package:xendly_mobile/src/data/services/beneficiary_auth.dart';
import 'package:xendly_mobile/src/data/services/public_auth.dart';
import 'package:xendly_mobile/src/data/services/transaction_service.dart';
import 'package:xendly_mobile/src/data/services/user_auth.dart';
import 'package:xendly_mobile/src/data/services/wallet_auth.dart';
import 'package:xendly_mobile/src/presentation/views/verify_email.dart';
import '../../../config/routes.dart' as routes;

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

    // var = Get.put());
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
                  subtitle: "Send and recieve global funds",
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
                      XnTextField(
                        label: "Phone",
                        keyboardType: TextInputType.phone,
                        controller: phoneController,
                        onSaved: (value) => data["phone"] = value!,
                        validator: (value) => validatePhone(value!),
                        prefixText: "+234 ",
                      ),
                      const SizedBox(height: 24),
                      XnTextField(
                        label: "Username",
                        keyboardType: TextInputType.text,
                        controller: usernameController,
                        onSaved: (value) => data["username"] = value!.toLowerCase(),
                        validator: (value) => validateUsername(value!),
                      ),
                      // XnTextField(
                      //   label: "Date of Birth",
                      //   keyboardType: TextInputType.datetime,
                      //   controller: dobController,
                      //   onSaved: (value) => data["dob"] = value!,
                      //   validator: (value) => validateDob(value!),
                      //   readOnly: true,
                      //   onTap: () async {
                      //     DateTime? pickDob = await showDatePicker(
                      //       context: context,
                      //       initialDate: DateTime.now(),
                      //       firstDate: DateTime(
                      //         2000,
                      //       ),
                      //       lastDate: DateTime(2101),
                      //     );

                      //     if (pickDob != null) {
                      //       String formattedDate =
                      //           DateFormat('yyyy-MM-dd').format(pickDob);
                      //       setState(() => dobController.text = formattedDate);
                      //     } else {
                      //       return null;
                      //     }
                      //   },
                      // ),
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
                      const SizedBox(height: 24),
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
                              side: const BorderSide(
                                color: XMColors.shade3,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                text: "I agree to the ",
                                style: textTheme.bodyText1?.copyWith(
                                  color: XMColors.shade2,
                                ),
                                children: [
                                  TextSpan(
                                    text: "Privacy Policy",
                                    style: textTheme.bodyText1?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  TextSpan(
                                    text: " and ",
                                    style: textTheme.bodyText1?.copyWith(
                                      color: XMColors.shade2,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "Terms",
                                    style: textTheme.bodyText1?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 28),
                      XnSolidButton(
                        content: Obx(() {
                          return _signUpController.isLoading.value
                              ? const CupertinoActivityIndicator(
                                  color: XMColors.shade6,
                                )
                              : Text(
                                  "Create Account",
                                  style: textTheme.bodyText1?.copyWith(
                                    color: XMColors.shade6,
                                    fontWeight: FontWeight.w500,
                                  ),
                                );
                        }),
                        backgroundColor: XMColors.primary,
                        action: () => _submit(),
                      ),
                      const SizedBox(height: 26),
                      Align(
                        alignment: Alignment.center,
                        child: Text.rich(
                          TextSpan(
                            text: "Already have an account? ",
                            style: textTheme.bodyText1?.copyWith(
                              color: XMColors.shade2,
                              fontWeight: FontWeight.w500,
                            ),
                            children: [
                              TextSpan(
                                text: "Login",
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Navigator.pushNamed(
                                        context,
                                        routes.signIn,
                                      ),
                                style: textTheme.bodyText1?.copyWith(
                                  color: XMColors.shade0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
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
