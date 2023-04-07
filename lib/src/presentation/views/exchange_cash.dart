import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/iconsax_icons.dart';
import 'package:xendly_mobile/src/domain/usecases/misc/get_rate_usecase.dart';
import 'package:xendly_mobile/src/domain/usecases/wallets/get_user_wallets_usecase.dart';
import 'package:xendly_mobile/src/presentation/view_model/misc/get_rate_controller.dart';
import 'package:xendly_mobile/src/presentation/view_model/wallets/get_user_wallets_controller.dart';
import 'package:xendly_mobile/src/presentation/widgets/inputs/exchange_field.dart';
import 'package:xendly_mobile/src/presentation/widgets/title_bar.dart';

import '../../config/routes.dart' as routes;
import '../../core/utilities/widgets/wallets_list.dart';

class ExchangeCash extends StatefulWidget {
  const ExchangeCash({Key? key}) : super(key: key);
  @override
  State<ExchangeCash> createState() => _ExchangeCashState();
}

class _ExchangeCashState extends State<ExchangeCash> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>(debugLabel: "exchange");

  final rateController = Get.put(
    RateController(Get.find<RateUsecase>()),
  );

  String? fromCurrency;
  String? toCurrency;
  var rate = 0.0;
  var parsedAmount = 0.0;

  void fetchRates(String from, String to) async {
    try {
      await rateController.getRate(from, to);
      setState(() => rate = double.parse(rateController.data['rate']));
    } catch (err) {
      debugPrint("error caught on rates - ${err.toString()}");
    }
  }

  final TextEditingController amountController = TextEditingController();

  final NumberFormat _formatter =
      NumberFormat.currency(decimalDigits: 2, symbol: "");

  @override
  void initState() {
    super.initState();
    amountController;
    fromCurrency = "NGN";
    toCurrency = "USD";
    // fromCurrency = Get.parameters['from_currency']!;
    // toCurrency = Get.parameters['to_currency']!;
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  String formNum(String s) {
    return NumberFormat.decimalPattern('en_US').format(
      double.parse(s),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    fetchRates(fromCurrency!, toCurrency!);

    const divider = Divider(
      thickness: 1,
      color: XMColors.shade4,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TitleBar(
                  title: "Exchange",
                  suffixIcon: Iconsax.arrow_swap_horizontal,
                  suffixColor: XMColors.none,
                ),
                const SizedBox(height: 46),

                // converting from
                Text(
                  "You are sending",
                  style: textTheme.bodyLarge?.copyWith(
                    color: XMColors.shade2,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 14),
                ExchangeField(
                  // currency: fromCurrency.toString(),
                  currency: Obx(
                    () => Text(
                      currencyController.fromCurrency.value,
                      style: textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: XMColors.shade6,
                      ),
                    ),
                  ),
                  changeCurrency: walletsList,
                  controller: amountController,
                  onChanged: (value) {
                    double amount = double.parse(
                      value.replaceAll(
                        ',',
                        '',
                      ),
                    );
                    setState(() => parsedAmount = amount);
                  },
                  color: amountController.text.isEmpty
                      ? XMColors.shade3
                      : XMColors.shade0,
                ),
                const SizedBox(height: 42),
                Row(
                  children: [
                    const Expanded(
                      child: divider,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Chip(
                        padding: const EdgeInsets.fromLTRB(8, 6, 8, 8),
                        backgroundColor: XMColors.primary0,
                        label: Text(
                          "${fromCurrency == 'NGN' ? '₦' : '\$'} 1 = ${toCurrency == 'NGN' ? '₦' : '\$'} ${rate.toString()}",
                          style: textTheme.bodyMedium?.copyWith(
                            color: XMColors.shade6,
                          ),
                        ),
                      ),
                    ),
                    const Expanded(
                      child: divider,
                    ),
                  ],
                ),
                const SizedBox(height: 42),
                Text(
                  "You are receiving",
                  style: textTheme.bodyLarge?.copyWith(
                    color: XMColors.shade2,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 14),
                ExchangeField(
                  hintText: _formatter.format(parsedAmount * rate).toString(),
                  currency: Obx(
                    () => Text(
                      currencyController.toCurrency.value,
                      style: textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: XMColors.shade6,
                      ),
                    ),
                  ),
                  changeCurrency: walletsList,
                  enabled: false,
                  color: amountController.text.isEmpty
                      ? XMColors.shade3
                      : XMColors.shade0,
                ),
                const Spacer(),
                ElevatedButton(
                  // onPressed: () => _submit(),
                  onPressed: () => Get.toNamed(routes.confirmSwap, parameters: {
                    "from_currency": currencyController.fromCurrency.value,
                    "from_amount": amountController.text,
                    "to_currency": currencyController.toCurrency.value,
                    "to_amount": (parsedAmount * rate).toString(),
                    "exchange_rate":
                        "${currencyController.fromCurrency.value == 'NGN' ? '₦' : '\$'} 1 = ${currencyController.toCurrency.value == 'NGN' ? '₦' : '\$'} ${rate.toString()}",
                  }),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.only(bottom: 2),
                    fixedSize: const Size(0, 64),
                  ),
                  child: Text(
                    "Continue",
                    style:
                        textTheme.bodyLarge?.copyWith(color: XMColors.shade6),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  final GetUserWalletsController getUserWalletsController = Get.put(
    GetUserWalletsController(
      Get.find<GetUserWalletsUseCase>(),
    ),
  );
  CurrencyController currencyController = Get.put(CurrencyController());

  String? selectedCurrency;

  walletsList() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        final walletOut = getUserWalletsController.data;
        return WalletsList(
          itemCount: walletOut.length,
          itemBuilder: (_, index) {
            final wallet = walletOut[index];
            return Obx(
              () {
                return getUserWalletsController.isLoading.value
                    ? const CupertinoActivityIndicator()
                    : ListTile(
                        onTap: () {
                          currencyController
                              .switchFromCurrencies(wallet['currency']);
                          Get.back();
                        },
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(
                            wallet["currency"] == "NGN"
                                ? "assets/images/ngn.png"
                                : "assets/images/usd.png",
                          ),
                          backgroundColor: XMColors.shade3,
                        ),
                        title: Text(
                          wallet["currency"] == "NGN"
                              ? "Nigerian Naira"
                              : "United States Dollar",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            wallet["currency"],
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: XMColors.shade3,
                                    ),
                          ),
                        ),
                        trailing: Text(
                          wallet["currency"] == "NGN"
                              ? NumberFormat.currency(
                                  locale: "en_NG",
                                  symbol: "\u20A6",
                                ).format(
                                  double.parse(wallet["balance"].toString()),
                                )
                              : NumberFormat.currency(
                                  locale: "en_US",
                                  symbol: "\u0024",
                                ).format(
                                  double.parse(wallet["balance"].toString()),
                                ),
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: XMColors.shade0,
                                  ),
                        ),
                      );
              },
            );
          },
        );
      },
    );
  }
}

class CurrencyController extends GetxController {
  var fromCurrency = "NGN".obs;
  var toCurrency = "USD".obs;

  void switchFromCurrencies(String currency) {
    fromCurrency.value = currency;

    if (fromCurrency.value == "NGN") {
      toCurrency.value = "USD";
    } else if (fromCurrency.value == "USD") {
      toCurrency.value = "NGN";
    }
  }
}
