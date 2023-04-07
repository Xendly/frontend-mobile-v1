import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/iconsax_icons.dart';
import 'package:xendly_mobile/src/presentation/widgets/buttons/solid_button.dart';
import 'package:xendly_mobile/src/presentation/widgets/dialogs/alert_dialog.dart';
import 'package:xendly_mobile/src/presentation/widgets/dual_texts.dart';
import 'package:xendly_mobile/src/presentation/widgets/title_bar.dart';

class Withdraw extends StatefulWidget {
  const Withdraw({Key? key}) : super(key: key);
  @override
  State<Withdraw> createState() => _WithdrawState();
}

class _WithdrawState extends State<Withdraw> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>(debugLabel: "withdraw");
  final TextEditingController amountController = TextEditingController();
  var f = NumberFormat("###,###", "en_US");
  String? selectedWallet;

  Map<String, dynamic> data = {
    "amount": "",
    "beneficiary_id": "",
  };

  void _submit() async {
    if (GetUtils.isNullOrBlank(amountController.text)!) {
      alertDialog(
        context,
        Iconsax.info_circle,
        "Invalid Amount",
        "Please provide a valid amount",
        () => Navigator.pop(context),
        XMColors.error0,
      );
    } else {
      final isValid = formKey.currentState!.validate();
      if (isValid) {
        formKey.currentState!.save();
        try {
          printInfo(info: "Everything is ok...just send! - ${data.toString()}");
        } catch (error) {
          Get.snackbar("Error", "Unknown Error Occured, Try Again!");
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    amountController;
    selectedWallet = Get.parameters['email'];
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    const divider = Divider(
      thickness: 1,
      height: 38,
      color: XMColors.gray_70,
    );
    return Scaffold(
      backgroundColor: XMColors.light,
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 24,
          ),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const TitleBar(
                  title: "Withdraw Money",
                  suffixIcon: Iconsax.arrow_swap_horizontal,
                  suffixColor: XMColors.none,
                ),
                const SizedBox(height: 82),
                TextFormField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(7),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  controller: amountController,
                  onSaved: (value) {
                    data["amount"] = value!;
                    data["beneficiary_id"] = 2;
                  },
                  style: textTheme.headline1!.copyWith(
                    color: XMColors.shade0,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(0),
                    isDense: true,
                    hintText: "0 $selectedWallet",
                    hintStyle: textTheme.headline1!.copyWith(
                      color: XMColors.shade3,
                      fontWeight: FontWeight.w600,
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: XMColors.none,
                        width: 0,
                      ),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: XMColors.none,
                        width: 0,
                      ),
                    ),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: XMColors.none,
                        width: 0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  decoration: BoxDecoration(
                    color: XMColors.shade4,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: Text(
                    selectedWallet.toString(),
                    style: textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 82),
                const DualTexts(
                  title: "Transfer Speed",
                  value: "Instant",
                ),
                divider,
                const DualTexts(
                  title: "Transfer Fees",
                  value: "10%, Incl",
                ),
                divider,
                DualTexts(
                  title: "You'll Recieve",
                  value: "0 $selectedWallet",
                ),
                divider,
                const DualTexts(
                  title: "Exchange Rate",
                  value: "N500 = \$1",
                ),
                divider,
                Text(
                  "Please not that the exchange rate is subject based on current market condition and trends.",
                  textAlign: TextAlign.center,
                  style: textTheme.bodyText1?.copyWith(color: XMColors.shade3),
                ),
                const Spacer(),
                XnSolidButton(
                  content: Text(
                    "Withdraw 0${f.format(int.tryParse(amountController.text) ?? 0)} $selectedWallet",
                    style: textTheme.bodyText1?.copyWith(
                      color: XMColors.shade6,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  backgroundColor: XMColors.primary,
                  action: () => _submit(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// /* == default files == */
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// /* == imported packages == */
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// // import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
// import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
// import 'package:xendly_mobile/src/presentation/widgets/buttons/rounded.dart';
// import 'package:xendly_mobile/src/presentation/widgets/dropdown_input.dart';
// import 'package:xendly_mobile/src/presentation/widgets/dual_texts.dart';
// import 'package:xendly_mobile/src/data/models/payout_account_model.dart';
// import 'package:xendly_mobile/src/data/services/accounts_service.dart';
// import 'package:xendly_mobile/src/presentation/widgets/new_title_bar.dart';
// import 'package:xendly_mobile/src/presentation/widgets/widgets.dart';

// /* == withdraw cash component == */
// class Withdraw extends StatefulWidget {
//   const Withdraw({Key? key}) : super(key: key);
//   @override
//   State<Withdraw> createState() => _WithdrawState();
// }

// class _WithdrawState extends State<Withdraw> {
//   GlobalKey<FormState> formKey =
//       GlobalKey<FormState>(debugLabel: "withdraw_money");

//   var f = NumberFormat("###,###", "en_US");
//   String currency = 0.toString();
//   bool? curVal = false;
//   bool _isProcessing = false;
//   late Future<List<PayoutAccountModel>> futurePayoutAccount;
//   PayoutAccountModel? accountSelected;
//   String? _accountName;
//   final _accountService = Get.put(AccountsService());
//   // final _walletAuth = Get.put(WalletAuth());

//   final TextEditingController amount = TextEditingController();
//   double _parsedAmount = 0.0;
//   Map<String, dynamic> data = {"amount": "", 'beneficiary_id': 0};

//   @override
//   void initState() {
//     super.initState();
//     amount;
//     currency;
//     futurePayoutAccount = _accountService.getPayoutAccounts();
//   }

//   String? validateAmount(String value) {
//     if (GetUtils.isNullOrBlank(value)!) {
//       return "Enter an Amount";
//     } else if (!GetUtils.isNumericOnly(value)) {
//       return "Enter a valid amount";
//     } else {
//       return null;
//     }
//   }

//   // void withdrawToBank() async {
//   //   if (accountSelected == null) {
//   //     snackBar(
//   //       context,
//   //       'please select a payout account',
//   //     );
//   //     return;
//   //   }
//   //   if (_parsedAmount < 500) {
//   //     snackBar(
//   //       context,
//   //       'Minimum withdrawal is NGN 500',
//   //     );
//   //     return;
//   //   }
//   //   setState(() {
//   //     _isProcessing = true;
//   //   });
//   //   try {
//   //     final result = await _walletAuth.withdrawToBank(
//   //       _parsedAmount,
//   //       data['beneficiary_id'],
//   //     );
//   //     if (result['status'] == 'success') {
//   //       _successDialog();
//   //     } else {
//   //       setState(() {
//   //         _isProcessing = false;
//   //       });
//   //       snackBar(
//   //         context,
//   //         result['message'],
//   //       );
//   //     }
//   //   } catch (err) {
//   //     setState(() {
//   //       _isProcessing = false;
//   //     });
//   //     Get.snackbar("Error", "Unknown Error Occured, Try Again!");
//   //     return printInfo(
//   //       info: "Unknown Error Occured, Try Again!",
//   //     );
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     // divider variable
//     const divider = Divider(
//       thickness: 1,
//       height: 38,
//       color: XMColors.gray_70,
//     );
//     return Scaffold(
//       backgroundColor: XMColors.light,
//       extendBody: true,
//       resizeToAvoidBottomInset: false,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(
//             horizontal: 18,
//             vertical: 24,
//           ),
//           child: Column(
//             children: [
//               const TitleBar(
//                 title: "Withdraw Cash",
//               ),
//               const SizedBox(height: 46),
//               Text(
//                 "Transfer to Bank",
//                 style: Theme.of(context).textTheme.bodyText1!.copyWith(
//                       color: XMColors.gray,
//                       fontWeight: FontWeight.w600,
//                     ),
//               ),
//               const SizedBox(height: 8),
//               TextFormField(
//                 textAlign: TextAlign.center,
//                 keyboardType: TextInputType.number,
//                 inputFormatters: [
//                   LengthLimitingTextInputFormatter(6),
//                   FilteringTextInputFormatter.digitsOnly,
//                 ],
//                 controller: amount,
//                 onChanged: (v) {
//                   setState(() {
//                     _parsedAmount = double.tryParse(v) ?? 0.0;
//                   });
//                 },
//                 style: Theme.of(context).textTheme.headline2!.copyWith(
//                       color: XMColors.primary_20,
//                     ),
//                 decoration: InputDecoration(
//                   contentPadding: const EdgeInsets.all(0),
//                   isDense: true,
//                   hintText: "NGN 0",
//                   hintStyle: Theme.of(context).textTheme.headline2!.copyWith(
//                         color: XMColors.gray,
//                       ),
//                   focusedBorder: const OutlineInputBorder(
//                     borderSide: BorderSide(
//                       color: XMColors.none,
//                       width: 0,
//                     ),
//                   ),
//                   enabledBorder: const OutlineInputBorder(
//                     borderSide: BorderSide(
//                       color: XMColors.none,
//                       width: 0,
//                     ),
//                   ),
//                   border: const OutlineInputBorder(
//                     borderSide: BorderSide(
//                       color: XMColors.none,
//                       width: 0,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 15),
//               Container(
//                 decoration: BoxDecoration(
//                   color: XMColors.gray_70,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 padding: const EdgeInsets.fromLTRB(15, 10, 13, 8),
//                 child: Text(
//                   "Nigerian Naira",
//                   style: Theme.of(context).textTheme.bodyText1!.copyWith(
//                         fontWeight: FontWeight.w700,
//                       ),
//                 ),
//               ),
//               const SizedBox(height: 44),
//               const DualTexts(
//                 title: "Transfer Speed",
//                 value: "Instant",
//               ),
//               divider,
//               const DualTexts(
//                 title: "Transfer Fees",
//                 value: "10%, Incl",
//               ),
//               divider,
//               const DualTexts(
//                 title: "You'll Recieve",
//                 value: "0 NGN",
//               ),
//               divider,
//               FutureBuilder<List<PayoutAccountModel>>(
//                 future: futurePayoutAccount,
//                 builder: (context, snapshot) {
//                   if (snapshot.hasData) {
//                     return DropdownInput<PayoutAccountModel>(
//                       label: "Select account",
//                       hintText: "8373633",
//                       borderRadius: BorderRadius.circular(10),
//                       items: snapshot.data?.map((account) {
//                         return DropdownMenuItem<PayoutAccountModel>(
//                           child: body(
//                             "(${account.accountNumber}) ${account.bankName}",
//                             XMColors.primary,
//                             16,
//                           ),
//                           value: account,
//                         );
//                       }).toList(),
//                       action: (PayoutAccountModel? value) {
//                         setState(() {
//                           accountSelected = value!;
//                           _accountName = value.accountName;
//                           data["beneficiary_id"] = value.id;
//                         });
//                       },
//                     );
//                   } else if (snapshot.hasError) {
//                     return Text("${snapshot.error}");
//                   }
//                   return const Center(
//                     child: CupertinoActivityIndicator(),
//                   );
//                 },
//               ),
//               if (_accountName != null) ...[
//                 const SizedBox(height: 14),
//                 Align(
//                   alignment: Alignment.topLeft,
//                   child: Text(
//                     _accountName!,
//                     style: const TextStyle(
//                       fontSize: 18.0,
//                       color: XMColors.dark,
//                     ),
//                   ),
//                 ),
//               ],

//               // Expanded(
//               //   child: SingleChildScrollView(
//               //     child: Column(
//               //       children: [
//               //         // const SizedBox(height: 38),
//               //         // Text(
//               //         //   "Only NGN available",
//               //         //   style: Theme.of(context).textTheme.bodyText1!.copyWith(
//               //         //         color: XMColors.gray,
//               //         //         fontWeight: FontWeight.w600,
//               //         //       ),
//               //         // ),
//               //         // const SizedBox(height: 8.0),
//               //         // TextFormField(
//               //         //   textAlign: TextAlign.center,
//               //         //   keyboardType: TextInputType.number,
//               //         //   inputFormatters: [
//               //         //     LengthLimitingTextInputFormatter(6),
//               //         //     FilteringTextInputFormatter.digitsOnly,
//               //         //   ],
//               //         //   controller: amount,
//               //         //   onChanged: (v) {
//               //         //     setState(() {
//               //         //       _parsedAmount = double.tryParse(v) ?? 0.0;
//               //         //       // amount.text = f.format(_parsedAmount);
//               //         //     });
//               //         //   },
//               //         //   style: Theme.of(context).textTheme.headline2!.copyWith(
//               //         //         color: XMColors.primary_20,
//               //         //       ),
//               //         //   decoration: InputDecoration(
//               //         //     contentPadding: const EdgeInsets.all(0),
//               //         //     isDense: true,
//               //         //     hintText: "NGN 0",
//               //         //     hintStyle:
//               //         //         Theme.of(context).textTheme.headline2!.copyWith(
//               //         //               color: XMColors.gray,
//               //         //             ),
//               //         //     focusedBorder: const OutlineInputBorder(
//               //         //       borderSide: BorderSide(
//               //         //         color: XMColors.none,
//               //         //         width: 0,
//               //         //       ),
//               //         //     ),
//               //         //     enabledBorder: const OutlineInputBorder(
//               //         //       borderSide: BorderSide(
//               //         //         color: XMColors.none,
//               //         //         width: 0,
//               //         //       ),
//               //         //     ),
//               //         //     border: const OutlineInputBorder(
//               //         //       borderSide: BorderSide(
//               //         //         color: XMColors.none,
//               //         //         width: 0,
//               //         //       ),
//               //         //     ),
//               //         //   ),
//               //         // ),
//               //         // const SizedBox(height: 12),
//               //         // Container(
//               //         //   decoration: BoxDecoration(
//               //         //     color: XMColors.gray_70,
//               //         //     borderRadius: BorderRadius.circular(10),
//               //         //   ),
//               //         //   padding: const EdgeInsets.fromLTRB(15, 10, 13, 6),
//               //         //   child: Text(
//               //         //     "Nigerian Naira",
//               //         //     style:
//               //         //         Theme.of(context).textTheme.bodyText1!.copyWith(
//               //         //               fontWeight: FontWeight.w700,
//               //         //             ),
//               //         //   ),
//               //         // ),
//               //         // const SizedBox(height: 48),
//               //         // Row(
//               //         //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               //         //   children: [
//               //         //     Text(
//               //         //       "Transfer Speed",
//               //         //       style:
//               //         //           Theme.of(context).textTheme.bodyText1!.copyWith(
//               //         //                 color: XMColors.gray,
//               //         //               ),
//               //         //     ),
//               //         //     Text(
//               //         //       "Instant",
//               //         //       style: Theme.of(context).textTheme.bodyText1,
//               //         //     ),
//               //         //   ],
//               //         // ),
//               //         // const SizedBox(height: 14),
//               //         // divider,
//               //         // const SizedBox(height: 14),
//               //         // Row(
//               //         //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               //         //   children: [
//               //         //     Text(
//               //         //       "Transfer Fees",
//               //         //       style:
//               //         //           Theme.of(context).textTheme.bodyText1!.copyWith(
//               //         //                 color: XMColors.gray,
//               //         //               ),
//               //         //     ),
//               //         //     Text(
//               //         //       "NGN 0",
//               //         //       style: Theme.of(context).textTheme.bodyText1,
//               //         //     ),
//               //         //   ],
//               //         // ),
//               //         // const SizedBox(height: 14),
//               //         // divider,
//               //         // const SizedBox(height: 14),
//               //         // Row(
//               //         //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               //         //   children: [
//               //         //     Text(
//               //         //       "You'll Receive",
//               //         //       style:
//               //         //           Theme.of(context).textTheme.bodyText1!.copyWith(
//               //         //                 color: XMColors.gray,
//               //         //               ),
//               //         //     ),
//               //         //     Text("${f.format(_parsedAmount)} NGN",
//               //         //         style: Theme.of(context).textTheme.bodyText1),
//               //         //   ],
//               //         // ),
//               //         // const SizedBox(height: 14),
//               //         // divider,

//               //         const SizedBox(height: 8.0),
//               //         FutureBuilder<List<PayoutAccountModel>>(
//               //           future: futurePayoutAccount,
//               //           builder: (context, snapshot) {
//               //             if (snapshot.hasData) {
//               //               return DropdownInput<PayoutAccountModel>(
//               //                 label: "Select account",
//               //                 hintText: "8373633",
//               //                 borderRadius: BorderRadius.circular(10),
//               //                 items: snapshot.data?.map((account) {
//               //                   return DropdownMenuItem<PayoutAccountModel>(
//               //                     child: body(
//               //                       "(${account.accountNumber}) ${account.bankName}",
//               //                       XMColors.primary,
//               //                       16,
//               //                     ),
//               //                     value: account,
//               //                   );
//               //                 }).toList(),
//               //                 action: (PayoutAccountModel? value) {
//               //                   setState(() {
//               //                     accountSelected = value!;
//               //                     _accountName = value.accountName;
//               //                     data["beneficiary_id"] = value.id;
//               //                   });
//               //                 },

//               //                 // validator: (value) {
//               //                 //   return validateCountry(value);
//               //                 // },
//               //               );
//               //             } else if (snapshot.hasError) {
//               //               return Text("${snapshot.error}");
//               //             }
//               //             return const Center(
//               //               child: CupertinoActivityIndicator(),
//               //             );
//               //           },
//               //         ),
//               //         if (_accountName != null) ...[
//               //           const SizedBox(height: 14),
//               //           Align(
//               //             alignment: Alignment.topLeft,
//               //             child: Text(
//               //               _accountName!,
//               //               style: const TextStyle(
//               //                 fontSize: 18.0,
//               //                 color: XMColors.dark,
//               //               ),
//               //             ),
//               //           ),
//               //         ],
//               //         // Row(
//               //         //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               //         //   children: [
//               //         //     Text("****9045, First Bank",
//               //         //         style: Theme.of(context).textTheme.bodyText1),
//               //         //   ],
//               //         // ),
//               //         // const SizedBox(height: 8.0),
//               //         // divider,
//               //         // const SizedBox(height: 48.0),

//               //       ],
//               //     ),
//               //   ),
//               // ),
//               const Spacer(),
//               // RoundedButton(
//               //   isLoading: _isProcessing,
//               //   text: "Continue",
//               //   action: withdrawToBank,
//               // ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _successDialog() {
//     showDialog(
//       barrierDismissible: false,
//       context: context,
//       builder: (BuildContext context) {
//         return WillPopScope(
//           onWillPop: () => Future.value(false),
//           child: Dialog(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.symmetric(
//                 vertical: 50,
//                 horizontal: 26,
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   const CupertinoActivityIndicator.partiallyRevealed(),
//                   const SizedBox(
//                     height: 25,
//                   ),
//                   Text(
//                     "Request Successful",
//                     style: Theme.of(context).textTheme.subtitle1!.copyWith(
//                           fontWeight: FontWeight.w600,
//                         ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     "Your withdrawal is being processed",
//                     textAlign: TextAlign.center,
//                     style: Theme.of(context).textTheme.bodyText1!.copyWith(
//                           fontWeight: FontWeight.w500,
//                           color: XMColors.dark,
//                         ),
//                   ),
//                   const SizedBox(height: 26),
//                   RoundedButton(
//                     text: "Finish",
//                     action: () {
//                       Navigator.pop(context);
//                       Get.back(
//                         result: true,
//                       );
//                     },
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
