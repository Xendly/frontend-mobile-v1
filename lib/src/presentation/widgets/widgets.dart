import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/data/models/transaction_model_old.dart';
import 'package:xendly_mobile/src/data/models/wallet_model_old.dart';
import 'package:xendly_mobile/src/presentation/widgets/transaction_list_item.dart';
import '../../config/routes.dart' as routes;

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

// bool _isLoadingTransactions = true;
late List<Wallet> _userWallet = [];
// late List<TransactionModel> _transactions = [];

/* == Display Transactions === */
// Widget showTransactions(bool loading, List<TransactionModel> _transactions) {
//   if (loading) {
//     return _buildShimmer();
//   }
//   if (_transactions.isEmpty) {
//     return _buildEmptyTransactions();
//   }
//   return ListView.separated(
//     physics: const NeverScrollableScrollPhysics(),
//     shrinkWrap: true,
//     itemBuilder: (_, index) {
//       final transaction = _transactions[index];
//       return TransactionListItem(
//         action: () => Get.toNamed(
//           routes.transactionReceipt,
//           arguments: transaction,
//         ),
//         currency: transaction.currency,
//         title: transaction.title,
//         subtitle: DateFormat.yMMMEd().format(transaction.date),
//         amount: _formatAmount(transaction.amount.toString()),
//         entry: transaction.entry,
//       );
//     },
//     separatorBuilder: (_, __) => const SizedBox(height: 12.0),
//     itemCount: _transactions.length,
//   );
// }

String _formatAmount(String a) => a.replaceAllMapped(
    RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');

Widget _buildShimmer() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    // enabled: _enabled,
    child: ListView.builder(
      itemCount: 4,
      shrinkWrap: true,
      itemBuilder: (_, __) => Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: _shimmerItem(),
      ),
    ),
  );
}

Widget _buildEmptyTransactions() {
  return Column(
    children: [
      const SizedBox(
        height: 12.0,
      ),
      SvgPicture.asset(
        'assets/icons/receipt-2.svg',
        width: 60.0,
      ),
      const SizedBox(
        height: 12.0,
      ),
      const Text(
        'You have not made any transactions yet',
        style: TextStyle(
          fontSize: 24.0,
        ),
        textAlign: TextAlign.center,
      ),
      const SizedBox(
        height: 12.0,
      ),
      const Text(
        'When you do, they all appear here',
        style: TextStyle(color: XMColors.gray
            // fontSize: 24.0,
            ),
        textAlign: TextAlign.center,
      ),
    ],
  );
}

Widget _shimmerItem() {
  return Row(
    children: <Widget>[
      Container(
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        height: 40.0,
        width: 40.0,
      ),
      const SizedBox(
        width: 12.0,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 120.0,
            height: 8.0,
            color: Colors.white,
          ),
          const SizedBox(
            height: 12.0,
          ),
          Container(
            width: 60.0,
            height: 8.0,
            color: Colors.white,
          ),
        ],
      ),
      const Spacer(),
      Container(
        width: 40.0,
        height: 8.0,
        color: Colors.white,
      ),
    ],
  );
}

// === Load and show transactions result === //
// Widget userTransactions(
//     bool loading, List transactions, BuildContext context) {
//   if (loading) {
//     return _buildShimmer();
//   }
//   if (transactions.isEmpty) {
//     return _emptyTransactions(context);
//   } else {
//     return ListView.separated(
//       physics: const NeverScrollableScrollPhysics(),
//       shrinkWrap: true,
//       itemBuilder: (_, index) {
//         final transaction = transactions[index];
//         return TransactionListItem(
//           action: () => Get.toNamed(
//             routes.transactionReceipt,
//             arguments: transaction,
//           ),
//           currency: transaction.currency,
//           title: transaction.title,
//           subtitle: DateFormat.yMMMEd().format(transaction.date),
//           amount: _formatAmount(transaction.amount.toString()),
//           entry: transaction.entry,
//         );
//       },
//       separatorBuilder: (_, __) => const SizedBox(height: 10),
//       itemCount: _transactions.length,
//     );
//   }
// }

// === If there are no transactions... === //
Widget _emptyTransactions(BuildContext context) {
  return SizedBox(
    height: MediaQuery.of(context).size.height * 0.4,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset('assets/icons/receipt-2.svg', width: 56),
        const SizedBox(height: 20),
        Text(
          "No transactions yet",
          style: Theme.of(context).textTheme.headline5?.copyWith(
                fontWeight: FontWeight.w600,
              ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}
