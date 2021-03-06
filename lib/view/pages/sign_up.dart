import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:xendly_mobile/controller/core/public_auth.dart';
import 'package:xendly_mobile/controller/signup_controller.dart';
import 'package:xendly_mobile/model/country_model.dart';
import 'package:xendly_mobile/view/shared/colors.dart';
import 'package:xendly_mobile/view/shared/widgets.dart';
import 'package:xendly_mobile/view/shared/widgets/custom_checkbox.dart';
import 'package:xendly_mobile/view/shared/widgets/dropdown_input.dart';
import 'package:xendly_mobile/view/shared/widgets/password_input.dart';
import 'package:xendly_mobile/view/shared/widgets/solid_button.dart';
import 'package:xendly_mobile/view/shared/widgets/text_input.dart';
import "package:xendly_mobile/view/shared/routes.dart" as routes;

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // === FORM VALIDATION === //
  var signUpController = Get.put(SignUpController());
  late Future<List<CountryModel>> futureCountry;
  final _publicAuth = PublicAuth();
  String countrySelected = "";

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
    // countrySelected = "";
  }

  @override
  void dispose() {
    super.dispose();
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
                  key: signUpController.formKey,
                  child: Column(
                    children: [
                      TextInput(
                        readOnly: false,
                        label: "First Name",
                        hintText: "Johnathan",
                        inputType: TextInputType.name,
                        borderRadius: BorderRadius.circular(10),
                        controller: signUpController.firstNameController,
                        onSaved: (value) =>
                            signUpController.data["firstName"] = value!,
                        validator: (value) {
                          return signUpController.validateFirstName(value!);
                        },
                      ),
                      const SizedBox(height: 25),
                      TextInput(
                        readOnly: false,
                        label: "Last Name",
                        hintText: "Percival Smith",
                        inputType: TextInputType.name,
                        borderRadius: BorderRadius.circular(10),
                        controller: signUpController.lastNameController,
                        onSaved: (value) =>
                            signUpController.data["lastName"] = value!,
                        validator: (value) {
                          return signUpController.validateLastName(value!);
                        },
                      ),
                      const SizedBox(height: 25),
                      TextInput(
                        readOnly: false,
                        label: "Email",
                        hintText: "johnpsmith@gmail.com",
                        inputType: TextInputType.emailAddress,
                        borderRadius: BorderRadius.circular(10),
                        controller: signUpController.emailController,
                        onSaved: (value) =>
                            signUpController.data["email"] = value!,
                        validator: (value) {
                          return signUpController.validateEmail(value!);
                        },
                      ),
                      const SizedBox(height: 25),
                      FutureBuilder<List>(
                        future: futureCountry,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return DropdownInput(
                              label: "Country of Residence",
                              hintText: "Venezuela",
                              borderRadius: BorderRadius.circular(10),
                              items: snapshot.data?.map((country) {
                                return DropdownMenuItem<String>(
                                  child: body(
                                    "(${country.dialCode}) ${country.country}",
                                    XMColors.primary,
                                    16,
                                  ),
                                  value: "${country.shortCode}",
                                );
                              }).toList(),
                              action: (String? value) {
                                setState(() {
                                  countrySelected = value!;
                                });
                              },
                              onSaved: (value) =>
                                  signUpController.data["country"] = value,
                              validator: (value) {
                                return signUpController.validateCountry(value);
                              },
                            );
                          } else if (snapshot.hasError) {
                            return Text("${snapshot.error}");
                          }
                          return const Center(child: Text("Loading..."));
                          // print("snapshot => ${snapshot.data![0]}");
                          // if (snapshot.connectionState ==
                          //     ConnectionState.waiting) {
                          //   const Text("Loading...");
                          // }
                          // return Text("${snapshot.data![0]}");
                          // else if (snapshot.connectionState ==
                          //     ConnectionState.done) {
                          //   return const Text("Load Done");
                          // } else {
                          //   return const Text("Random");
                          // }
                          // return const Text("Random 2");

                          // if (snapshot.hasData) {
                          //   return DropdownInput(
                          //     label: "Country of Residence",
                          //     hintText: "Venezuela",
                          //     borderRadius: BorderRadius.circular(10),
                          //     items: snapshot.data!.map((country) {
                          //       return DropdownMenuItem<String>(
                          //         child: body(
                          //           "[${country.dialCode}] ${country.country}",
                          //           XMColors.primary,
                          //           16,
                          //         ),
                          //         value:
                          //             "${country.country} ${country.dialCode} ${country.shortCode}",
                          //       );
                          //     }).toList(),
                          //     action: (String? newValue) {
                          //       setState(() {
                          //         country = newValue!;
                          //       });
                          //     },
                          //     onSaved: (value) =>
                          //         signUpController.data["country"] = value,
                          //     validator: (value) {
                          //       return signUpController.validateCountry(value);
                          //     },
                          //   );
                          // } else if (snapshot.hasError) {
                          //   return Text("${snapshot.error}");
                          // }
                          // return const Text("Loading...");
                          // return Center(child: CircularProgressIndicator());
                        },
                      ),

                      // DropdownInput(
                      //   label: "Country of Residence",
                      //   hintText: "Venezuela",
                      //   borderRadius: BorderRadius.circular(10),
                      //   items: country,
                      //   action: (String? newValue) {
                      //     setState(() {
                      //       country = newValue!;
                      //     });
                      //   },
                      //   onSaved: (value) =>
                      //       signUpController.data["country"] = value,
                      //   validator: (value) {
                      //     return signUpController.validateCountry(value);
                      //   },
                      // ),
                      const SizedBox(height: 25),
                      TextInput(
                        readOnly: false,
                        label: "Phone Number",
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(
                            left: 17,
                            right: 0,
                          ),
                          // child:
                          //     // "$selectedCountryCode",
                          //     FutureBuilder(
                          //   future: futureCountry,
                          //   builder: (context, snapshot) {
                          //     if (snapshot.hasData) {
                          //       return
                          child: body(
                            // "${country.country}",
                            // "${snapshot.data[0].dialCode}",
                            "$countrySelected ",
                            XMColors.gray,
                            16,
                            TextAlign.center,
                            FontWeight.w500,
                          ),
                          //       }
                          //       return const Text("Loading...");
                          //     },
                          //   ),
                        ),
                        hintText: "9045637294",
                        inputType: TextInputType.phone,
                        borderRadius: BorderRadius.circular(10),
                        controller: signUpController.phoneController,
                        onSaved: (value) =>
                            signUpController.data["phoneNo"] = value!,
                        validator: (value) {
                          return signUpController.validatePhone(value!);
                        },
                      ),
                      const SizedBox(height: 25),
                      TextInput(
                        label: "Date of Birth",
                        hintText: "30th June 2022",
                        borderRadius: BorderRadius.circular(10),
                        controller: signUpController.dobController,
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
                                signUpController.dobController.text =
                                    formattedDate;
                              },
                            );
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) =>
                            signUpController.data["dob"] = value!,
                        validator: (value) {
                          return signUpController.validateDob(value!);
                        },
                      ),
                      const SizedBox(height: 25),
                      PasswordInput(
                        label: "Password for Security",
                        hintText: "*******",
                        controller: signUpController.passwordController,
                        onSaved: (value) =>
                            signUpController.data["password"] = value!,
                        validator: (value) {
                          return signUpController.validatePassword(value!);
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
                      const CustomCheckbox(),
                      const SizedBox(height: 50),
                      SolidButton(
                        text: "Create Account",
                        textColor: XMColors.light,
                        buttonColor: XMColors.primary,
                        action: () {
                          signUpController.checkSignUpValidation();
                        },
                      ),
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
}
