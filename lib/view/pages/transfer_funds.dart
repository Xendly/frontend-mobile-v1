import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xendly_mobile/view/shared/colors.dart';
import 'package:xendly_mobile/view/shared/widgets.dart';
import 'package:xendly_mobile/view/shared/widgets/dropdown_input.dart';
import 'package:xendly_mobile/view/shared/widgets/inputs/plain_dropdown_input.dart';
import 'package:xendly_mobile/view/shared/widgets/inputs/plain_input.dart';
import 'package:xendly_mobile/view/shared/widgets/safe_area.dart';
import 'package:xendly_mobile/view/shared/widgets/solid_button.dart';
import 'package:xendly_mobile/view/shared/routes.dart' as routes;

class TransferFunds extends StatefulWidget {
  const TransferFunds({Key? key}) : super(key: key);
  @override
  State<TransferFunds> createState() => _TransferFundsState();
}

class _TransferFundsState extends State<TransferFunds> {
  String? _currencyTypeValue;
  List<DropdownMenuItem<String>> get currencyType {
    List<DropdownMenuItem<String>> currencyTypeItems = [
      const DropdownMenuItem(
        child: Text("Birkin Hermes"),
        value: "Birkin Hermes",
      ),
      const DropdownMenuItem(
        child: Text("Louis Vuitton"),
        value: "Louis Vuitton",
      ),
      const DropdownMenuItem(
        child: Text("Christian Dior"),
        value: "Christian Dior",
      ),
    ];
    return currencyTypeItems;
  }

  @override
  Widget build(BuildContext context) {
    return CustomSafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            pageLabel("Transfer to Jardaani Jovonovich", context),
            const SizedBox(height: 26),
            Container(
              decoration: BoxDecoration(
                color: XMColors.none,
                border: Border.all(
                  color: XMColors.dark,
                ),
              ),
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 19),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      bodyText("Transfer From:"),
                      bodyText("United States Dollars"),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Divider(),
                  const SizedBox(height: 14),
                  bodyText("You are sending:"),
                  const SizedBox(height: 6),
                  heading(
                    "-\$65,483.48",
                    XMColors.dark,
                    28,
                  ),
                  const SizedBox(height: 14),
                  const Divider(),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      bodyText("Wallet Balance (USD):"),
                      bodyText("358,241.97 USD"),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: XMColors.primary,
                borderRadius: BorderRadius.circular(50),
              ),
              child: SvgPicture.asset(
                "assets/icons/arrow-swap.svg",
                width: 26,
                height: 26,
                color: XMColors.light,
              ),
            ),
            const SizedBox(height: 28),
            Container(
              decoration: BoxDecoration(
                color: XMColors.none,
                border: Border.all(
                  color: XMColors.dark,
                ),
              ),
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 19),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      bodyText("Transfer To:"),
                      bodyText("United States Dollars"),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Divider(),
                  const SizedBox(height: 14),
                  bodyText("Jardaani will receive:"),
                  const SizedBox(height: 6),
                  heading(
                    "+\$65,383.48",
                    XMColors.dark,
                    28,
                  ),
                  const SizedBox(height: 14),
                  const Divider(),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      bodyText("Transaction Fee:"),
                      bodyText("1,000 USD"),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                bodyText(
                  "Exchange Rate:",
                  XMColors.gray,
                  FontWeight.w600,
                ),
                bodyText(
                  "USD 1 = NGN 650",
                  XMColors.dark,
                  FontWeight.w600,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                bodyText(
                  "Delivery Time:",
                  XMColors.gray,
                  FontWeight.w600,
                ),
                bodyText(
                  "15 Minutes",
                  XMColors.dark,
                  FontWeight.w600,
                ),
              ],
            ),
            const SizedBox(height: 32),
            SolidButton(
              text: "Transfer \$65,383",
              textColor: XMColors.light,
              buttonColor: XMColors.primary,
              action: () => {
                Navigator.pushNamed(
                  context,
                  routes.confirmTransaction,
                )
              },
            ),
          ],
        ),
      ),
    );
  }
}
