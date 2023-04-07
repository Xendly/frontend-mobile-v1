import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xendly_mobile/src/core/utilities/helpers/validator_helper.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/presentation/view_model/beneficiaries/create_bank_beneficiary_controller.dart';
import 'package:xendly_mobile/src/presentation/widgets/buttons/solid_button.dart';
import 'package:xendly_mobile/src/presentation/widgets/title_bar.dart';
import 'package:xendly_mobile/src/presentation/widgets/inputs/xn_text_field.dart';
import 'package:xendly_mobile/src/domain/usecases/misc/get_banks_usecase.dart';
import 'package:xendly_mobile/src/presentation/view_model/misc/get_banks_controller.dart';
import 'package:xendly_mobile/src/domain/usecases/misc/resolve_account_usecase.dart';
import 'package:xendly_mobile/src/domain/usecases/beneficiaries/create_bank_beneficiary_usecase.dart';
import 'package:xendly_mobile/src/presentation/view_model/misc/resolve_account_controller.dart';

class CreatePayoutAccount extends StatefulWidget {
  const CreatePayoutAccount({Key? key}) : super(key: key);
  @override
  State<CreatePayoutAccount> createState() => _CreatePayoutAccountState();
}

class _CreatePayoutAccountState extends State<CreatePayoutAccount> {
  GlobalKey<FormState> formKey =
      GlobalKey<FormState>(debugLabel: "create_payout_account");
  TextEditingController? numberController = TextEditingController();

  final GetBanksController controller = Get.put(
    GetBanksController(
      Get.find<GetBanksUsecase>(),
    ),
  );

  final ResolveAccountController resolveController = Get.put(
    ResolveAccountController(
      Get.find<ResolveAccountUsecase>(),
    ),
  );

  final CreateBankBeneficiaryController createBankBeneficiaryController =
      Get.put(
    CreateBankBeneficiaryController(
      Get.find<CreateBankBeneficiaryUsecase>(),
    ),
  );

  Map<String, dynamic> data = {
    "account_number": "",
    "bank_code": "",
  };

  Map<String, dynamic> bankBeneficiarydata = {
    "account_name": "",
    "account_number": "",
    "bank_name": "",
    "bank_code": "",
    "currency": "",
  };

  void _submit() async {
    final isValid = formKey.currentState!.validate();
    if (isValid) {
      formKey.currentState!.save();
      try {
        resolveController.resolveBankAccount(data);
      } catch (error) {
        debugPrint("error caught - ${error.toString()}");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    numberController;
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
                  title: "Manage Payout Accounts",
                ),
                const SizedBox(height: 46),
                GestureDetector(
                  onTap: _banksDialog,
                  child: ValueListenableBuilder(
                    valueListenable: bankNotifier,
                    builder: (context, value, _) {
                      return XnTextField(
                        label: selectedBank ?? "Bank Name",
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
                // show this section after resolving the account
                const SizedBox(height: 24),
                const XnTextField(
                  label: "Account Name",
                  keyboardType: TextInputType.text,
                  enabled: false,
                  readOnly: true,
                  filled: true,
                  fillColor: XMColors.shade4,
                ),
                const SizedBox(height: 26),
                // change submit button to final submission after resolving
                XnSolidButton(
                  content: Obx(() {
                    return resolveController.isLoading.value
                        ? const CupertinoActivityIndicator()
                        : Text(
                            "Add Payout Account",
                            style: textTheme.bodyText1?.copyWith(
                              color: XMColors.shade6,
                              fontWeight: FontWeight.w500,
                            ),
                          );
                  }),
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

  final ValueNotifier<String?> bankNotifier = ValueNotifier("");

  List allBanks = [];
  List filteredBanks = [];

  _banksDialog() async {
    controller.getBanks();

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
                      (bank) => bank['name'].toLowerCase().contains(
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
                                                    ['name']
                                                .toString();
                                            selectedBankCode =
                                                allBanks[index]['code'];
                                            bankNotifier.value = selectedBank;
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          allBanks[index]['name'].toString(),
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
                                                    ['name']
                                                .toString();
                                            selectedBankCode =
                                                filteredBanks[index]['code'];
                                            bankNotifier.value = selectedBank;
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          filteredBanks[index]['name']
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

  //   //   // return Column(
  //   //   //   children: [
  //   //   //     for (var i = 0; i <= 10; i++)
  //   //   //       const ListItemOne(
  //   //   //         title: "Shittu Hakeem",
  //   //   //         subtitle: "+234 902 324 9586",
  //   //   //         iconOne: Icons.add,
  //   //   //         iconTwo: Icons.trash,
  //   //   //       ),
  //   //   //   ],
  //   //   // );
  //   // }
}
