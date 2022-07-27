import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterwave_payment/flutterwave_payment.dart';
import 'package:flutterwave_standard/core/flutterwave.dart';
import 'package:flutterwave_standard/flutterwave.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:xendly_mobile/controller/core/public_auth.dart';
import 'package:xendly_mobile/controller/core/transaction_service.dart';
import 'package:xendly_mobile/controller/core/user_auth.dart';
import 'package:xendly_mobile/view/shared/colors.dart';
import 'package:xendly_mobile/view/shared/utils.dart';
import 'package:xendly_mobile/view/shared/widgets/buttons/rounded.dart';
import 'package:xendly_mobile/view/shared/widgets/page_title.dart';

import '../../model/wallet_model.dart';
import '../shared/widgets/text_input.dart';

class AddMoney extends StatefulWidget {
  const AddMoney({Key? key}) : super(key: key);
  @override
  State<AddMoney> createState() => _AddMoneyState();
}

class _AddMoneyState extends State<AddMoney> {
  String currency = 0.toString();
  bool? curVal = false;
  late Wallet _wallet;
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  // final String currency = "NGN";

  GlobalKey<FormState> formKey =
      GlobalKey<FormState>(debugLabel: "_addMoneyKey");

  final TextEditingController amount = TextEditingController(text: '0.00');

  var f = NumberFormat("###,###", "en_US");

  Map<String, dynamic> data = {
    "amount": "",
  };

  @override
  void initState() {
    super.initState();
    // currency;
    _wallet = Get.arguments as Wallet;
  }

  // setSelectedRadio(int val) {
  //   setState(() {
  //     selectedRadio = val;
  //   });
  // }

  String? validateAmount(String value) {
    if (GetUtils.isNullOrBlank(value)!) {
      return "Enter an Amount";
    } else if (!GetUtils.isNumericOnly(value)) {
      return "Enter a valid amount";
    } else {
      return null;
    }
  }

  void fundWallet() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      printInfo(info: "Amount is Empty");
    } else {
      formKey.currentState!.save();
      try {
        checkFwSetup();
        // if (result["statusCode"] == 200) {
        //   printInfo(info: "Status => ${result['status']}");
        //   printInfo(info: "Status Code => ${result['statusCode']}");
        //   printInfo(info: "Message => ${result['message']}");
        // }
      } catch (err) {
        Get.snackbar("Error", "Unknown Error Occured, Try Again!");
        return printInfo(
          info: "Unknown Error Occured, Try Again!",
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const divider = Divider(
      thickness: 1.25,
    );
    return Scaffold(
      backgroundColor: XMColors.light,
      extendBody: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 24,
          ),
          child: Column(
            children: [
              PageTitleIcons(
                prefixIcon: "assets/icons/bold/icl-arrow-left-2.svg",
                title: "Add Cash",
                prefixIconColor: XMColors.dark,
                prefixIconAction: () => Get.back(),
              ),
              const SizedBox(height: 38),
              Text(
                "Fund ${_wallet.currency} wallet",
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: XMColors.gray,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 6),
              GestureDetector(
                onTap: () {
                  showMaterialModalBottomSheet(
                    context: context,
                    builder: (_) {
                      return Container(
                        padding: EdgeInsets.fromLTRB(
                          16.0,
                          16.0,
                          16.0,
                          MediaQuery.of(context).viewInsets.bottom,
                        ),
                        // // height: 50.0,
                        // padding: const EdgeInsets.symmetric(
                        //   horizontal: 12,
                        //   vertical: 38,
                        // ),
                        color: XMColors.light,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Enter amount to fund",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1!
                                        .copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                  Chip(
                                    onDeleted: () {
                                      Navigator.pop(context);
                                    },
                                    label: GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Close')),
                                    deleteIcon: const Icon(Icons.close),
                                  )
                                ],
                              ),
                              const SizedBox(height: 10),
                              TextInput(
                                readOnly: false,
                                maxlength: 7,
                                label: "Amount",
                                hintText: "5000",
                                inputType: TextInputType.number,
                                borderRadius: BorderRadius.circular(10),
                                controller: amount,
                                onSaved: (value) => data["bvn"] = value,
                                // validator: (value) => validateBvn(value!),
                              ),
                              // TextField(
                              //   controller: amount,
                              //   onChanged: (v) {
                              //     setState(() {});
                              //   },
                              // ),
                              // Text(
                              //   "NGN and USD are supported for now",
                              //   textAlign: TextAlign.center,
                              //   style: Theme.of(context)
                              //       .textTheme
                              //       .bodyText1!
                              //       .copyWith(
                              //         color: XMColors.gray,
                              //       ),
                              // ),
                              const SizedBox(height: 24),
                              // checkboxlist
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Text(
                  "${amount.value.text.isNotEmpty ? f.format(int.tryParse(amount.value.text) ?? 0) : '0'} ${_wallet.currency}",
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        color: XMColors.primary_20,
                      ),
                ),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () => {
                  showMaterialModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        alignment: WrapAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 38,
                            ),
                            color: XMColors.light,
                            child: Column(
                              children: [
                                Text(
                                  "Choose a Currency",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "NGN and USD are supported for now",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        color: XMColors.gray,
                                      ),
                                ),
                                const SizedBox(height: 24),
                                // checkboxlist
                                RadioListTile(
                                  value: currency,
                                  groupValue: currency,
                                  onChanged: (currency) {
                                    setState(() {
                                      this.currency = "USD";
                                    });
                                  },
                                  activeColor: XMColors.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  selectedTileColor: XMColors.primary,
                                  dense: true,
                                  //font change
                                  title: Text(
                                    "United States Dollars (USD)",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Text(
                                      "1.00 USD = NGN 1.00",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: XMColors.gray_50,
                                          ),
                                    ),
                                  ),
                                  // value: true,
                                  secondary: const CircleAvatar(
                                    radius: 20,
                                    backgroundImage: NetworkImage(
                                      "https://upload.wikimedia.org/wikipedia/en/thumb/a/a4/Flag_of_the_United_States.svg/2560px-Flag_of_the_United_States.svg.png",
                                    ),
                                  ),
                                  // onChanged: (value) {},
                                ),
                                const SizedBox(height: 6),
                                RadioListTile(
                                  value: currency,
                                  groupValue: currency,
                                  onChanged: (currency) {
                                    setState(() {
                                      this.currency = "NGN";
                                    });
                                  },
                                  activeColor: XMColors.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  selectedTileColor: XMColors.primary,
                                  dense: true,
                                  //font change
                                  title: Text(
                                    "Canadian Dollar (CAD)",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Text(
                                      "1.00 CAD = NGN 1.00",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: XMColors.gray_50,
                                          ),
                                    ),
                                  ),
                                  secondary: const CircleAvatar(
                                    radius: 20,
                                    backgroundImage: NetworkImage(
                                      "https://www.worldatlas.com/img/flag/ca-flag.jpg",
                                    ),
                                  ),
                                  // onChanged: (value) {},
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: XMColors.gray_70,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.fromLTRB(15, 10, 13, 6),
                  child: Text(
                    getCurrency(_wallet.currency ?? 'NGXs'),
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
              ),
              const SizedBox(height: 38),
              divider,
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "Speed",
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    color: XMColors.gray,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "instant",
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "Fees",
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    color: XMColors.gray,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "3 USD, Incl.",
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "You'll Get",
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    color: XMColors.gray,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "117 USD",
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              divider,
              const SizedBox(height: 32),
              const Spacer(),
              RoundedButton(
                text: "Continue",
                isLoading: false,
                action: () {
                  checkFwSetup();
                  // fundWallet();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  final _publicAuth = Get.put(PublicAuth());
  checkFwSetup() async {
    try {
      final transactionService = TransactionService();

      String? url = await transactionService.createPaymentLink(
        amount.value.text,
        _wallet.currency ?? 'NGN',
      );
      print(url);
      if (url != null) {
        showModalBottomSheet(
            context: context,
            builder: (_) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.9,
                child: WebView(
                  initialUrl: url,
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (WebViewController webViewController) {
                    _controller.complete(webViewController);
                  },
                  onProgress: (int progress) {
                    print('WebView is loading (progress : $progress%)');
                  },
                  // javascriptChannels: <JavascriptChannel>{
                  //   _toasterJavascriptChannel(context),
                  // },
                  navigationDelegate: (NavigationRequest request) {
                    if (request.url.contains('https://webhook.se')) {
                      // verifyTransaction(reference);
                      Navigator.of(context).pop(); //close webview
                      print('success');
                    }
                    return NavigationDecision.navigate;
                    // if (request.url.startsWith('https://www.youtube.com/')) {
                    //   print('blocking navigation to $request}');
                    //   return NavigationDecision.prevent;
                    // }
                    // print('allowing navigation to $request');
                    // return NavigationDecision.navigate;
                  },
                  onPageStarted: (String url) {
                    print('Page started loading: $url');
                  },
                  onPageFinished: (String url) {
                    print('Page finished loading: $url');
                  },
                  gestureNavigationEnabled: true,
                  backgroundColor: const Color(0x00000000),
                ),
              );
            });
      } else {}
      // Get a reference to RavePayInitializer
      // var initializer = RavePayInitializer(
      //   amount: double.tryParse(amount.value.text),
      //   publicKey: 'FLWPUBK_TEST-9da57004452405fe95c857f569eac55f-X',
      //   encryptionKey: 'FLWSECK_TESTa381cd6deaa5',
      // )
      //   ..country = "NG"
      //   ..currency = "NGN"
      //   ..email = "customer@email.com"
      //   ..fName = "Ciroma"
      //   ..lName = "Adekunle"
      //   ..narration = 'narration'
      //   ..txRef = 'some_fake_shiiss'
      //   // ..subAccounts = subAccounts
      //   // ..acceptMpesaPayments = acceptMpesaPayment
      //   ..acceptAccountPayments = false
      //   ..acceptCardPayments = true
      //   ..acceptAchPayments = false
      //   ..acceptGHMobileMoneyPayments = _wallet.currency == 'GHS'
      //   ..acceptUgMobileMoneyPayments = true
      //   ..staging = true
      //   ..isPreAuth = false
      //   ..displayFee = true;

      // // Initialize and get the transaction result
      // RaveResult? response = await RavePayManager()
      //     .prompt(context: context, initializer: initializer);
      // print(response?.message);
      // print(response?.status);
      /*
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
        currency: _wallet.currency,
        redirectUrl: "my_redirect_url",
        txRef: "unique_transaction_reference",
        amount: amount.value.text,
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
       */
    } catch (err) {
      throw Exception(err);
    }
  }
}
