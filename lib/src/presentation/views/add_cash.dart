import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/iconsax_icons.dart';
import 'package:xendly_mobile/src/domain/usecases/user/get_profile_usecase.dart';
import 'package:xendly_mobile/src/presentation/view_model/user/get_profile_controller.dart';
import 'package:xendly_mobile/src/presentation/widgets/buttons/solid_button.dart';
import 'package:xendly_mobile/src/presentation/widgets/dialogs/alert_dialog.dart';
import 'package:xendly_mobile/src/presentation/widgets/dual_texts.dart';
import 'package:xendly_mobile/src/presentation/widgets/title_bar.dart';

import '../../core/utilities/helpers/seerbit_checkout.dart';

class AddCash extends StatefulWidget {
  const AddCash({Key? key}) : super(key: key);
  @override
  State<AddCash> createState() => _AddCashState();
}

class _AddCashState extends State<AddCash> {
  final profileController = Get.put(
    GetProfileController(
      Get.find<GetProfileUsecase>(),
    ),
  );

  GlobalKey<FormState> formKey = GlobalKey<FormState>(debugLabel: "add_money");
  final TextEditingController amountController = TextEditingController();
  String? selectedWallet;
  Map<String, dynamic> data = {
    "amount": "",
  };

  initPayment() async {
    var uuid = const Uuid();
    final SeerbitData seerBitData = SeerbitData(
      publicKey: "SBTESTPUBK_AqEYhgPigjak5YkJ7h7P80IGO9vr4xcl",
      reference: "xen${uuid.v4().replaceAll('-', '')}",
      email: profileController.data['email'],
      amount: data['amount'],
      currency: selectedWallet!,
      fullName:
          "${profileController.data['first_name']} ${profileController.data['last_name']}",
    );
    seerbitCheckout(context, seerBitData);
  }

  void _submit() async {
    if (GetUtils.isNullOrBlank(amountController.text)!) {
      alertDialog(
        context,
        Iconsax.info_circle,
        "Invalid Amount",
        "Please provide a valid amount",
        () => Navigator.pop(context),
        XMColors.error0,
      );
    } else {
      final isValid = formKey.currentState!;
      if (isValid.validate()) {
        formKey.currentState!.save();
        try {
          initPayment();
        } catch (err) {
          Get.snackbar(
            "An error occurred",
            err.toString(),
          );
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    profileController.getProfile();
    selectedWallet = Get.arguments;
    amountController;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

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
              children: [
                const TitleBar(
                  title: "Fund Account",
                ),
                const SizedBox(height: 82),
                TextFormField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(7),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  controller: amountController,
                  onSaved: (value) {
                    data["amount"] = value!;
                  },
                  style: textTheme.headlineLarge!.copyWith(
                    color: XMColors.shade0,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(0),
                    isDense: true,
                    hintText: "0 $selectedWallet",
                    hintStyle: textTheme.headlineLarge!.copyWith(
                      color: XMColors.shade3,
                      fontWeight: FontWeight.w600,
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: XMColors.none,
                        width: 0,
                      ),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: XMColors.none,
                        width: 0,
                      ),
                    ),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: XMColors.none,
                        width: 0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  decoration: BoxDecoration(
                    color: XMColors.shade4,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: Text(
                    "$selectedWallet",
                    style: textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 82),
                const DualTexts(
                  title: "Transfer Speed",
                  value: "Instant",
                ),
                const SizedBox(height: 34),
                Text(
                  "Please not that the exchange rate is subject based on current market condition and trends.",
                  style: textTheme.bodyLarge?.copyWith(color: XMColors.shade3),
                ),
                const Spacer(),
                XnSolidButton(
                  content: Text(
                    "Continue",
                    style: textTheme.bodyLarge?.copyWith(
                      color: XMColors.shade6,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  backgroundColor: XMColors.primary,
                  action: () => _submit(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
