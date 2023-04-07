import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/widgets/info_row.dart';
import 'package:xendly_mobile/src/presentation/widgets/notifications/snackbar.dart';
import 'package:xendly_mobile/src/presentation/widgets/title_bar.dart';
import 'package:get/get.dart';
import '../../../domain/usecases/wallets/exchange_usecase.dart';
import '../../../presentation/view_model/wallets/exchange_controller.dart';

class ConfirmSwap extends StatefulWidget {
  const ConfirmSwap({Key? key}) : super(key: key);
  @override
  State<ConfirmSwap> createState() => _ConfirmSwapState();
}

class _ConfirmSwapState extends State<ConfirmSwap> {
  String? fromCurrency, toCurrency, fromAmount, toAmount, exchangeRate;

  final exchangeController = Get.put(
    ExchangeController(Get.find<ExchangeUsecase>()),
  );

  Map<String, dynamic> data = {
    "amount": "",
    "from_currency": "",
    "to_currency": "",
  };

  void _submit() async {
    try {
      await exchangeController.exchange(data);
    } catch (err) {
      xnSnack(
        "Error",
        err.toString(),
        XMColors.error0,
        Icons.error_outline,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    fromCurrency = Get.parameters['from_currency']!;
    fromAmount = Get.parameters['from_amount']!;
    toCurrency = Get.parameters['to_currency']!;
    toAmount = Get.parameters['to_amount']!;
    exchangeRate = Get.parameters['exchange_rate']!;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    double parsedFromAmount = double.parse(fromAmount!.replaceAll(",", ""));
    String formattedFromAmount = parsedFromAmount.toStringAsFixed(2);
    double parsedToAmount = double.parse(toAmount!.replaceAll(",", ""));
    String formattedToAmount = parsedToAmount.toStringAsFixed(2);

    data['amount'] = formattedFromAmount;
    data['from_currency'] = fromCurrency;
    data['to_currency'] = toCurrency;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const TitleBar(
                title: "Confirm Swap",
              ),
              const SizedBox(height: 36),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'You are initiating a currency swap of ',
                  style: textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: XMColors.shade4,
                  ),
                  children: [
                    TextSpan(
                      text: '$fromCurrency$formattedFromAmount',
                      style: textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: XMColors.shade0,
                      ),
                    ),
                    TextSpan(
                      text: ' to ',
                      style: textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: XMColors.shade4,
                      ),
                    ),
                    TextSpan(
                      text: '$toCurrency$formattedToAmount',
                      style: textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: XMColors.shade0,
                      ),
                    ),
                    TextSpan(
                      text:
                          '. Please confirm the details below and click on proceed.',
                      style: textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: XMColors.shade4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 48),
              infoRow(
                "You Swap",
                "$fromCurrency$formattedFromAmount",
                // accountNumber!,
                XMColors.shade0,
                context,
              ),
              const SizedBox(height: 24),
              infoRow(
                "You Get",
                "$toCurrency$formattedToAmount",
                XMColors.shade0,
                context,
              ),
              const SizedBox(height: 24),
              infoRow(
                "Exchange Rate",
                exchangeRate!,
                XMColors.shade0,
                context,
              ),
              const SizedBox(height: 24),
              infoRow(
                "Fees",
                '5.00%',
                XMColors.shade0,
                context,
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () => _submit(),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.only(bottom: 2),
                  fixedSize: const Size(0, 64),
                ),
                child: Obx(
                  () {
                    return exchangeController.isLoading.value
                        ? const CupertinoActivityIndicator(
                            color: XMColors.shade6,
                          )
                        : Text(
                            "Swap Funds",
                            style: textTheme.bodyLarge
                                ?.copyWith(color: XMColors.shade6),
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
