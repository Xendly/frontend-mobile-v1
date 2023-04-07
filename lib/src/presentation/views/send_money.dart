import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterwave_standard/flutterwave.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/presentation/widgets/buttons/rounded.dart';
import 'package:xendly_mobile/src/presentation/widgets/dual_texts.dart';
import 'package:xendly_mobile/src/presentation/widgets/title_bar.dart';
import 'package:xendly_mobile/src/data/models/beneficiary_model.dart';
import 'package:xendly_mobile/src/data/services/public_auth.dart';

class SendMoney extends StatefulWidget {
  const SendMoney({Key? key}) : super(key: key);
  @override
  State<SendMoney> createState() => _SendMoneyState();
}

class _SendMoneyState extends State<SendMoney> {
  bool? curVal = false;

  var f = NumberFormat("###,###", "en_US");

  GlobalKey<FormState> formKey =
      GlobalKey<FormState>(debugLabel: "_SendMoneyKey");

  late BeneficiaryData beneficiary;

  double rate = 0.0;
  bool _isLoading = true;
  bool _isProcessing = false;
  double _parsedAmount = 0.0;
  String currency = 'NGN';

  final TextEditingController amount = TextEditingController();
  late String beneficiaryId;

  @override
  void initState() {
    super.initState();
    beneficiary = Get.arguments;
    // benData = Get.arguments as BeneficiaryData;
  }

  Map<String, dynamic> data = {
    "amount": "",
    "beneficiaryId": "",
    "currency": "NGN",
  };

  String? amountValidate(String value) {
    if (GetUtils.isNullOrBlank(value)!) {
      return "Enter an Amount";
    } else if (!GetUtils.isNumericOnly(value)) {
      return "Enter a valid amount";
    } else {
      return null;
    }
  }

  // final _walletAuth = Get.put(WalletAuth());

  // void sendCash() async {
  //   final isValid = formKey.currentState!.validate();
  //   if (!isValid) {
  //     printInfo(info: "Amount is Empty");
  //   } else {
  //     formKey.currentState!.save();
  //     try {
  //       final result = await _walletAuth.sendCash(data);
  //       if (result['statusCode'] == 200 || result["statusCode"] == 201) {
  //         printInfo(info: "${result["message"]}");
  //         Get.snackbar(
  //           result["status"],
  //           result["message"],
  //           backgroundColor: Colors.green,
  //           colorText: XMColors.light,
  //           duration: const Duration(seconds: 5),
  //         );
  //       } else {
  //         printInfo(info: "${result["message"]}");
  //         if (result["message"] != null || result["status"] != "failed") {
  //           Get.snackbar(
  //             result["status"],
  //             result["message"],
  //           );
  //         } else {
  //           Get.closeAllSnackbars();
  //           Get.snackbar(
  //             result["status"].toString(),
  //             result["message"],
  //             backgroundColor: XMColors.red,
  //             colorText: XMColors.light,
  //             duration: const Duration(seconds: 5),
  //           );
  //         }
  //       }
  //     } catch (err) {
  //       Get.snackbar("Error", "Unknown Error Occured, Try Again!");
  //       return printInfo(
  //         info: "Unknown Error Occured, Try Again!",
  //       );
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // divider variable
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
          child: Column(
            children: [
              const TitleBar(
                title: "Send Cash",
              ),
              const SizedBox(height: 46),
              Text(
                "Send cash to ${beneficiary.displayName}",
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: XMColors.gray,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(7),
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onChanged: (v) {
                  setState(() {
                    _parsedAmount = double.tryParse(v) ?? 0.0;
                  });
                },
                controller: amount,
                style: Theme.of(context).textTheme.headline2!.copyWith(
                      color: XMColors.primary_20,
                    ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(0),
                  isDense: true,
                  hintText: "0 $currency",
                  hintStyle: Theme.of(context).textTheme.headline2!.copyWith(
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
                // validator: (value) {
                //   return amountValidate(value!);
                // },
                // onSaved: (value) => data["amount"] = value!,
              ),
              const SizedBox(height: 15),
              Container(
                  decoration: BoxDecoration(
                    color: XMColors.gray_70,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.fromLTRB(15, 10, 13, 8),
                  child: DropdownButton<String>(
                      value: currency,
                      underline: const SizedBox(),
                      items: [
                        DropdownMenuItem(
                          value: 'NGN',
                          child: Text(
                            "Nigerian Naira",
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontWeight: FontWeight.w700,
                                    ),
                          ),
                        ),
                        DropdownMenuItem(
                          value: 'USD',
                          child: Text(
                            "United States Dollar",
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontWeight: FontWeight.w700,
                                    ),
                          ),
                        )
                      ],
                      onChanged: (v) {
                        setState(() {
                          currency = v ?? 'NGN';
                        });
                      })

                  // Text(
                  //   "Nigerian Naira",
                  //   style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  //         fontWeight: FontWeight.w700,
                  //       ),
                  // ),
                  ),
              const SizedBox(height: 44),
              const DualTexts(
                title: "Transfer Speed",
                value: "Instant",
              ),
              divider,
              DualTexts(
                title: "Transfer Fees",
                value: "$currency 0",
              ),
              divider,
              DualTexts(
                title: "${beneficiary.displayName} will Recieve",
                value: "$currency ${f.format(_parsedAmount)}",
              ),
              const Spacer(),
              // ElevatedButton(
              //   onPressed: () {
              //     sendCash();
              //   },
              //   child: Text(
              //     "Send Cash",
              //     style: Theme.of(context).textTheme.bodyText1!.copyWith(
              //           color: XMColors.light,
              //         ),
              //   ),
              // ),

              // RoundedButton(
              //   isLoading: _isProcessing,
              //   text: "Continue",
              //   action: () async {
              //     if (_parsedAmount < 1) {
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
              //       final result = await WalletAuth().p2pTransfer(
              //         _parsedAmount,
              //         beneficiary.id,
              //         currency,
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
              //       snackBar(context, 'Transfer was not successful, try again');
              //     }
              //   },
              // ),

              // const SizedBox(height: 38),
              // divider,
              // const SizedBox(height: 18),
              // Row(
              //   children: [
              //     Expanded(
              //       child: Column(
              //         children: [
              //           Text(
              //             "Speed",
              //             style:
              //                 Theme.of(context).textTheme.bodyText2!.copyWith(
              //                       color: XMColors.gray,
              //                       fontWeight: FontWeight.w600,
              //                     ),
              //           ),
              //           const SizedBox(height: 4),
              //           Text(
              //             "instant",
              //             style:
              //                 Theme.of(context).textTheme.bodyText1!.copyWith(
              //                       fontWeight: FontWeight.w600,
              //                     ),
              //           ),
              //         ],
              //       ),
              //     ),
              //     Expanded(
              //       child: Column(
              //         children: [
              //           Text(
              //             "Fees",
              //             style:
              //                 Theme.of(context).textTheme.bodyText2!.copyWith(
              //                       color: XMColors.gray,
              //                       fontWeight: FontWeight.w600,
              //                     ),
              //           ),
              //           const SizedBox(height: 4),
              //           Text(
              //             "3 USD, Incl.",
              //             style:
              //                 Theme.of(context).textTheme.bodyText1!.copyWith(
              //                       fontWeight: FontWeight.w600,
              //                     ),
              //           ),
              //         ],
              //       ),
              //     ),
              //     Expanded(
              //       child: Column(
              //         children: [
              //           Text(
              //             "You'll Get",
              //             style:
              //                 Theme.of(context).textTheme.bodyText2!.copyWith(
              //                       color: XMColors.gray,
              //                       fontWeight: FontWeight.w600,
              //                     ),
              //           ),
              //           const SizedBox(height: 4),
              //           Text(
              //             "117 USD",
              //             style:
              //                 Theme.of(context).textTheme.bodyText1!.copyWith(
              //                       fontWeight: FontWeight.w600,
              //                     ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ],
              // ),
              // const SizedBox(height: 18),
              // divider,
              // const SizedBox(height: 32),
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
                    // "Your exchange of $fromCurrency $parsedAmount to $toCurrency was successful",
                    "Your transfer was successful",
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

  final _publicAuth = Get.put(PublicAuth());
  checkFwSetup() async {
    try {
      final style = FlutterwaveStyle(
        appBarText: "My Standard Blue",
        buttonColor: const Color(0xffd0ebff),
        appBarIcon: const Icon(
          Icons.message,
          color: Color(0xffd0ebff),
        ),
        buttonTextStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        appBarColor: const Color(0xffd0ebff),
        dialogCancelTextStyle: const TextStyle(
          color: Colors.redAccent,
          fontSize: 18,
        ),
        dialogContinueTextStyle: const TextStyle(
          color: Colors.blue,
          fontSize: 18,
        ),
      );

      final Customer customer = Customer(
        name: "Thor Odinson",
        phoneNumber: "+2348134578903",
        email: "sonofodin@fillnoo.com",
      );

      final Flutterwave flutterwave = Flutterwave(
        isTestMode: false,
        context: context,
        style: style,
        publicKey: "FLWPUBK_TEST-9da57004452405fe95c857f569eac55f-X",
        currency: currency,
        redirectUrl: "my_redirect_url",
        txRef: "unique_transaction_reference",
        amount: "300.50",
        customer: customer,
        paymentOptions: "card",
        customization: Customization(title: "Xendly Test Payment"),
      );

      final ChargeResponse response = await flutterwave.charge();
      if (response != null) {
        print("Flutterwave Standard User is TRUE, User PROCEED with Tx!");
        print(response.toJson());
        if (response.success == true) {
          print("Flutterwave Standard is TRUE, Tx might be a SUCCESS!");
        } else {
          print("Flutterwave Standard is FALSE, Tx is defintely a FAILURE!");
        }
      } else {
        print("Flutterwave Standard User is FALSE, User CANCELLED Tx!");
      }
    } catch (err) {
      throw Exception(err);
    }
  }
}
