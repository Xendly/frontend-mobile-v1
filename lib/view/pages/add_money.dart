import 'package:flutter/material.dart';
import 'package:flutterwave_standard/core/flutterwave.dart';
import 'package:flutterwave_standard/flutterwave.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:xendly_mobile/controller/core/public_auth.dart';
import 'package:xendly_mobile/controller/core/user_auth.dart';
import 'package:xendly_mobile/view/shared/colors.dart';
import 'package:xendly_mobile/view/shared/widgets/buttons/rounded.dart';
import 'package:xendly_mobile/view/shared/widgets/page_title.dart';

class AddMoney extends StatefulWidget {
  const AddMoney({Key? key}) : super(key: key);
  @override
  State<AddMoney> createState() => _AddMoneyState();
}

class _AddMoneyState extends State<AddMoney> {
  String currency = 0.toString();
  bool? curVal = false;

  // final String currency = "NGN";

  GlobalKey<FormState> formKey =
      GlobalKey<FormState>(debugLabel: "_addMoneyKey");

  final TextEditingController amount = TextEditingController();

  Map<String, dynamic> data = {
    "amount": "",
  };

  void onInit() {
    super.initState();
    amount;
    currency;
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
                "Fund USD wallet",
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: XMColors.gray,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 6),
              Text(
                "120.62 USD",
                style: Theme.of(context).textTheme.headline2!.copyWith(
                      color: XMColors.primary_20,
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
                    "Canadian Dollars",
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
                action: () {
                  fundWallet();
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
