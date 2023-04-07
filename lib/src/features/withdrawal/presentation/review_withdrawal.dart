import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xendly_mobile/src/config/theme.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/widgets/info_row.dart';
import 'package:xendly_mobile/src/presentation/view_model/wallets/bank_transfer_controller.dart';
import 'package:xendly_mobile/src/presentation/widgets/buttons/solid_button.dart';
import 'package:xendly_mobile/src/presentation/widgets/title_bar.dart';
import 'package:get/get.dart';

import '../../../domain/usecases/wallets/bank_transfer_usecase.dart';

class ConfirmWithdrawal extends StatefulWidget {
  const ConfirmWithdrawal({Key? key}) : super(key: key);

  @override
  State<ConfirmWithdrawal> createState() => _ConfirmWithdrawalState();
}

class _ConfirmWithdrawalState extends State<ConfirmWithdrawal> {
  String? accountName, accountNumber, bankCode, bankName, amount;

  final BankTransferController bankTransferController = Get.put(
    BankTransferController(Get.find<BankTransferUsecase>()),
  );

  Map<String, dynamic> data = {
    "amount": "",
    "account_name": "",
    "account_number": "",
    "bank_code": "",
    "bank_name": "",
  };

  makeTransfer() async {
    try {
      await bankTransferController.bankTransfer(data);
      print(data.toString());
    } catch (error) {
      Get.snackbar("Error", "Oops! Please try again!");
    }
  }

  @override
  void initState() {
    super.initState();
    amount = Get.parameters['amount']!;
    accountName = Get.parameters['account_name']!;
    accountNumber = Get.parameters['account_number']!;
    bankCode = Get.parameters['bank_code']!;
    bankName = Get.parameters['bank_name']!;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    data['amount'] = amount;
    data['account_name'] = accountName;
    data['account_number'] = accountNumber;
    data['bank_code'] = bankCode;
    data['bank_name'] = bankName;

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
                title: "Confirm Withdrawal",
              ),
              const SizedBox(height: 56),
              Text(
                "You are sending",
                style: textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: XMColors.gray,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                "$amount NGN",
                style: textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                "to",
                style: textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: XMColors.gray,
                ),
              ),
              const SizedBox(height: 48),
              infoRow(
                "Account Number",
                accountNumber!,
                XMColors.shade0,
                context,
              ),
              const SizedBox(height: 24),
              infoRow(
                "Account Name",
                accountName!.toLowerCase(),
                XMColors.shade0,
                context,
              ),
              const SizedBox(height: 24),
              infoRow(
                "Bank",
                bankName!.toLowerCase(),
                XMColors.shade0,
                context,
              ),
              const Spacer(),
              XnSolidButton(
                content: Obx(() {
                  return bankTransferController.isLoading.value
                      ? const CupertinoActivityIndicator()
                      : Text(
                    "Confirm",
                    style: textTheme.bodyLarge?.copyWith(
                      color: XMColors.shade6,
                      fontWeight: FontWeight.w500,
                    ),
                  );
                }),
                backgroundColor: XMColors.primary,
                action: () => makeTransfer(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
