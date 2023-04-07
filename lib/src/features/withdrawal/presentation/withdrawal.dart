import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xendly_mobile/src/core/utilities/helpers/validator_helper.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/domain/usecases/misc/get_acct_info_usecase.dart';
import 'package:xendly_mobile/src/domain/usecases/misc/get_banks_list_usecase.dart';
import 'package:xendly_mobile/src/features/withdrawal/presentation/logic/get_account_info_controller.dart';
import 'package:xendly_mobile/src/features/withdrawal/presentation/logic/get_banks_list_controller.dart';
import 'package:xendly_mobile/src/presentation/widgets/buttons/solid_button.dart';
import 'package:xendly_mobile/src/presentation/widgets/inputs/xn_text_field.dart';
import 'package:xendly_mobile/src/presentation/widgets/title_bar.dart';

import '../../../config/routes.dart' as routes;

class Withdrawal extends StatefulWidget {
  const Withdrawal({Key? key}) : super(key: key);
  @override
  State<Withdrawal> createState() => _WithdrawalState();
}

class _WithdrawalState extends State<Withdrawal> {
  GlobalKey<FormState> formKey =
      GlobalKey<FormState>(debugLabel: "create_payout_account");
  TextEditingController numberController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  final GetBanksListController controller = Get.put(
    GetBanksListController(
      Get.find<GetBanksListUsecase>(),
    ),
  );

  final GetAcctInfoController acctInfoController = Get.put(
    GetAcctInfoController(
      Get.find<GetAcctInfoUsecase>(),
    ),
  );

  Map<String, dynamic> data = {
    "account_number": "",
    "bank_code": "",
  };

  Map<String, dynamic> bankTransferData = {
    "amount": "",
    "account_name": "",
    "account_number": "",
    "bank_code": "",
    "bank_name": "",
  };

  void _resolveAccount() async {
    final isValid = formKey.currentState!.validate();
    if (isValid) {
      formKey.currentState!.save();
      try {
        await acctInfoController.getAccountInfo(data);
        setState(() {
          acctName = acctInfoController.response['account_name'];
        });
      } catch (error) {
        debugPrint("error caught - ${error.toString()}");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    numberController;
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
                  title: "Account Information",
                ),
                const SizedBox(height: 46),
                GestureDetector(
                  onTap: _banksDialog,
                  child: ValueListenableBuilder(
                    valueListenable: bankNotifier,
                    builder: (context, value, _) {
                      return XnTextField(
                        label: selectedBank ?? "Bank",
                        keyboardType: TextInputType.text,
                        enabled: false,
                        readOnly: true,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),
                XnTextField(
                  label: "Account Number",
                  keyboardType: TextInputType.number,
                  controller: numberController,
                  onSaved: (value) {
                    data["account_number"] = value!;
                    data["bank_code"] = selectedBankCode;
                  },
                  validator: (value) => validateAcctNo(value!),
                ),
                const SizedBox(height: 24),
                GestureDetector(
                  onTap: () => _resolveAccount(),
                  child: XnTextField(
                    label: acctName ?? "Retrieve account name",
                    keyboardType: TextInputType.text,
                    enabled: false,
                    readOnly: true,
                    filled: true,
                  ),
                ),
                const SizedBox(height: 24),
                XnTextField(
                  label: "Amount",
                  keyboardType: TextInputType.number,
                  controller: amountController,
                  onSaved: (value) {
                    bankTransferData["amount"] = amountController?.text!;
                  },
                  // validator: (value) => vali(value!),
                ),
                const SizedBox(height: 26),
                // change submit button to final submission after resolving
                XnSolidButton(
                  content: Obx(() {
                    return acctInfoController.isLoading.value
                        ? Text(
                            "Retrieving Account...",
                            style: textTheme.bodyText1?.copyWith(
                              color: XMColors.shade6,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        : Text(
                            "Continue",
                            style: textTheme.bodyText1?.copyWith(
                              color: XMColors.shade6,
                              fontWeight: FontWeight.w500,
                            ),
                          );
                  }),
                  backgroundColor: XMColors.primary,
                  // action: () => _resolveAccount(),
                  action: () => Get.toNamed(
                    routes.confirmWithdrawal,
                    parameters: {
                      "amount": amountController.text,
                      "account_name": acctName!,
                      "account_number": data["account_number"],
                      "bank_code": data["bank_code"],
                      "bank_name": selectedBank!,
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  final ValueNotifier<String?> bankNotifier = ValueNotifier("");
  final ValueNotifier<String?> acctNameNotifier = ValueNotifier("");

  List allBanks = [];
  List filteredBanks = [];

  String? acctName;

  _banksDialog() async {
    controller.getBanksList();

    setState(() {
      allBanks = controller.data;
    });

    showDialog(
      context: context,
      builder: (context) {
        final screenSize = MediaQuery.of(context).size;
        final textTheme = Theme.of(context).textTheme;

        return StatefulBuilder(
          builder: (context, StateSetter setState) {
            void filterBanks(String keyword) {
              List results = [];
              if (keyword.isEmpty) {
                results = allBanks;
              } else {
                results = allBanks
                    .where(
                      (bank) => bank['bankname'].toLowerCase().contains(
                            keyword.toLowerCase(),
                          ),
                    )
                    .toList();
              }

              setState(() {
                filteredBanks = results;
              });
            }

            return Scaffold(
              body: SizedBox(
                height: screenSize.height,
                child: Obx(
                  () {
                    return controller.isLoading.value
                        ? const CupertinoActivityIndicator()
                        : Column(
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.fromLTRB(22, 24, 22, 30),
                                decoration: const BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: XMColors.shade4,
                                      spreadRadius: 2.0,
                                      blurRadius: 2.4,
                                    ),
                                  ],
                                  color: XMColors.shade6,
                                ),
                                child: Column(
                                  children: [
                                    const Text("Banks"),
                                    const SizedBox(height: 18),
                                    XnTextField(
                                      label: "Find your bank",
                                      keyboardType: TextInputType.text,
                                      icon: Icons.search,
                                      iconColor: XMColors.shade2,
                                      onChanged: (value) => filterBanks(value!),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: ListView.separated(
                                  itemCount: filteredBanks.isEmpty
                                      ? allBanks.length
                                      : filteredBanks.length,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 32,
                                    horizontal: 22,
                                  ),
                                  physics: const BouncingScrollPhysics(),
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(height: 24);
                                  },
                                  itemBuilder: (context, index) {
                                    if (filteredBanks.isEmpty) {
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedBank = allBanks[index]
                                                    ['bankname']
                                                .toString();
                                            selectedBankCode =
                                                allBanks[index]['cbnbankcode'];
                                            bankNotifier.value = selectedBank;
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          allBanks[index]['bankname']
                                              .toString(),
                                          style: textTheme.bodyText1?.copyWith(
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      );
                                    } else {
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedBank = filteredBanks[index]
                                                    ['bankname']
                                                .toString();
                                            selectedBankCode =
                                                filteredBanks[index]
                                                    ['cbnbankcode'];
                                            bankNotifier.value = selectedBank;
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          filteredBanks[index]['bankname']
                                              .toString(),
                                          style: textTheme.bodyText1?.copyWith(
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ],
                          );
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }

  String? selectedBank;
  String? selectedBankCode;
}
