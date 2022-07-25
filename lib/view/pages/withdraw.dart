import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterwave_standard/core/flutterwave.dart';
import 'package:flutterwave_standard/flutterwave.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:xendly_mobile/controller/core/public_auth.dart';
import 'package:xendly_mobile/controller/core/user_auth.dart';
import 'package:xendly_mobile/view/shared/colors.dart';
import 'package:xendly_mobile/view/shared/widgets/buttons/rounded.dart';
import 'package:xendly_mobile/view/shared/widgets/page_title.dart';
import 'package:xendly_mobile/view/shared/routes.dart' as routes;

class Withdraw extends StatefulWidget {
  const Withdraw({Key? key}) : super(key: key);
  @override
  State<Withdraw> createState() => _WithdrawState();
}

class _WithdrawState extends State<Withdraw> {
  String currency = 0.toString();
  bool? curVal = false;

  GlobalKey<FormState> formKey =
      GlobalKey<FormState>(debugLabel: "_WithdrawKey");

  final TextEditingController amount = TextEditingController();

  Map<String, dynamic> data = {
    "amount": "",
  };

  void onInit() {
    super.initState();
    amount;
    currency;
  }

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
                title: "Withdraw Cash",
                prefixIconColor: XMColors.dark,
                prefixIconAction: () => Get.back(),
              ),
              const SizedBox(height: 38),
              Text(
                "Only NGN available",
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: XMColors.gray,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 6),
              Text(
                "10,500 NGN",
                style: Theme.of(context).textTheme.headline2!.copyWith(
                      color: XMColors.primary_20,
                    ),
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: XMColors.gray_70,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.fromLTRB(15, 10, 13, 6),
                child: Text(
                  "Nigerian Naira",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
              const SizedBox(height: 48),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Transfer Speed",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: XMColors.gray,
                        ),
                  ),
                  Text(
                    "Instant",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
              const SizedBox(height: 14),
              divider,
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Transfer Fees",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: XMColors.gray,
                        ),
                  ),
                  Text(
                    "80%",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
              const SizedBox(height: 14),
              divider,
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "You'll Receive",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: XMColors.gray,
                        ),
                  ),
                  Text("500 NGN", style: Theme.of(context).textTheme.bodyText1),
                ],
              ),
              const SizedBox(height: 14),
              divider,
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Bank Account",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: XMColors.gray,
                        ),
                  ),
                  Text("****9045, First Bank",
                      style: Theme.of(context).textTheme.bodyText1),
                ],
              ),
              const SizedBox(height: 14),
              divider,
              const Spacer(),
              RoundedButton(
                text: "Continue",
                action: () {
                  showDialog(
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
                      return Dialog(
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
                              const CupertinoActivityIndicator
                                  .partiallyRevealed(),
                              const SizedBox(
                                height: 25,
                              ),
                              Text(
                                "Transaction Successful",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Your transaction to Bruce Banner is complete. Transaction ID is 123456789",
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: XMColors.gray_50,
                                    ),
                              ),
                              const SizedBox(height: 14),
                              RoundedButton(
                                text: "Finish",
                                action: () {
                                  Get.toNamed(routes.home);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
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
