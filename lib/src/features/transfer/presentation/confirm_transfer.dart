import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/widgets/info_row.dart';
import 'package:xendly_mobile/src/presentation/widgets/title_bar.dart';

import '../../../core/utilities/helpers/validator_helper.dart';
import '../../../domain/usecases/auth/verify_pin_usecase.dart';
import '../../../domain/usecases/wallets/p2p_transfer_usecase.dart';
import '../../../presentation/view_model/auth/verify_pin_controller.dart';
import '../../../presentation/view_model/wallets/p2p_transfer_controller.dart';
import '../../../presentation/widgets/notifications/snackbar.dart';

class ConfirmTransfer extends StatefulWidget {
  const ConfirmTransfer({Key? key}) : super(key: key);
  @override
  State<ConfirmTransfer> createState() => _ConfirmTransferState();
}

class _ConfirmTransferState extends State<ConfirmTransfer> {
  String? username,
      fullName,
      beneficiary,
      amount,
      narration,
      saveBeneficiary,
      currency;

  final P2PTransferController p2pTransferController = Get.put(
    P2PTransferController(Get.find<P2PTransferUsecase>()),
  );

  Map<String, dynamic> data = {
    "beneficiary": "",
    "amount": "",
    "remark": "",
    "currency": "",
    "save_beneficiary": "",
  };

  @override
  void initState() {
    super.initState();
    username = Get.parameters['username']!;
    fullName = Get.parameters['full_name']!;
    beneficiary = Get.parameters['beneficiary']!;
    amount = Get.parameters['amount']!;
    narration = Get.parameters['narration']!;
    saveBeneficiary = Get.parameters['save_beneficiary']!;
    currency = Get.parameters['currency']!;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    data['amount'] = amount;
    data['beneficiary'] = beneficiary;
    data['remark'] = narration;
    data['currency'] = currency;
    data['save_beneficiary'] = saveBeneficiary;

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
                title: "Confirm Transfer",
              ),
              const SizedBox(height: 56),
              Text(
                "You are sending",
                style: textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: XMColors.gray,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "$amount$currency",
                style: textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "to",
                style: textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: XMColors.gray,
                ),
              ),
              const SizedBox(height: 48),
              infoRow(
                "Name",
                "$fullName",
                XMColors.shade0,
                context,
              ),
              const SizedBox(height: 24),
              infoRow(
                "Username",
                "$username",
                XMColors.shade0,
                context,
              ),
              const SizedBox(height: 24),
              infoRow(
                "Fees",
                "None",
                XMColors.shade0,
                context,
              ),
              const SizedBox(height: 24),
              infoRow(
                "Transfer Speed",
                "Instant",
                XMColors.shade0,
                context,
              ),
              const SizedBox(height: 24),
              infoRow(
                "Note",
                "$narration",
                XMColors.shade0,
                context,
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () => transactionPin(),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.only(bottom: 2),
                  fixedSize: const Size(0, 64),
                ),
                child: Text(
                  "Continue",
                  style: textTheme.bodyLarge?.copyWith(color: XMColors.shade6),
                ),
              ),
              // ElevatedButton(
              //   onPressed: () => _transfer(),
              //   style: ElevatedButton.styleFrom(
              //     padding: const EdgeInsets.only(bottom: 2),
              //     fixedSize: const Size(0, 64),
              //   ),
              //   child: Obx(
              //     () {
              //       return p2pTransferController.isLoading.value
              //           ? const CupertinoActivityIndicator(
              //               color: XMColors.shade6,
              //             )
              //           : Text(
              //               "Confirm",
              //               style: textTheme.bodyLarge
              //                   ?.copyWith(color: XMColors.shade6),
              //             );
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  transactionPin() {
    final textTheme = Theme.of(context).textTheme;
    final VerifyPinController verifyPin = Get.put(
      VerifyPinController(
        Get.find<VerifyPinUseCase>(),
      ),
    );
    GlobalKey<FormState> formKey =
        GlobalKey<FormState>(debugLabel: "enter_pin");
    TextEditingController pinController = TextEditingController();
    Map<String, dynamic> pinData = {
      "pin": "",
    };

    void confirmTransaction() async {
      final isValid = formKey.currentState!.validate();
      if (isValid) {
        formKey.currentState!.save();
        try {
          await verifyPin.verifyPin(pinData);
          if (verifyPin.message.value == "Transaction pin verified") {
            try {
              await p2pTransferController.p2pTransfer(data);
            } catch (err) {
              xnSnack(
                "Error",
                err.toString(),
                XMColors.error0,
                Icons.error_outline,
              );
            }
          }
        } catch (error) {
          Get.snackbar("An error occurred", error.toString());
        }
      }
    }

    showDialog(
        context: context,
        builder: (context) {
          return Scaffold(
            backgroundColor: XMColors.light,
            extendBody: true,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 24,
                  horizontal: 18,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TitleBar(
                      title: "Transaction Pin",
                    ),
                    const SizedBox(height: 34),
                    Form(
                      key: formKey,
                      child: PinCodeTextField(
                        length: 4,
                        appContext: context,
                        textStyle: textTheme.titleMedium?.copyWith(
                          color: XMColors.shade1,
                        ),
                        cursorColor: XMColors.primary,
                        cursorHeight: 17,
                        controller: pinController,
                        onSaved: (value) => pinData["pin"] = value,
                        validator: (value) => validatePin(value!),
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(8),
                          fieldWidth: 80,
                          fieldHeight: 56,
                          activeColor: XMColors.shade4,
                          selectedColor: XMColors.primary,
                          inactiveColor: XMColors.shade4,
                          activeFillColor: XMColors.shade6,
                          selectedFillColor: XMColors.shade6,
                        ),
                        enablePinAutofill: true,
                        keyboardType: TextInputType.number,
                        onChanged: (String value) {},
                      ),
                    ),
                    const SizedBox(height: 22),
                    ElevatedButton(
                      onPressed: () => confirmTransaction(),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.only(bottom: 2),
                        fixedSize: const Size(0, 64),
                      ),
                      child: Text(
                        verifyPin.isLoading.value
                            ? "Processing..."
                            : "Continue",
                        style: textTheme.bodyLarge?.copyWith(
                          color: XMColors.shade6,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
