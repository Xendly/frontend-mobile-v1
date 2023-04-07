import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/presentation/widgets/dual_texts.dart';
import 'package:xendly_mobile/src/presentation/widgets/title_bar.dart';
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

class TransactionReceipt extends StatefulWidget {
  const TransactionReceipt({Key? key}) : super(key: key);
  @override
  State<TransactionReceipt> createState() => _TransactionReceiptState();
}

class _TransactionReceiptState extends State<TransactionReceipt> {
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 24,
          ),
          child: Column(
            children: [
              const TitleBar(
                title: "Transaction Receipt",
              ),
              const SizedBox(height: 46),
              CircleAvatar(
                radius: 32,
                backgroundColor: XMColors.red.withOpacity(0.1),
                child: const Icon(
                  FlutterRemix.arrow_right_up_line,
                  size: 38,
                  color: XMColors.red,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "To Anthony Stark",
                style: Theme.of(context).textTheme.headline5?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                "You sent 1,000,000 USD",
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      color: XMColors.gray,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 44),
              const DualTexts(
                title: "Sent From",
                value: "USD Account",
              ),
              divider,
              const DualTexts(
                title: "Transferred To",
                value: "John Wick",
              ),
              divider,
              const DualTexts(
                title: "Amount Sent",
                value: "6,000 USD",
              ),
              divider,
              const DualTexts(
                title: "Transaction Date",
                value: "Mon, Aug 1, 2022",
              ),
              divider,
              const DualTexts(
                title: "Transaction Fees",
                value: "0%, Non Incl.",
              ),
              divider,
              const DualTexts(
                title: "Transaction ID",
                value: "#4357890",
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  "Download Receipt",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: XMColors.light,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
