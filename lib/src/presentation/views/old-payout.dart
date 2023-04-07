import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as services;
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/config/utilities.dart';
import 'package:xendly_mobile/src/presentation/widgets/widgets.dart';
import 'package:xendly_mobile/src/presentation/widgets/solid_button.dart';
import 'package:xendly_mobile/src/presentation/widgets/text_input.dart';
import 'package:xendly_mobile/src/data/models/bank_model.dart';
import 'package:xendly_mobile/src/data/services/accounts_service.dart';

import 'package:xendly_mobile/src/data/services/misc_service.dart';
import 'package:xendly_mobile/src/data/services/user_auth.dart';

class OldPayout extends StatefulWidget {
  const OldPayout({Key? key}) : super(key: key);
  @override
  State<OldPayout> createState() => _OldPayoutState();
}

class _OldPayoutState extends State<OldPayout> {
  // === FORM VALIDATION === //
  late Future<List<BankModel>> futureBanks;
  // List<BankModel> _banks = [];
  final _accountService = AccountsService();
  final _miscService = MiscService();
  BankModel? bankSelected;
  String? _accountName;

  final _userAuth = Get.put(UserAuth());
  GlobalKey<FormState> formKey =
      GlobalKey<FormState>(debugLabel: "_CreateVirtualAccountKey");

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
    futureBanks = _miscService.getBanks();
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
                pageLabel("Create virtual account", context),
                const SizedBox(height: 24.0),
                // heading(
                //   "Create a new account",
                //   XMColors.dark,
                //   26,
                //   TextAlign.left,
                //   FontWeight.w800,
                // ),
                // const SizedBox(height: 1),
                body(
                  "Setup your payout account in just one minute",
                  XMColors.gray,
                  16,
                  TextAlign.left,
                  FontWeight.w500,
                ),
                // const SizedBox(height: 26),
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 25),
                      // get the list of banks
                      // FutureBuilder<List<BankModel>>(
                      //   future: futureBanks,
                      //   builder: (context, snapshot) {
                      //     if (snapshot.hasData) {
                      //       return DropdownInput<BankModel>(
                      //         label: "Bank",
                      //         hintText: "Select a bank",
                      //         borderRadius: BorderRadius.circular(10),
                      //         items: snapshot.data?.map((bank) {
                      //           return DropdownMenuItem<BankModel>(
                      //             child: body(
                      //               bank.bankName,
                      //               XMColors.primary,
                      //               16,
                      //             ),
                      //             value: bank,
                      //           );
                      //         }).toList(),
                      //         action: (BankModel? value) {
                      //           setState(() {
                      //             bankSelected = value!;
                      //             data["bank_code"] = value.bankCode;
                      //           });
                      //         },
                      //         onSaved: (value) {
                      //           if (value != null) {
                      //             data["bank_code"] = value.bankCode;
                      //             data["bank_name"] = value.bankName;
                      //           }
                      //         },
                      //         validator: (value) {
                      //           return validateCountry(value);
                      //         },
                      //       );
                      //     } else if (snapshot.hasError) {
                      //       return Text("${snapshot.error}");
                      //     }
                      //     return const Center(
                      //       child: CupertinoActivityIndicator(),
                      //     );
                      //   },
                      // ),
                      const SizedBox(height: 25),
                      TextInput(
                        readOnly: false,
                        label: "Account number",
                        hintText: "1234567890",
                        inputType: TextInputType.number,
                        inputFormatters: [
                          services.FilteringTextInputFormatter.digitsOnly
                        ],
                        borderRadius: BorderRadius.circular(10),
                        onChanged: (v) async {
                          if (v != null && v.length > 9) {
                            print(v);
                            try {
                              final result = await _miscService
                                  .resolveAccountNumber(v, data["bank_code"]);
                              print(result);
                              if (result == null) {
                                snackBar(
                                  context,
                                  'We could not resolve account number',
                                );
                              } else {
                                setState(() {
                                  _accountName = result;
                                });
                              }
                            } catch (e) {
                              print(e);
                              snackBar(
                                context,
                                'We could not resolve account number',
                              );
                            }
                          }
                        },
                        controller: emailController,
                        onSaved: (value) => data["account_number"] = value!,
                        validator: (value) {
                          return validatePhone(value!);
                        },
                      ),
                      // TextInput(
                      //   readOnly: false,
                      //   label: "Phone Number",
                      //   prefixIcon: Padding(
                      //     padding: const EdgeInsets.only(
                      //       left: 17,
                      //       right: 0,
                      //     ),
                      //     child: body(
                      //       "+${countrySelected?.dialCode ?? ''}",
                      //       XMColors.gray,
                      //       16,
                      //       TextAlign.center,
                      //       FontWeight.w500,
                      //     ),
                      //   ),
                      //   hintText: "9045637294",
                      //   inputType: TextInputType.phone,
                      //   borderRadius: BorderRadius.circular(10),
                      //   controller: phoneController,
                      //   onSaved: (value) {
                      //     printInfo(info: value ?? '');
                      //     data["phoneNo"] =
                      //         '+${countrySelected!.dialCode! + value!}';
                      //   },
                      //   validator: (value) {
                      //     return validatePhone(value!);
                      //   },
                      // ),
                      if (_accountName != null) ...[
                        const SizedBox(height: 24.0),
                        const Text(
                          'Account name',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            vertical: 12.0,
                            horizontal: 8.0,
                          ),
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                color: XMColors.primary,
                                width: 1.2,
                              ),
                              borderRadius: BorderRadius.circular(
                                10.0,
                              ),
                            ),
                          ),
                          child: Text(
                            _accountName!,
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                      const SizedBox(height: 24.0),
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
                                    "By clicking on Create Payout Account, you agree that we should create a payout account for you",
                                style: TextStyle(
                                  fontFamily: "TTFirsNeue",
                                  color: XMColors.gray,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  height: 1.45,
                                ),
                                children: [
                                  // TextSpan(
                                  //   text: "Terms and Conditions ",
                                  //   style: TextStyle(
                                  //     fontFamily: "TTFirsNeue",
                                  //     color: XMColors.primary,
                                  //     fontSize: 14,
                                  //     fontWeight: FontWeight.w500,
                                  //     height: 1.45,
                                  //   ),
                                  // ),
                                  // TextSpan(
                                  //   text: "as well as our ",
                                  //   style: TextStyle(
                                  //     fontFamily: "TTFirsNeue",
                                  //     color: XMColors.gray,
                                  //     fontSize: 14,
                                  //     fontWeight: FontWeight.w500,
                                  //     height: 1.45,
                                  //   ),
                                  // ),
                                  // TextSpan(
                                  //   text: "Privacy Policy",
                                  //   style: TextStyle(
                                  //     fontFamily: "TTFirsNeue",
                                  //     color: XMColors.primary,
                                  //     fontSize: 14,
                                  //     fontWeight: FontWeight.w500,
                                  //     height: 1.45,
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 50),
                      Obx(
                        () => SolidButton(
                          text: "Create Payout Account",
                          textColor: XMColors.light,
                          buttonColor: XMColors.primary,
                          isLoading: isLoading.value,
                          action: () {
                            checkCreateVirtualAccountValidation();
                          },
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
    "account_name": "",
    "account_number": "",
    "bank_name": "",
    "bank_code": "",
    "currency": "NGN"
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
  void checkCreateVirtualAccountValidation() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      printInfo(info: "Some fields are not valid");
    } else {
      if (!agree) {
        Get.closeAllSnackbars();
        Get.snackbar(
          "Request failed",
          "accept our terms and conditions before proceeding",
          backgroundColor: XMColors.red,
          colorText: XMColors.light,
          duration: const Duration(seconds: 5),
        );
        print("accept our terms and conditions before proceeding");
      } else {
        formKey.currentState!.save();
        isLoading.toggle();
        try {
          final result = await _accountService.createPayoutAccount({
            ...data,
            'account_name': _accountName,
          });
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
            Navigator.pop(context);
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
