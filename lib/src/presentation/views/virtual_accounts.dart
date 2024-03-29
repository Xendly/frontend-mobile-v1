import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/config/utilities.dart';
import 'package:xendly_mobile/src/presentation/widgets/widgets.dart';
import 'package:xendly_mobile/src/presentation/widgets/widgets.dart';
import 'package:xendly_mobile/src/presentation/widgets/bottomSheet.dart';
import 'package:xendly_mobile/src/presentation/widgets/buttons/rounded.dart';
import 'package:xendly_mobile/src/presentation/widgets/dropdown_input.dart';
import 'package:xendly_mobile/src/presentation/widgets/page_title.dart';
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
import 'package:xendly_mobile/src/data/services/accounts_service.dart';
import 'package:xendly_mobile/src/data/services/beneficiary_auth.dart';
import 'package:xendly_mobile/src/data/services/public_auth.dart';
import 'package:xendly_mobile/src/data/services/transaction_service.dart';
import 'package:xendly_mobile/src/data/services/user_auth.dart';
import 'package:xendly_mobile/src/data/services/wallet_auth.dart';
import '../../config/routes.dart' as routes;

class VirtualAccounts extends StatefulWidget {
  const VirtualAccounts({Key? key}) : super(key: key);
  @override
  State<VirtualAccounts> createState() => _VirtualAccountsState();
}

class _VirtualAccountsState extends State<VirtualAccounts> {
  // === CONTROLLER === //
  final _accountsService = Get.put(AccountsService());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController? bvnController = TextEditingController();

  Map<String, dynamic> data = {
    "bvn": "",
  };

  void onInit() {
    super.initState();
    bvnController;
  }

  String? validateBvn(String value) {
    if (GetUtils.isNullOrBlank(value)!) {
      return "Enter your BVN";
    } else if (!GetUtils.isNumericOnly(value)) {
      return "BVN must contain only digits";
    } else if (GetUtils.isLengthLessThan(value, 11)) {
      return "BVN must contain 11 characters";
    } else {
      return null;
    }
  }

  void createVirtualAccount() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      printInfo(info: "some fields are invalid");
    } else {
      printInfo(info: "all fields are valid");
      formKey.currentState!.save();
      try {
        final result = await _accountsService.createVirtualAccount(data);
        if (result["statusCode"] == 200) {
          printInfo(info: "virtual account created");
          Get.back();
        } else {
          printInfo(
              info: "virtual account not created >>> ${result["message"]}");
        }
      } catch (err) {
        printInfo(info: "an error occured");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 24,
            ),
            child: Column(
              children: [
                PageTitleIcons(
                  prefixIcon: "assets/icons/bold/icl-arrow-left-2.svg",
                  title: "Virtual Accounts",
                  prefixIconColor: XMColors.dark,
                  prefixIconAction: () => Get.back(),
                ),
                const SizedBox(height: 22),
                const Align(
                  alignment: Alignment.center,
                  child: Text("You don't have any virtual accounts yet."),
                ),
                const SizedBox(height: 22),
                RoundedButton(
                  text: "Create a Virtual Account",
                  action: () => {
                    showModalBottomSheet(
                        context: context,
                        builder: (
                          BuildContext context,
                        ) {
                          return Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            alignment: WrapAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 38,
                                ),
                                child: Form(
                                  key: formKey,
                                  child: Column(
                                    children: [
                                      Text(
                                        "Create a Virtual Account",
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1!
                                            .copyWith(
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                      const SizedBox(height: 12),
                                      Text(
                                        "Get access to a virtual account that you can use to pay for your bills and other services.",
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                              color: XMColors.gray,
                                            ),
                                      ),
                                      const SizedBox(height: 26),
                                      TextInput(
                                        readOnly: false,
                                        label:
                                            "Bank Vertificaiton Number (BVN)",
                                        hintText: "12345678901",
                                        inputType: TextInputType.number,
                                        borderRadius: BorderRadius.circular(10),
                                        controller: bvnController,
                                        onSaved: (value) => data["bvn"] = value,
                                        validator: (value) =>
                                            validateBvn(value!),
                                      ),
                                      const SizedBox(height: 20),
                                      RoundedButton(
                                        text: "Create Virtual Account",
                                        action: () => {
                                          // if()
                                          createVirtualAccount(),
                                          // Get.back(),
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        })
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
