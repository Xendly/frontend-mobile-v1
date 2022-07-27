import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterwave_standard/core/flutterwave.dart';
import 'package:flutterwave_standard/flutterwave.dart';
import 'package:get/get.dart';
import 'package:xendly_mobile/view/shared/colors.dart';

Widget walletCard(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      // border: Border.all(
      //   color: XMColors.gray,
      //   width: 1.35,
      // ),
      borderRadius: BorderRadius.circular(15),
      gradient: const LinearGradient(
        colors: [
          XMColors.primary,
          XMColors.accent,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        strongCaption(
          "USD Balance",
          XMColors.gray,
          FontWeight.w600,
        ),
        const SizedBox(height: 7),
        heading2("\$528,346.790", XMColors.light)
      ],
    ),
  );
}

//  === inputs === //
Widget dropDownContainer(BuildContext context, Widget child,
    [double? tl = 0, double? bl = 0, double? tr = 0, double? br = 0]) {
  return Container(
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(tl!),
        bottomLeft: Radius.circular(bl!),
        topRight: Radius.circular(tr!),
        bottomRight: Radius.circular(br!),
      ),
      border: Border.all(
        color: XMColors.lightGray,
        width: 1.5,
      ),
    ),
    padding: const EdgeInsets.only(
      left: 17,
      right: 16,
      bottom: 16,
      top: 15,
    ),
    child: child,
  );
}

Widget rowTitleBar() {
  return Padding(
    padding: const EdgeInsets.only(top: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        heading5(
          "Welcome, James",
        ),
        SvgPicture.asset(
          "assets/icons/notification.svg",
          width: 22,
          height: 22,
        ),
      ],
    ),
  );
}

// === typography === //
Text heading(
  String? text, [
  Color? color = XMColors.dark,
  double? size,
  TextAlign? align = TextAlign.left,
  FontWeight? weight,
]) {
  return Text(
    text!,
    textAlign: align,
    style: TextStyle(
      color: color,
      fontSize: size,
      fontWeight: weight,
    ),
  );
}

// === TYPOGRAPHY === //
Text body(
  String text, [
  Color? color = XMColors.dark,
  double? size,
  TextAlign? align = TextAlign.left,
  FontWeight? weight,
]) {
  return Text(
    text,
    textAlign: align,
    style: TextStyle(
      color: color,
      fontSize: size,
      fontWeight: weight,
      fontFamily: "TTFirsNeue",
    ),
  );
}

Text heading1(
  String? text, [
  Color? color = XMColors.dark,
  TextAlign? align = TextAlign.left,
]) {
  return Text(
    text!,
    textAlign: align,
    style: TextStyle(
      color: color,
      fontSize: 28,
      fontWeight: FontWeight.w500,
    ),
  );
}

Text heading2(
  String? text, [
  Color? color = XMColors.dark,
]) {
  return Text(
    text!,
    style: TextStyle(
      color: color,
      fontSize: 24,
      fontWeight: FontWeight.w500,
      letterSpacing: 1,
    ),
  );
}

Text heading3(
  String? text, [
  Color? color = XMColors.dark,
  FontWeight? weight = FontWeight.w500,
]) {
  return Text(
    text!,
    style: TextStyle(
      color: color,
      fontSize: 22,
      fontWeight: FontWeight.w700,
    ),
  );
}

Text heading4(String? text) {
  return Text(
    text!,
    style: const TextStyle(
      color: XMColors.dark,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
  );
}

Text heading5(String? text) {
  return Text(
    text!,
    style: const TextStyle(
      color: XMColors.dark,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
  );
}

Text strongBody(
  String? text, [
  Color? color = XMColors.dark,
  FontWeight? weight = FontWeight.w500,
  TextAlign? align = TextAlign.left,
  double? height,
]) {
  return Text(
    text!,
    textAlign: align,
    style: TextStyle(
      color: color,
      fontSize: 16,
      fontWeight: weight,
      height: height,
    ),
  );
}

Text strongCaption(
  String? text, [
  Color? color = XMColors.gray,
  FontWeight? weight = FontWeight.w500,
]) {
  return Text(
    text!,
    style: TextStyle(
      color: color,
      fontSize: 14,
      fontWeight: weight,
    ),
  );
}

Text bodyText(
  String? text, [
  Color? color = XMColors.dark,
  FontWeight? weight = FontWeight.w500,
  TextAlign? align = TextAlign.left,
  double? height,
]) {
  return Text(
    text!,
    textAlign: align,
    style: TextStyle(
      color: color,
      fontSize: 16,
      fontWeight: weight,
      height: height,
    ),
  );
}

// === text style === //
TextStyle bodyTextStyle(
  Color? color,
  double? fontSize,
  FontWeight? fontWeight,
) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
    fontWeight: fontWeight,
  );
}

/* === sections === */
Widget sectionTitle() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      heading5("Recent Transactions"),
      strongBody("View More", XMColors.gray, FontWeight.w600),
    ],
  );
}

Widget listItem() {
  return ListTile(
    leading: const CircleAvatar(
      backgroundImage: NetworkImage(
        "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80",
      ),
      backgroundColor: XMColors.lightGray,
    ),
    title: strongBody("Hannibal King", XMColors.dark, FontWeight.w600),
    subtitle: Padding(
      padding: const EdgeInsets.only(top: 5),
      child: strongCaption(
        "29th June 2022",
        XMColors.gray,
        FontWeight.w600,
      ),
    ),
    trailing: strongBody(
      "-\$140.50",
      XMColors.red,
      FontWeight.w700,
    ),
  );
}

// === misc === //
Widget divider() {
  return const Divider(
    thickness: 1.5,
    color: XMColors.gray,
  );
}

Widget pageLabel(String? text, BuildContext context) {
  return GestureDetector(
    onTap: () => {
      // Navigator.pop(context),
      Get.back(),
    },
    child: Row(
      children: [
        SvgPicture.asset(
          "assets/icons/arrow-left.svg",
          color: XMColors.dark,
          height: 22,
          width: 22,
        ),
        const SizedBox(width: 14),
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: strongBody(text, XMColors.dark),
        ),
      ],
    ),
  );
}

Widget richText(
  String? mainText,
  String? suffixText,
  TextAlign align,
) {
  return RichText(
    textAlign: align,
    text: TextSpan(
      text: mainText,
      style: const TextStyle(
        fontFamily: "TTFirsNeue",
        color: XMColors.gray,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      children: [
        TextSpan(
          text: suffixText,
          style: const TextStyle(
            fontFamily: "TTFirsNeue",
            color: XMColors.primary,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

// === FLUTTERWAVE INSTANCE === //
// void handlePaymentInitialization(
//   BuildContext context,
//   String name,
//   String phone,
//   String email,
//   String amount,
// ) async {
//   final style = FlutterwaveStyle(
//     appBarText: "My Standard Blue",
//     buttonColor: const Color(0xffd0ebff),
//     appBarIcon: const Icon(
//       Icons.message,
//       color: Color(0xffd0ebff),
//     ),
//     buttonTextStyle: const TextStyle(
//       color: Colors.black,
//       fontWeight: FontWeight.bold,
//       fontSize: 18,
//     ),
//     appBarColor: const Color(0xffd0ebff),
//     dialogCancelTextStyle: const TextStyle(
//       color: Colors.redAccent,
//       fontSize: 18,
//     ),
//     dialogContinueTextStyle: const TextStyle(
//       color: Colors.blue,
//       fontSize: 18,
//     ),
//   );

//   final Customer customer = Customer(
//     name: name,
//     phoneNumber: phone,
//     email: email,
//   );

//   final Flutterwave flutterwave = Flutterwave(
//     isTestMode: false,
//     context: context,
//     style: style,
//     publicKey: "FLWPUBK_TEST-9da57004452405fe95c857f569eac55f-X",
//     currency: "NGN",
//     redirectUrl: "my_redirect_url",
//     txRef: "unique_transaction_reference",
//     amount: amount,
//     customer: customer,
//     paymentOptions: "card",
//     customization: Customization(title: "Xendly Test Payment"),
//   );
// }
