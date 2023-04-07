import 'package:flutter/material.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/presentation/widgets/widgets.dart';
import 'package:xendly_mobile/src/presentation/widgets/title_bar.dart';

class CurrencyTransactions extends StatefulWidget {
  const CurrencyTransactions({Key? key}) : super(key: key);
  @override
  State<CurrencyTransactions> createState() => _CurrencyTransactionsState();
}

class _CurrencyTransactionsState extends State<CurrencyTransactions> {
  @override
  Widget build(BuildContext context) {
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
              const TitleBar(
                title: "Transactions",
              ),
              const SizedBox(height: 30),
              // userTransactions(false, [], context),
            ],
          ),
        ),
      ),
    );
  }
}
