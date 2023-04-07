import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/presentation/widgets/buttons/rounded.dart';
import 'package:xendly_mobile/src/presentation/widgets/page_title.dart';
import 'package:xendly_mobile/src/presentation/widgets/text_input.dart';
import 'package:xendly_mobile/src/data/models/payout_account_model.dart';
import 'package:xendly_mobile/src/data/services/accounts_service.dart';
import 'package:xendly_mobile/src/data/services/misc_service.dart';
import 'package:xendly_mobile/src/presentation/widgets/title_bar.dart';
import '../../config/routes.dart' as routes;

class PayoutAccounts extends StatefulWidget {
  const PayoutAccounts({Key? key}) : super(key: key);
  @override
  State<PayoutAccounts> createState() => _PayoutAccountsState();
}

class _PayoutAccountsState extends State<PayoutAccounts> {
  // === CONTROLLER === //
  final _accountsService = Get.put(AccountsService());
  final _miscService = Get.put(MiscService());

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController? bvnController = TextEditingController();

  Map<String, dynamic> data = {
    "bvn": "",
  };
  bool _isLoading = true;
  List<PayoutAccountModel> _payoutAccounts = [];

  @override
  void initState() {
    super.initState();
    getPayoutAccounts();
    // bvnController;
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

  void getPayoutAccounts() async {
    try {
      final result = await _accountsService.getPayoutAccounts();
      setState(() {
        _payoutAccounts = result;
        _isLoading = false;
      });
    } catch (err) {
      setState(() {
        _isLoading = false;
      });
      printInfo(info: "an error occured");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: XMColors.light,
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
                const TitleBar(
                  title: "Account Limits",
                ),
                const SizedBox(height: 46),
                _getPageData(),
                const SizedBox(height: 24.0),
                RoundedButton(
                  text: "Create payout account",
                  action: () {
                    Get.toNamed(routes.createPayoutAccount);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getPageData() {
    if (_isLoading) {
      return const Center(
        child: SizedBox(
          height: 40.0,
          width: 40.0,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(XMColors.primary),
          ),
        ),
      );
    }
    if (_payoutAccounts.isEmpty) {
      return _buildEmptyData();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: _payoutAccounts
          .map(
            (account) => Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          account.bankName,
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 4.0,
                        ),
                        Text(
                          account.accountNumber,
                          style: const TextStyle(
                            // fontSize: 1.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 4.0,
                        ),
                        Text(
                          account.accountName,
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => deleteBankAccount(account.id),
                      child: SvgPicture.asset(
                        "assets/icons/trash.svg",
                        color: XMColors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildEmptyData() {
    return Center(
      child: Column(
        children: [
          const SizedBox(
            height: 12.0,
          ),
          SvgPicture.asset(
            'assets/icons/bank.svg',
            width: 60.0,
          ),
          const SizedBox(
            height: 12.0,
          ),
          const Text(
            'You have not added any payout account',
            style: TextStyle(
              fontSize: 24.0,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 12.0,
          ),
          const Text(
            'Click the button below to add payout account',
            style: TextStyle(color: XMColors.gray
                // fontSize: 24.0,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _showForm() {
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
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Get access to a virtual account that you can use to pay for your bills and other services.",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: XMColors.gray,
                          ),
                    ),
                    const SizedBox(height: 26),
                    TextInput(
                      readOnly: false,
                      label: "Bank Vertificaiton Number (BVN)",
                      hintText: "12345678901",
                      inputType: TextInputType.number,
                      borderRadius: BorderRadius.circular(10),
                      controller: bvnController,
                      onSaved: (value) => data["bvn"] = value,
                      validator: (value) => validateBvn(value!),
                    ),
                    const SizedBox(height: 20),
                    RoundedButton(
                      text: "Create payout account",
                      action: () => {
                        // if()
                        // createVirtualAccount(),
                        // Get.back(),
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void deleteBankAccount(int bankID) async {
    try {
      final result =
          await _accountsService.deleteBankAccount(bankID.toString());
      if (result["status"] == 'Success') {
        _loadBanks();
        printInfo(info: "${result["statusCode"]}");
        Get.snackbar(
          result["status"],
          result["message"],
          backgroundColor: Colors.green,
          colorText: XMColors.light,
          duration: const Duration(seconds: 5),
        );
        Get.back(closeOverlays: true);
      } else {
        Get.back(closeOverlays: true);
        printInfo(info: "${result["message"]}, ${result["statusCode"]}");
        if (result["message"] != null || result["status"] != "failed") {
          Get.closeAllSnackbars();
          printInfo(info: "${result["message"]}");
          Get.snackbar(
            result["status"].toString(),
            result["message"],
            backgroundColor: Colors.red,
            colorText: XMColors.light,
            duration: const Duration(seconds: 5),
          );
        } else {
          Get.closeAllSnackbars();
          Get.snackbar(
            result["status"].toString(),
            result["message"],
            backgroundColor: Colors.red,
            colorText: XMColors.light,
            duration: const Duration(seconds: 5),
          );
          Get.snackbar(
            result["status"],
            result["message"],
            backgroundColor: Colors.red,
            colorText: XMColors.light,
            duration: const Duration(seconds: 5),
          );
        }
      }
    } catch (error) {
      Get.back(closeOverlays: true);
      Get.snackbar("Error", "Unknown Error Occured, Try Again!");
      return printInfo(
        info: "Unknown Error Occured, Try Again!",
      );
    }
  }

  void _loadBanks() async {
    try {
      _payoutAccounts = await AccountsService().getPayoutAccounts();
      setBusy(false);
    } catch (e) {
      setBusy(false);
    }
  }

  setBusy(bool value) {
    if (mounted) {
      setState(() {
        _isLoading = value;
      });
    }
  }
}
