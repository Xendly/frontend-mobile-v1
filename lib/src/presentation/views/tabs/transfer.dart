import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/presentation/widgets/new_title_bar.dart';

import '../../../config/routes.dart' as routes;

class SendMoney extends StatefulWidget {
  const SendMoney({Key? key}) : super(key: key);

  @override
  State<SendMoney> createState() => _SendMoneyState();
}

class _SendMoneyState extends State<SendMoney> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>(debugLabel: "send_money");
  GlobalKey<FormState> checkUsernameKey =
      GlobalKey<FormState>(debugLabel: "check_username");
  final TextEditingController amountController = TextEditingController();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController remarkController = TextEditingController();

  @override
  void initState() {
    super.initState();
    amountController;
    usernameController;
    remarkController;
  }

  @override
  void dispose() {
    super.dispose();
    amountController.dispose();
    usernameController.dispose();
    remarkController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: XMColors.shade6,
      extendBody: true,
      appBar: const NewTitleBar(
        title: "Transfer",
        suffix: Icon(
          Icons.swap_vertical_circle_rounded,
          size: 26,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 16,
        ),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => Get.toNamed(routes.withdrawal),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: XMColors.primary,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    padding: const EdgeInsets.all(14),
                    child: const Icon(
                      Icons.credit_card,
                      size: 20,
                      color: XMColors.shade6,
                    ),
                  ),
                  const SizedBox(width: 18),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Send to a bank account",
                        style: textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          "Transfer funds directly to your bank",
                          style: textTheme.bodyMedium?.copyWith(
                            color: XMColors.shade2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 26),
            GestureDetector(
              onTap: () => Get.toNamed(routes.transferDetails),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: XMColors.primary,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    padding: const EdgeInsets.all(14),
                    child: const Icon(
                      Icons.tag,
                      size: 20,
                      color: XMColors.shade6,
                    ),
                  ),
                  const SizedBox(width: 18),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Send to a another user",
                        style: textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          "Transfer funds to friends instantly",
                          style: textTheme.bodyMedium?.copyWith(
                            color: XMColors.shade2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
