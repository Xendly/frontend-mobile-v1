// import 'dart:io';

// import 'package:flutter/material.dart'
//     show
//         ScaffoldMessenger,
//         SizedBox,
//         Text,
//         BuildContext,
//         SnackBar,
//         debugPrint,
//         showDialog,
//         AlertDialog,
//         CircularProgressIndicator,
//         WillPopScope,
//         Colors,
//         Center;
// // import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:intl/intl.dart';

// class SizeMargin {
//   static size({double? height, double? width}) => SizedBox(
//         height: height?.h,
//         width: width?.w,
//       );
// }

// extension NullChecker on String? {
//   /*/// Converts the first letter of a string to [null].
//   ///
//   /// Example:
//   /// ```dart
//   /// var string = 'example';
//   /// string.capitalize();     // Example
//   /// ``` */
//   bool get isNull => this == null;
// }

// String get currency {
//   var format =
//       NumberFormat.simpleCurrency(locale: Platform.localeName, name: 'NGN');
//   return format.currencySymbol;
// }

// void snackBar(BuildContext context, String message,
//     [Duration timer = const Duration(milliseconds: 4000)]) {
//   ScaffoldMessenger.of(context).removeCurrentSnackBar();
//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       content: Text(
//         message,
//       ),
//       duration: timer,
//     ),
//   );
// }

// void consoleLog(dynamic args) {
//   if (args is List) {
//     for (final arg in args) {
//       debugPrint("$arg");
//     }
//   } else {
//     debugPrint("$args");
//   }
// }

// void showProgress(BuildContext ctx) {
//   showDialog(
//     barrierDismissible: false,
//     context: ctx,
//     builder: (_) {
//       return WillPopScope(
//         onWillPop: () => Future.value(false),
//         child: const AlertDialog(
//           elevation: 0.0,
//           backgroundColor: Colors.transparent,
//           title: Center(
//             child: CircularProgressIndicator(),
//           ),
//         ),
//       );
//     },
//   );
// }
