import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:xendly_mobile/controller/core/user_auth.dart';
import 'package:xendly_mobile/view/pages/verify_email.dart';
import '../../controller/core/public_auth.dart';
import '../../controller/signup_controller.dart';
import '../../model/country_model.dart';
import '../shared/colors.dart';
import '../shared/widgets.dart';
import '../shared/widgets/custom_checkbox.dart';
import '../shared/widgets/dropdown_input.dart';
import '../shared/widgets/password_input.dart';
import '../shared/widgets/solid_button.dart';
import '../shared/widgets/text_input.dart';
import "../shared/routes.dart" as routes;

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // === FORM VALIDATION === //
  late Future<List<CountryModel>> futureCountry;
  final _publicAuth = PublicAuth();
  CountryModel? countrySelected;

  final _userAuth = Get.put(UserAuth());
  GlobalKey<FormState> formKey = GlobalKey<FormState>(debugLabel: "_signUpKey");

  bool agree = false;

  // === unsorted === //
  bool? value = false;

  bool _obscureText = true;
  void togglePassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;

  @override
  void initState() {
    super.initState();
    futureCountry = _publicAuth.getCountry();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    countryController = TextEditingController();
    phoneController = TextEditingController();
    dobController = TextEditingController();
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
                pageLabel("Create an Account", context),
                const SizedBox(height: 30),
                heading(
                  "Create a new account",
                  XMColors.dark,
                  26,
                  TextAlign.left,
                  FontWeight.w800,
                ),
                const SizedBox(height: 1),
                body(
                  "Get an account in just one minute",
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
                        label: "First Name",
                        hintText: "Johnathan",
                        inputType: TextInputType.name,
                        borderRadius: BorderRadius.circular(10),
                        controller: firstNameController,
                        onSaved: (value) => data["firstName"] = value!,
                        validator: (value) {
                          return validateFirstName(value!);
                        },
                      ),
                      const SizedBox(height: 25),
                      TextInput(
                        readOnly: false,
                        label: "Last Name",
                        hintText: "Percival Smith",
                        inputType: TextInputType.name,
                        borderRadius: BorderRadius.circular(10),
                        controller: lastNameController,
                        onSaved: (value) => data["lastName"] = value!,
                        validator: (value) {
                          return validateLastName(value!);
                        },
                      ),
                      const SizedBox(height: 25),
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
                      FutureBuilder<List<CountryModel>>(
                        future: futureCountry,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return DropdownInput<CountryModel>(
                              label: "Country of Residence",
                              hintText: "Venezuela",
                              borderRadius: BorderRadius.circular(10),
                              items: snapshot.data?.map((country) {
                                return DropdownMenuItem<CountryModel>(
                                  child: body(
                                    "(${country.dialCode}) ${country.country}",
                                    XMColors.primary,
                                    16,
                                  ),
                                  value: country,
                                );
                              }).toList(),
                              action: (CountryModel? value) {
                                setState(() {
                                  countrySelected = value!;
                                });
                              },
                              onSaved: (value) =>
                                  data["country"] = value?.country ?? "",
                              validator: (value) {
                                return validateCountry(value);
                              },
                            );
                          } else if (snapshot.hasError) {
                            return Text("${snapshot.error}");
                          }
                          return const Center(
                            child: CupertinoActivityIndicator(),
                          );
                        },
                      ),
                      const SizedBox(height: 25),
                      TextInput(
                        readOnly: false,
                        label: "Phone Number",
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(
                            left: 17,
                            right: 0,
                          ),
                          child: body(
                            "+${countrySelected?.dialCode ?? ''}",
                            XMColors.gray,
                            16,
                            TextAlign.center,
                            FontWeight.w500,
                          ),
                        ),
                        hintText: "9045637294",
                        inputType: TextInputType.phone,
                        borderRadius: BorderRadius.circular(10),
                        controller: phoneController,
                        onSaved: (value) {
                          printInfo(info: value ?? '');
                          data["phoneNo"] =
                              '+${countrySelected!.dialCode! + value!}';
                        },
                        validator: (value) {
                          return validatePhone(value!);
                        },
                      ),
                      const SizedBox(height: 25),
                      TextInput(
                        label: "Date of Birth",
                        hintText: "30th June 2022",
                        borderRadius: BorderRadius.circular(10),
                        controller: dobController,
                        readOnly: true,
                        onTap: () async {
                          DateTime? pickDob = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(
                              2000,
                            ),
                            lastDate: DateTime(2101),
                          );

                          if (pickDob != null) {
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickDob);
                            setState(
                              () {
                                dobController.text = formattedDate;
                              },
                            );
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) => data["dob"] = value!,
                        validator: (value) {
                          return validateDob(value!);
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
                      const SizedBox(height: 22),
                      // const CustomCheckbox(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 20,
                            height: 25,
                            child: Checkbox(
                              value: agree,
                              onChanged: (bool? agree) {
                                setState(() {
                                  this.agree = agree ?? false;
                                });
                              },
                              activeColor: XMColors.accent,
                              checkColor: XMColors.light,
                              side: const BorderSide(
                                color: XMColors.lightGray,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                          const SizedBox(width: 18),
                          Flexible(
                            child: RichText(
                              text: const TextSpan(
                                text:
                                    "By clicking on Create Account, you agree to our ",
                                style: TextStyle(
                                  fontFamily: "TTFirsNeue",
                                  color: XMColors.gray,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  height: 1.45,
                                ),
                                children: [
                                  TextSpan(
                                    text: "Terms and Conditions ",
                                    style: TextStyle(
                                      fontFamily: "TTFirsNeue",
                                      color: XMColors.primary,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      height: 1.45,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "as well as our ",
                                    style: TextStyle(
                                      fontFamily: "TTFirsNeue",
                                      color: XMColors.gray,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      height: 1.45,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "Privacy Policy",
                                    style: TextStyle(
                                      fontFamily: "TTFirsNeue",
                                      color: XMColors.primary,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      height: 1.45,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 50),
                      Obx(() => SolidButton(
                            text: "Create Account",
                            textColor: XMColors.light,
                            buttonColor: XMColors.primary,
                            isLoading: isLoading.value,
                            action: () {
                              checkSignUpValidation();
                            },
                          )),
                      const SizedBox(height: 25),
                      Align(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () => {
                            Get.offAndToNamed(routes.signIn),
                          },
                          child: richText(
                            "Already have an account? ",
                            "Login",
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

  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController countryController;
  late TextEditingController phoneController;
  late TextEditingController dobController;
  late TextEditingController passwordController;

  RxString controllerEmail = ''.obs;
  final isLoading = false.obs;

  Map<String, dynamic> data = {
    "firstName": "",
    "lastName": "",
    "email": "",
    "country": "",
    "phoneNo": "",
    "dob": "",
    "password": "",
  };

  // === fields validation === //
  String? validateFirstName(String value) {
    final regEx = RegExp(r'^[a-zA-Z-]+$');
    if (GetUtils.isNullOrBlank(value)!) {
      return "Enter your First Name";
    } else if (!regEx.hasMatch(value)) {
      return "Provide a valid First Name";
    } else {
      return null;
    }
  }

  String? validateLastName(String value) {
    final regEx = RegExp(r'^[a-zA-Z-]+$');
    if (GetUtils.isNullOrBlank(value)!) {
      return "Enter your Last Name";
    } else if (!regEx.hasMatch(value)) {
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

  String? validateCountry(dynamic value) {
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
      if (!agree) {
        print("accept our terms and conditions before proceeding");
      } else {
        formKey.currentState!.save();
        isLoading.toggle();
        try {
          final result = await _userAuth.registerUser(data);
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
              const VerifyEmail(),
              arguments: {
                "email": data["email"],
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
  }
}
