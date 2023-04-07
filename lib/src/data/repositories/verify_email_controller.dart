// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
// import 'package:xendly_mobile/src/data/services/auth_service.dart';
// import 'package:xendly_mobile/src/data/services/user_auth.dart';
// import '../../config/routes.dart' as routes;

// class VerifyEmailController extends GetxController {
//   final _userAuth = Get.put(AuthService());
//   GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   var tokenController = TextEditingController();

//   final isLoading = false.obs;

//   Map<String, dynamic> data = {
//     "token": "",
//   };

//   @override
//   void onInit() {
//     super.onInit();
//     tokenController;
//   }

//   // === fields validation === //
//   String? validateTokenCode(String value) {
//     if (GetUtils.isNullOrBlank(value)!) {
//       return "Fill in your six digit code";
//     } else if (!GetUtils.isNumericOnly(value)) {
//       return "Provide a valid six digit code";
//     } else if (GetUtils.isLengthLessThan(value, 6)) {
//       return "Fill in all the fields, idiot!";
//     }
//   }

//   // === CHECK THE WHOLE VALIDATION === //
//   void checkTokenValidation() async {
//     final isValid = formKey.currentState!.validate();
//     if (!isValid) {
//       printInfo(info: "code not verified");
//     } else {
//       formKey.currentState!.save();
//       isLoading.toggle();
//       printInfo(info: "code verified - token => ${data['token']}}");
//       try {
//         final result = await _userAuth.verifyEmail(data);
//         isLoading.toggle();
//         if (result['statusCode'] == 200 || result["statusCode"] == 201) {
//           printInfo(
//             info: ">>> ${result['message']} <<<",
//           );
//           Get.snackbar(
//             result["status"],
//             result["message"],
//             backgroundColor: Colors.green,
//             colorText: XMColors.light,
//             duration: const Duration(seconds: 5),
//           );
//           return Get.toNamed(
//             routes.signIn,
//           );
//         } else {
//           printInfo(
//             info: ">>> ${result['message']} <<<",
//           );
//           Get.snackbar(
//             result["status"],
//             result["message"],
//             backgroundColor: Colors.red,
//             colorText: XMColors.light,
//             duration: const Duration(seconds: 5),
//           );
//         }
//       } catch (error) {
//         Get.snackbar("Error", "Unknown Error Occured, Try Again!");
//         return printInfo(
//           info: "Unknown Error Occured, Try Again! - $error",
//         );
//       }
//     }
//   }

//   void resendOtp(dynamic email) async {
//     if (isLoading.value) return;
//     Get.dialog(
//       const AlertDialog(
//         title: Center(
//             child: CircularProgressIndicator(
//           valueColor: AlwaysStoppedAnimation(XMColors.primary),
//         )),
//       ),
//       barrierDismissible: false,
//     );
//     printInfo(info: "code verified - token => ${data['token']}}, $email");
//     try {
//       final result = await _userAuth.resendOtp(email);
//       Get.back();
//       if (result['statusCode'] == 200) {
//         printInfo(
//           info:
//               ">>> Your code is either invalid or expired <<< >>> ${result['message']} <<<",
//         );
//         Get.snackbar("Success", "O.T.P. has been resent");
//       } else {
//         Get.snackbar("Error occured", result['message']);
//       }
//     } catch (error) {
//       Get.back();
//       Get.snackbar("Error", "Unknown Error Occured, Try Again!");
//       return printInfo(
//         info: "Unknown Error Occured, Try Again! - $error",
//       );
//     }
//   }
// }
