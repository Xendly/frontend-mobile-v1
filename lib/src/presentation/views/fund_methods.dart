/* == imported packages == */
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/presentation/widgets/widgets.dart';
import 'package:xendly_mobile/src/presentation/widgets/bottomSheet.dart';
import 'package:xendly_mobile/src/presentation/widgets/buttons/rounded.dart';
import 'package:xendly_mobile/src/presentation/widgets/dropdown_input.dart';
import 'package:xendly_mobile/src/presentation/widgets/dual_texts.dart';
import 'package:xendly_mobile/src/presentation/widgets/list_item_3.dart';
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
import 'package:xendly_mobile/src/data/models/virtual_account.dart';
import 'package:xendly_mobile/src/data/models/wallet_model_old.dart';
import 'package:xendly_mobile/src/data/services/beneficiary_auth.dart';
import 'package:xendly_mobile/src/data/services/public_auth.dart';
import 'package:xendly_mobile/src/data/services/transaction_service.dart';
import 'package:xendly_mobile/src/data/services/user_auth.dart';
import 'package:xendly_mobile/src/data/services/wallet_auth.dart';
import '../../config/routes.dart' as routes;

/* == methods to add cash == */
class FundMethods extends StatefulWidget {
  const FundMethods({Key? key}) : super(key: key);
  @override
  State<FundMethods> createState() => _FundMethodsState();
}

class _FundMethodsState extends State<FundMethods> {
  List<VirtualAccount> _userVAccount = [];
  late Wallet _wallet;

  @override
  void initState() {
    super.initState();
    _wallet = Get.arguments as Wallet;
    _getData();
  }

  void _getData() async {
    _userVAccount = (await PublicAuth().getVirtualAccount())!;
    Future.delayed(
      const Duration(seconds: 1),
    ).then(
      (value) => setState(
        () {},
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // divider variable
    const divider = Divider(
      thickness: 1,
      height: 44,
      color: XMColors.gray_70,
    );
    return Scaffold(
      backgroundColor: XMColors.light,
      extendBody: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 24,
          ),
          child: Column(
            children: [
              const TitleBar(
                title: "Select Funding Method",
              ),
              const SizedBox(height: 46),
              ListItemThree(
                icon: "assets/icons/card.svg",
                title: "Add Cash with Card",
                subtitle: "Available on NGN and USD",
                action: () => {
                  Get.toNamed(
                    routes.addCash,
                    arguments: _wallet,
                  ),
                },
              ),
              divider,
              if (_wallet.currency == 'NGN')
                ListItemThree(
                  icon: "assets/icons/bank.svg",
                  title: "Fund with Virtual Account",
                  subtitle: "Available only on NGN wallets",
                  action: () => {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return CustomBottomSheet(
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: GestureDetector(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: SvgPicture.asset(
                                    "assets/icons/close-circle.svg",
                                    width: 28,
                                    height: 28,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 26,
                              ),
                              Text(
                                "NGN Virtual Account",
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
                                _userVAccount.isEmpty
                                    ? 'Create a virtual account to easily fund your NGN wallet'
                                    : "Here is your account details to fund your NGN wallet easily",
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      color: XMColors.gray,
                                    ),
                              ),
                              const SizedBox(height: 26),
                              if (_userVAccount.isNotEmpty) ...[
                                DualTexts(
                                  title: "Account Number",
                                  value: _userVAccount[0].accountNumber!,
                                ),
                                const SizedBox(height: 22),
                                DualTexts(
                                  title: "Account Name",
                                  value: _userVAccount[0].accountName!,
                                ),
                                const SizedBox(height: 22),
                                DualTexts(
                                  title: "Bank Name",
                                  value: _userVAccount[0].bankName!,
                                ),
                                // ElevatedButton(
                                //   onPressed: () {
                                //     Get.back();
                                //   },
                                //   child: Text(
                                //     "Cancel",
                                //     style: Theme.of(context)
                                //         .textTheme
                                //         .bodyText1!
                                //         .copyWith(
                                //           color: XMColors.light,
                                //         ),
                                //   ),
                                // ),
                              ] else
                                ElevatedButton(
                                  onPressed: () {
                                    Get.back(closeOverlays: true);
                                    Get.toNamed(routes.virtualAccounts);
                                  },
                                  child: const Text(
                                    "Create a Virtual Account",
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
