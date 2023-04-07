import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/config/utilities.dart';
import 'package:xendly_mobile/src/presentation/widgets/widgets.dart';
import 'package:xendly_mobile/src/presentation/widgets/widgets.dart';
import 'package:xendly_mobile/src/presentation/widgets/bottomSheet.dart';
import 'package:xendly_mobile/src/presentation/widgets/buttons/rounded.dart';
import 'package:xendly_mobile/src/presentation/widgets/dropdown_input.dart';
import 'package:xendly_mobile/src/presentation/widgets/safe_area.dart';
import 'package:xendly_mobile/src/presentation/widgets/solid_button.dart';
import 'package:xendly_mobile/src/presentation/widgets/tabPage_title.dart';
import 'package:xendly_mobile/src/presentation/widgets/text_input.dart';
import 'package:xendly_mobile/src/presentation/widgets/title_bar.dart';
import 'package:xendly_mobile/src/presentation/widgets/wallets_item.dart';
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
import '../../config/routes.dart' as routes;

class ConfirmTransaction extends StatefulWidget {
  const ConfirmTransaction({Key? key}) : super(key: key);
  @override
  State<ConfirmTransaction> createState() => _ConfirmTransactionState();
}

class _ConfirmTransactionState extends State<ConfirmTransaction> {
  @override
  Widget build(BuildContext context) {
    return CustomSafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            pageLabel("Confirm Transaction", context),
            const SizedBox(height: 26),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    bodyText("Sending:"),
                    const SizedBox(height: 2),
                    heading(
                      "\$68,638.05",
                      XMColors.dark,
                      22,
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: XMColors.primary,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: SvgPicture.asset(
                    "assets/icons/arrow-right-1.svg",
                    width: 22,
                    height: 22,
                    color: XMColors.light,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    bodyText("Receiving:"),
                    const SizedBox(height: 2),
                    heading(
                      "\$68,638.05",
                      XMColors.dark,
                      22,
                    ),
                  ],
                ),
              ],
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
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                bodyText(
                  "Transaction Fee:",
                  XMColors.gray,
                  FontWeight.w600,
                ),
                bodyText(
                  "1,000 USD",
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
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                bodyText(
                  "Name:",
                  XMColors.gray,
                  FontWeight.w600,
                ),
                bodyText(
                  "Jardaani Jovonovich",
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
                  "Email:",
                  XMColors.gray,
                  FontWeight.w600,
                ),
                bodyText(
                  "jardaaniwick@gmail.com",
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
                  "Currency:",
                  XMColors.gray,
                  FontWeight.w600,
                ),
                bodyText(
                  "Canadian Dollar (CAD)",
                  XMColors.dark,
                  FontWeight.w600,
                ),
              ],
            ),
            const SizedBox(height: 32),
            SolidButton(
              text: "Confirm Transaction",
              textColor: XMColors.light,
              buttonColor: XMColors.primary,
              action: () => {
                Navigator.pushNamed(
                  context,
                  routes.enterPIN,
                )
              },
            ),
          ],
        ),
      ),
    );
  }
}
