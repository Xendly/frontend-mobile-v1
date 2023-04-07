import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/config/utilities.dart';
import 'package:xendly_mobile/src/presentation/widgets/widgets.dart';
import 'package:xendly_mobile/src/presentation/widgets/widgets.dart';
import 'package:xendly_mobile/src/presentation/widgets/bottomSheet.dart';
import 'package:xendly_mobile/src/presentation/widgets/buttons/rounded.dart';
import 'package:xendly_mobile/src/presentation/widgets/dropdown_input.dart';
import 'package:xendly_mobile/src/presentation/widgets/micro_list_item.dart';
import 'package:xendly_mobile/src/presentation/widgets/page_title.dart';
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
import '../../config/routes.dart' as routes;

class PersonalSecurity extends StatefulWidget {
  const PersonalSecurity({Key? key}) : super(key: key);
  @override
  State<PersonalSecurity> createState() => _PersonalSecurityState();
}

class _PersonalSecurityState extends State<PersonalSecurity> {
  // === HIDE/SHOW PASSWORD === //
  bool _obscureText = true;
  void togglePassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  // === CONTROLLER === //
  final _userAuth = Get.put(UserAuth());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController? oldPinController = TextEditingController();
  TextEditingController? pinController = TextEditingController();

  Map<String, dynamic> updatePinData = {
    "old_pin": "",
    "pin": "",
  };

  TextEditingController? passwordController = TextEditingController();
  TextEditingController? newPinController = TextEditingController();
  Map<String, dynamic> resetPinData = {
    "password": "",
    "pin": "",
  };

  void onInit() {
    super.initState();
    oldPinController;
    pinController;

    passwordController;
    newPinController;
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

  String? validatePIN(String value) {
    if (GetUtils.isNullOrBlank(value)!) {
      return "Enter your Transaction PIN";
    } else if (GetUtils.isLengthLessThan(value, 3)) {
      return "PIN must contain 4 characters";
    } else if (GetUtils.isLengthGreaterThan(value, 4)) {
      return "PIN must contain 4 characters";
    } else if (!GetUtils.isNumericOnly(value)) {
      return "PIN must contain only digits";
    } else {
      return null;
    }
  }

  void checkUpdatePinValidation() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      printInfo(info: "some fields are invalid");
    } else {
      printInfo(info: "all fields are valid");
      formKey.currentState!.save();
      try {
        final result = await _userAuth.updatePIN(updatePinData);
        if (result["statusCode"] == 200) {
          printInfo(info: "${result["statusCode"]}");
          Get.snackbar(
            result["status"],
            result["message"],
            backgroundColor: Colors.green,
            colorText: XMColors.light,
            duration: const Duration(seconds: 5),
          );
          return Get.back();
        } else {
          printInfo(info: "${result["message"]}, ${result["statusCode"]}");
          if (result["message"] != null || result["status"] != "failed") {
            Get.closeAllSnackbars();
            printInfo(info: "${result["message"]}");
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
        Get.snackbar("Error", "Unknown Error Occured, Try Again!");
        return printInfo(
          info: "Unknown Error Occured, Try Again!",
        );
      }
    }
  }

  void checkResetPinValidation() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      printInfo(info: "some fields are invalid");
    } else {
      printInfo(info: "all fields are valid");
      formKey.currentState!.save();
      try {
        final result = await _userAuth.resetPin(resetPinData);
        if (result["statusCode"] == 200) {
          printInfo(info: "${result["statusCode"]}");
          Get.snackbar(
            result["status"],
            result["message"],
            backgroundColor: Colors.green,
            colorText: XMColors.light,
            duration: const Duration(seconds: 5),
          );
          return Get.back();
        } else {
          printInfo(info: "${result["message"]}, ${result["statusCode"]}");
          if (result["message"] != null || result["status"] != "failed") {
            Get.closeAllSnackbars();
            printInfo(info: "${result["message"]}");
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
        Get.snackbar("Error", "Unknown Error Occured, Try Again!");
        return printInfo(
          info: "Unknown Error Occured, Try Again!",
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const _divider = Divider(
      height: 0,
      color: XMColors.gray_70,
      thickness: 1.35,
    );

    return Scaffold(
      backgroundColor: XMColors.light,
      extendBody: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // === TITLE SECTION === //
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: PageTitleIcons(
                    prefixIcon: "assets/icons/bold/icl-arrow-left-2.svg",
                    title: "Personal Security",
                    prefixIconColor: XMColors.dark,
                    prefixIconAction: () => Get.back(),
                  ),
                ),

                // === PASSWORD SECTION === //
                Padding(
                  padding: const EdgeInsets.fromLTRB(18, 45, 18, 0),
                  child: Text(
                    "Password Settings",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: XMColors.gray,
                        ),
                  ),
                ),
                const SizedBox(height: 18),
                _divider,
                const MicroListItem(title: "Update Account Password"),
                _divider,
                const MicroListItem(title: "Reset Account Password"),
                _divider,

                // === TRANSACTION PIN SECTION === //
                Padding(
                  padding: const EdgeInsets.fromLTRB(18, 45, 18, 0),
                  child: Text(
                    "Transaction PIN Settings",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: XMColors.gray,
                        ),
                  ),
                ),
                const SizedBox(height: 18),
                _divider,
                MicroListItem(
                  title: "Update Transaction PIN",
                  action: () => {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          alignment: WrapAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 38,
                              ),
                              child: Form(
                                key: formKey,
                                child: Column(
                                  children: [
                                    Text(
                                      "Update Transaction PIN",
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1!
                                          .copyWith(
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      "Ensure account security by changing your\ntransaction pin every 6 months",
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            color: XMColors.gray,
                                          ),
                                    ),
                                    const SizedBox(height: 26),
                                    PasswordInput(
                                      label: "Enter Old PIN",
                                      hintText: "Old Security PIN",
                                      suffixIcon: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 17),
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
                                      controller: oldPinController,
                                      onSaved: (value) =>
                                          updatePinData["old_pin"] = value!,
                                      validator: (value) {
                                        return validatePIN(value!);
                                      },
                                    ),
                                    const SizedBox(height: 18),
                                    PasswordInput(
                                      label: "Enter New PIN",
                                      hintText: "New Security PIN",
                                      suffixIcon: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 17),
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
                                      controller: pinController,
                                      onSaved: (value) =>
                                          updatePinData["pin"] = value!,
                                      validator: (value) {
                                        return validatePIN(value!);
                                      },
                                    ),
                                    const SizedBox(height: 26),
                                    SolidButton(
                                      text: "Create Account",
                                      textColor: XMColors.light,
                                      buttonColor: XMColors.primary,
                                      action: () {
                                        checkUpdatePinValidation();
                                      },
                                    ),
                                    const SizedBox(height: 28),
                                    GestureDetector(
                                      onTap: () => Get.back(),
                                      child: Text(
                                        "Cancel",
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                              color: XMColors.primary,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  },
                ),
                _divider,
                MicroListItem(
                  title: "Reset Transaction PIN",
                  action: () => {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (BuildContext context) {
                        return Padding(
                          padding: MediaQuery.of(context).viewInsets,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 38,
                            ),
                            child: Form(
                              key: formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Reset Security PIN",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1!
                                        .copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    "Ensure account security by changing your\ntransaction pin every 6 months",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          color: XMColors.gray,
                                        ),
                                  ),
                                  const SizedBox(height: 26),
                                  PasswordInput(
                                    label: "Enter Password",
                                    hintText: "Account Password",
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
                                    controller: passwordController,
                                    onSaved: (value) =>
                                        resetPinData["password"] = value!,
                                    validator: (value) {
                                      return validatePassword(value!);
                                    },
                                  ),
                                  const SizedBox(height: 18),
                                  PasswordInput(
                                    label: "Enter New PIN",
                                    hintText: "New Security PIN",
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
                                    controller: newPinController,
                                    onSaved: (value) =>
                                        resetPinData["pin"] = value!,
                                    validator: (value) {
                                      return validatePIN(value!);
                                    },
                                  ),
                                  const SizedBox(height: 26),
                                  SolidButton(
                                    text: "Reset PIN",
                                    textColor: XMColors.light,
                                    buttonColor: XMColors.primary,
                                    action: () {
                                      checkResetPinValidation();
                                    },
                                  ),
                                  const SizedBox(height: 28),
                                  GestureDetector(
                                    onTap: () => Get.back(),
                                    child: Text(
                                      "Cancel",
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            color: XMColors.primary,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                        //   ],
                        // );
                      },
                    ),
                  },
                ),
                _divider,
                const MicroListItem(title: "Remove Transaction PIN"),
                _divider,

                // === ACCOUNTS SECTION === //
                Padding(
                  padding: const EdgeInsets.fromLTRB(18, 45, 18, 0),
                  child: Text(
                    "Accounts",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: XMColors.gray,
                        ),
                  ),
                ),
                const SizedBox(height: 18),
                _divider,
                MicroListItem(
                  title: "Account Limits",
                  action: () => Get.toNamed(
                    routes.accountLimits,
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
