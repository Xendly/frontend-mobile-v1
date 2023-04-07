import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/config/utilities.dart';
import 'package:xendly_mobile/src/presentation/widgets/widgets.dart';
import 'package:xendly_mobile/src/presentation/widgets/widgets.dart';
import 'package:xendly_mobile/src/presentation/widgets/bottomSheet.dart';
import 'package:xendly_mobile/src/presentation/widgets/buttons/rounded.dart';
import 'package:xendly_mobile/src/presentation/widgets/dropdown_input.dart';
import 'package:xendly_mobile/src/presentation/widgets/page_title.dart';
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

class ExchangeCash extends StatefulWidget {
  const ExchangeCash({Key? key}) : super(key: key);
  @override
  State<ExchangeCash> createState() => _ExchangeCashState();
}

class _ExchangeCashState extends State<ExchangeCash> {
  final TextEditingController amount = TextEditingController();
  var f = NumberFormat("###,###", "en_US");

  late String fromCurrency;
  late String toCurrency;
  double rate = 0.0;
  bool _isLoading = true;
  bool _isProcessing = false;
  double parsedAmount = 0.0;

  @override
  void initState() {
    super.initState();
    fromCurrency = Get.arguments['from_currency'] ?? 'USD';
    toCurrency = Get.arguments['to_currency'] ?? 'NGN';
    // _getCurrencyRate();
    // _wallet = Get.arguments as Wallet;
    // _getData();
  }

  // void _getCurrencyRate() async {
  //   try {
  //     final result = await WalletAuth().getCurrencyExchangePair(
  //       fromCurrency,
  //       toCurrency,
  //     );
  //     print(result);
  //     if (result.containsKey('rate')) {
  //       setState(() {
  //         rate = double.parse(result['rate']);
  //         _isLoading = false;
  //       });
  //     } else {
  //       Navigator.pop(context);
  //       snackBar(context, 'Unable to get currency exchange rates');
  //     }
  //   } catch (e) {
  //     Navigator.pop(context);
  //     snackBar(context, 'Unable to get currency exchange rates');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // === TITLE SECTION === //
              PageTitleIcons(
                prefixIcon: "assets/icons/bold/icl-arrow-left-2.svg",
                title: "Exhange $fromCurrency to $toCurrency",
                prefixIconColor: XMColors.dark,
                prefixIconAction: () => Get.back(),
              ),
              Expanded(
                child: _isLoading
                    ? const Center(
                        child: SizedBox(
                          height: 50.0,
                          width: 50.0,
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation(XMColors.primary),
                          ),
                        ),
                      )
                    : SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 38),

                            Text(
                              "You send",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    color: XMColors.gray,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            Row(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    // textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(7),
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    controller: amount,
                                    onChanged: (v) {
                                      setState(() {
                                        parsedAmount =
                                            double.tryParse(v) ?? 0.0;
                                      });
                                    },
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline2!
                                        .copyWith(
                                          color: XMColors.primary_20,
                                        ),
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(0),
                                      isDense: true,
                                      hintText: "0 $fromCurrency",
                                      hintStyle: Theme.of(context)
                                          .textTheme
                                          .headline2!
                                          .copyWith(
                                            color: XMColors.gray,
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
                                ),
                                // Text(
                                //   "500 CAD",
                                //   style: Theme.of(context).textTheme.headline3!.copyWith(
                                //         color: XMColors.primary_20,
                                //         fontWeight: FontWeight.w600,
                                //       ),
                                // ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: XMColors.gray_70,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 8, 8, 4),
                                  child: Text(
                                    getCurrency(fromCurrency),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          fontWeight: FontWeight.w700,
                                        ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 22),
                            Text(
                              "You receive",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    color: XMColors.gray,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    "$toCurrency ${f.format(parsedAmount * rate)}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5!
                                        .copyWith(
                                          color: XMColors.primary_20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: XMColors.gray_70,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  margin: const EdgeInsets.only(left: 12.0),
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 8, 8, 4),
                                  child: Text(
                                    getCurrency(toCurrency),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          fontWeight: FontWeight.w700,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            const Divider(),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Exchange Rate:",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            color: XMColors.gray,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "$fromCurrency 1  = $toCurrency $rate",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        color: XMColors.dark,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Transaction Fees:",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            color: XMColors.gray,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "0",
                                  // "80% (400 CAD)",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        color: XMColors.dark,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "You'll Receive:",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            color: XMColors.gray,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "$toCurrency ${f.format(parsedAmount * rate)}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        color: XMColors.dark,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 48.0,
                            ),
                            // const Spacer(),
                            // RoundedButton(
                            //   isLoading: _isProcessing,
                            //   text: "Continue",
                            //   action: () async {
                            //     if ((parsedAmount * rate) < 1) {
                            //       snackBar(
                            //         context,
                            //         'Amount to be received must be greater than 0',
                            //       );
                            //       return;
                            //     }
                            //     setState(() {
                            //       _isProcessing = true;
                            //     });
                            //     try {
                            //       final result =
                            //           await WalletAuth().currencyExchange(
                            //         parsedAmount,
                            //         fromCurrency,
                            //         toCurrency,
                            //       );
                            //       if (result['status'] == 'success') {
                            //         _successDialog();
                            //       } else {
                            //         setState(() {
                            //           _isProcessing = false;
                            //         });
                            //         snackBar(
                            //           context,
                            //           result['message'],
                            //         );
                            //       }
                            //     } catch (e) {
                            //       print(e);
                            //       setState(() {
                            //         _isProcessing = false;
                            //       });
                            //       snackBar(context,
                            //           'Exchange was not successful, try again');
                            //     }
                            //   },
                            // ),
                          ],
                        ),
                      ),
              ),

              // Text(
              //   "500",
              //   style: Theme.of(context).textTheme.headline2!.copyWith(
              //         color: XMColors.primary_20,
              //       ),
              // ),
              // const SizedBox(height: 10),
              // Container(
              //   decoration: BoxDecoration(
              //     color: XMColors.gray_70,
              //     borderRadius: BorderRadius.circular(10),
              //   ),
              //   padding: const EdgeInsets.fromLTRB(10, 8, 8, 4),
              //   child: Text(
              //     "USD",
              //     style: Theme.of(context).textTheme.bodyText1!.copyWith(
              //           fontWeight: FontWeight.w700,
              //         ),
              //   ),
              // ),
              // const SizedBox(height: 40),
              // SvgPicture.asset(
              //   "assets/icons/arrow-down-2.svg",
              //   width: 42,
              //   height: 42,
              // ),
              // const SizedBox(height: 40),
              // Text(
              //   "You recieve",
              //   style: Theme.of(context).textTheme.bodyText1!.copyWith(
              //         color: XMColors.gray,
              //         fontWeight: FontWeight.w600,
              //       ),
              // ),
              // const SizedBox(height: 6),
              // Text(
              //   "350,000",
              //   style: Theme.of(context).textTheme.headline2!.copyWith(
              //         color: XMColors.primary_20,
              //       ),
              // ),
              // const SizedBox(height: 10),
              // Container(
              //   decoration: BoxDecoration(
              //     color: XMColors.gray_70,
              //     borderRadius: BorderRadius.circular(10),
              //   ),
              //   padding: const EdgeInsets.fromLTRB(10, 8, 8, 4),
              //   child: Text(
              //     "NGN",
              //     style: Theme.of(context).textTheme.bodyText1!.copyWith(
              //           fontWeight: FontWeight.w700,
              //         ),
              //   ),
              // ),
              // const SizedBox(height: 26),
              // Container(
              //   decoration: BoxDecoration(
              //     color: XMColors.none,
              //     border: Border.all(
              //       color: XMColors.dark,
              //     ),
              //   ),
              //   padding: const EdgeInsets.fromLTRB(20, 20, 20, 19),
              //   child: Column(
              //     children: [
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           bodyText("Transfer From:"),
              //           bodyText("United States Dollars"),
              //         ],
              //       ),
              //       const SizedBox(height: 8),
              //       const Divider(),
              //       const SizedBox(height: 14),
              //       bodyText("You are sending:"),
              //       const SizedBox(height: 6),
              //       heading(
              //         "-\$65,483.48",
              //         XMColors.dark,
              //         28,
              //       ),
              //       const SizedBox(height: 14),
              //       const Divider(),
              //       const SizedBox(height: 10),
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           bodyText("Wallet Balance (USD):"),
              //           bodyText("358,241.97 USD"),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
              // const SizedBox(height: 28),
              // Container(
              //   padding: const EdgeInsets.all(18),
              //   decoration: BoxDecoration(
              //     color: XMColors.primary,
              //     borderRadius: BorderRadius.circular(50),
              //   ),
              //   child: SvgPicture.asset(
              //     "assets/icons/arrow-swap.svg",
              //     width: 26,
              //     height: 26,
              //     color: XMColors.light,
              //   ),
              // ),
              // const SizedBox(height: 28),
              // Container(
              //   decoration: BoxDecoration(
              //     color: XMColors.none,
              //     border: Border.all(
              //       color: XMColors.dark,
              //     ),
              //   ),
              //   padding: const EdgeInsets.fromLTRB(20, 20, 20, 19),
              //   child: Column(
              //     children: [
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           bodyText("Transfer To:"),
              //           bodyText("United States Dollars"),
              //         ],
              //       ),
              //       const SizedBox(height: 8),
              //       const Divider(),
              //       const SizedBox(height: 14),
              //       bodyText("Jardaani will receive:"),
              //       const SizedBox(height: 6),
              //       heading(
              //         "+\$65,383.48",
              //         XMColors.dark,
              //         28,
              //       ),
              //       const SizedBox(height: 14),
              //       const Divider(),
              //       const SizedBox(height: 10),
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           bodyText("Transaction Fee:"),
              //           bodyText("1,000 USD"),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
              // const SizedBox(height: 22),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     bodyText(
              //       "Exchange Rate:",
              //       XMColors.gray,
              //       FontWeight.w600,
              //     ),
              //     bodyText(
              //       "USD 1 = NGN 650",
              //       XMColors.dark,
              //       FontWeight.w600,
              //     ),
              //   ],
              // ),
              // const SizedBox(height: 10),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     bodyText(
              //       "Delivery Time:",
              //       XMColors.gray,
              //       FontWeight.w600,
              //     ),
              //     bodyText(
              //       "15 Minutes",
              //       XMColors.dark,
              //       FontWeight.w600,
              //     ),
              //   ],
              // ),
              // const SizedBox(height: 32),
              // SolidButton(
              //   text: "Transfer \$65,383",
              //   textColor: XMColors.light,
              //   buttonColor: XMColors.primary,
              //   action: () => {
              //     Navigator.pushNamed(
              //       context,
              //       routes.confirmTransaction,
              //     )
              //   },
              // ),
              // const Spacer(),
              // RoundedButton(
              //   text: "Continue",
              //   action: () {
              //     showDialog(
              //       context: context,
              //       builder: (BuildContext context) {
              //         // return Dialog(
              //         //   shape: RoundedRectangleBorder(
              //         //     borderRadius: BorderRadius.circular(12),
              //         //   ),
              //         //   child: Padding(
              //         //     padding: const EdgeInsets.symmetric(
              //         //       vertical: 50,
              //         //       horizontal: 26,
              //         //     ),
              //         //     child: Column(
              //         //       mainAxisAlignment: MainAxisAlignment.center,
              //         //       mainAxisSize: MainAxisSize.min,
              //         //       children: [
              //         //         // icon
              //         //         // SvgPicture.asset(
              //         //         //   "assets/icons/search.svg",
              //         //         //   width: 75,
              //         //         //   height: 75,
              //         //         // ),
              //         //         const CupertinoActivityIndicator(),
              //         //         const SizedBox(
              //         //           height: 25,
              //         //         ),
              //         //         Text(
              //         //           "Transaction In Progress",
              //         //           style: Theme.of(context)
              //         //               .textTheme
              //         //               .subtitle1!
              //         //               .copyWith(
              //         //                 fontWeight: FontWeight.w600,
              //         //               ),
              //         //         ),
              //         //         const SizedBox(height: 8),
              //         //         Text(
              //         //           "Please wait while your transaction to Bruce Banner is processing",
              //         //           textAlign: TextAlign.center,
              //         //           style: Theme.of(context)
              //         //               .textTheme
              //         //               .bodyText1!
              //         //               .copyWith(
              //         //                 fontWeight: FontWeight.w500,
              //         //                 color: XMColors.gray_50,
              //         //               ),
              //         //         ),
              //         //       ],
              //         //     ),
              //         //   ),
              //         // );
              //         return Dialog(
              //           shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(12),
              //           ),
              //           child: Padding(
              //             padding: const EdgeInsets.symmetric(
              //               vertical: 50,
              //               horizontal: 26,
              //             ),
              //             child: Column(
              //               mainAxisAlignment: MainAxisAlignment.center,
              //               mainAxisSize: MainAxisSize.min,
              //               children: [
              //                 // icon
              //                 // SvgPicture.asset(
              //                 //   "assets/icons/search.svg",
              //                 //   width: 75,
              //                 //   height: 75,
              //                 // ),
              //                 const CupertinoActivityIndicator
              //                     .partiallyRevealed(),
              //                 const SizedBox(
              //                   height: 25,
              //                 ),
              //                 Text(
              //                   "Transaction Successful",
              //                   style: Theme.of(context)
              //                       .textTheme
              //                       .subtitle1!
              //                       .copyWith(
              //                         fontWeight: FontWeight.w600,
              //                       ),
              //                 ),
              //                 const SizedBox(height: 8),
              //                 Text(
              //                   "Your transaction to Bruce Banner is complete. Transaction ID is 123456789",
              //                   textAlign: TextAlign.center,
              //                   style: Theme.of(context)
              //                       .textTheme
              //                       .bodyText1!
              //                       .copyWith(
              //                         fontWeight: FontWeight.w500,
              //                         color: XMColors.gray_50,
              //                       ),
              //                 ),
              //                 const SizedBox(height: 14),
              //                 RoundedButton(
              //                   text: "Finish",
              //                   action: () {
              //                     Get.toNamed(routes.home);
              //                   },
              //                 ),
              //               ],
              //             ),
              //           ),
              //         );
              //       },
              //     );
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }

  void _successDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        // return Dialog(
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(12),
        //   ),
        //   child: Padding(
        //     padding: const EdgeInsets.symmetric(
        //       vertical: 50,
        //       horizontal: 26,
        //     ),
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       mainAxisSize: MainAxisSize.min,
        //       children: [
        //         // icon
        //         // SvgPicture.asset(
        //         //   "assets/icons/search.svg",
        //         //   width: 75,
        //         //   height: 75,
        //         // ),
        //         const CupertinoActivityIndicator(),
        //         const SizedBox(
        //           height: 25,
        //         ),
        //         Text(
        //           "Transaction In Progress",
        //           style: Theme.of(context)
        //               .textTheme
        //               .subtitle1!
        //               .copyWith(
        //                 fontWeight: FontWeight.w600,
        //               ),
        //         ),
        //         const SizedBox(height: 8),
        //         Text(
        //           "Please wait while your transaction to Bruce Banner is processing",
        //           textAlign: TextAlign.center,
        //           style: Theme.of(context)
        //               .textTheme
        //               .bodyText1!
        //               .copyWith(
        //                 fontWeight: FontWeight.w500,
        //                 color: XMColors.gray_50,
        //               ),
        //         ),
        //       ],
        //     ),
        //   ),
        // );
        return WillPopScope(
          onWillPop: () => Future.value(false),
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 50,
                horizontal: 26,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // icon
                  // SvgPicture.asset(
                  //   "assets/icons/search.svg",
                  //   width: 75,
                  //   height: 75,
                  // ),
                  const CupertinoActivityIndicator.partiallyRevealed(),
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    "Transaction Successful",
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Your exchange of $fromCurrency $parsedAmount to $toCurrency was successful",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: XMColors.dark,
                        ),
                  ),
                  const SizedBox(height: 26),
                  RoundedButton(
                    text: "Finish",
                    action: () {
                      Navigator.pop(context);
                      Get.back(
                        result: true,
                        // closeOverlays: true,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
