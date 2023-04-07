import 'package:flutter/material.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/config/utilities.dart';
import 'package:xendly_mobile/src/presentation/widgets/widgets.dart';
import 'package:xendly_mobile/src/presentation/widgets/widgets.dart';
import 'package:xendly_mobile/src/presentation/widgets/solid_button.dart';

class TransactionSuccess extends StatefulWidget {
  const TransactionSuccess({Key? key}) : super(key: key);
  @override
  State<TransactionSuccess> createState() => _TransactionSuccessState();
}

class _TransactionSuccessState extends State<TransactionSuccess> {
  TextEditingController textEditingController = TextEditingController();
  String currentText = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: XMColors.light,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              pageLabel("Transaction Complete", context),
              const Spacer(),
              // action icon
              const SizedBox(
                height: 24,
              ),
              heading(
                "Transaction Complete",
                XMColors.dark,
                22,
                TextAlign.center,
                FontWeight.w700,
              ),
              const SizedBox(
                height: 12,
              ),
              bodyText(
                "Your transfer to Jaardani Jovonovich was a complete success",
                XMColors.gray,
                FontWeight.w500,
                TextAlign.center,
              ),
              const Spacer(),
              SolidButton(
                text: "Continue",
                textColor: XMColors.light,
                buttonColor: XMColors.primary,
                action: () {},
              ),
              const SizedBox(height: 10),
              SolidButton(
                text: "Save the Reciept",
                textColor: XMColors.primary,
                buttonColor: XMColors.none,
                action: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
