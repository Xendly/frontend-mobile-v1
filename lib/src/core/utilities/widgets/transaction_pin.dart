// import 'package:flutter/material.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
//
// import '../../../presentation/widgets/title_bar.dart';
// import '../../../presentation/widgets/titles/title_one.dart';
// import '../interfaces/colors.dart';
//
// class MyDialog {
//   static Future<void> show(BuildContext context, String message) async {
//     return showDialog<void>(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         final textTheme = Theme.of(context).textTheme;
//
//         return Scaffold(
//           extendBody: true,
//           backgroundColor: XMColors.light,
//           body: SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   const TitleBar(
//                     title: "Transaction Pin",
//                   ),
//                   Form(
//                     child: PinCodeTextField(
//                       length: 4,
//                       appContext: context,
//                       textStyle: textTheme.headline6?.copyWith(
//                         color: XMColors.shade1,
//                       ),
//                       cursorColor: XMColors.primary,
//                       cursorHeight: 17,
//                       controller: pinController,
//                       onSaved: (value) => data["pin"] = value,
//                       validator: (value) => validatePin(value!),
//                       pinTheme: PinTheme(
//                         shape: PinCodeFieldShape.box,
//                         borderRadius: BorderRadius.circular(8),
//                         fieldWidth: 80,
//                         fieldHeight: 56,
//                         activeColor: XMColors.shade4,
//                         selectedColor: XMColors.primary,
//                         inactiveColor: XMColors.shade4,
//                         activeFillColor: XMColors.shade6,
//                         selectedFillColor: XMColors.shade6,
//                       ),
//                       enablePinAutofill: true,
//                       keyboardType: TextInputType.number,
//                       onChanged: (String value) {},
//                     ),
//                   ),
//                   const SizedBox(height: 22),
//                   XnSolidButton(
//                     content: Obx(() {
//                       return verifyPinController.isLoading.value
//                           ? const CupertinoActivityIndicator(
//                               color: XMColors.shade6,
//                             )
//                           : Text(
//                               "Continue",
//                               style: textTheme.bodyText1?.copyWith(
//                                 color: XMColors.shade6,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             );
//                     }),
//                     backgroundColor: XMColors.primary,
//                     action: () => _submit(),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
