import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:xendly_mobile/src/domain/usecases/user/virtual_acct_usecase.dart';
import 'package:xendly_mobile/src/domain/usecases/wallets/get_user_wallets_usecase.dart';
import 'package:xendly_mobile/src/presentation/view_model/user/virtual_acct_controller.dart';
import 'package:xendly_mobile/src/presentation/view_model/wallets/get_user_wallets_controller.dart';
import 'package:xendly_mobile/src/presentation/widgets/list_items/list_item_four.dart';
import 'package:xendly_mobile/src/presentation/widgets/list_items/list_item_one.dart';

import '../../../config/routes.dart' as routes;
import '../../../core/utilities/helpers/validator_helper.dart';
import '../../../core/utilities/interfaces/colors.dart';
import '../../../core/utilities/interfaces/iconsax_icons.dart';
import '../../../domain/usecases/user/get_profile_usecase.dart';
import '../../../presentation/widgets/new_title_bar.dart';
import '../../view_model/user/get_profile_controller.dart';
import '../../widgets/inputs/xn_text_field.dart';

class Accounts extends StatefulWidget {
  const Accounts({Key? key}) : super(key: key);
  @override
  State<Accounts> createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  final GetUserWalletsController getUserWalletsController = Get.put(
    GetUserWalletsController(
      Get.find<GetUserWalletsUseCase>(),
    ),
  );

  final virtualAcctCtrl = Get.put(
    VirtualAcctController(Get.find<VirtualAcctUsecase>()),
  );

  final profileCtrl = Get.put(
    GetProfileController(Get.find<GetProfileUsecase>()),
  );

  final formatCurrency = NumberFormat.currency();
  String? selectedWallet;
  List userWallets = [];
  void fetchUserWallets() async {
    await getUserWalletsController.getUserWallets();
    setState(() => userWallets = getUserWalletsController.data);
  }

  final bvnController = TextEditingController();

  Map<String, dynamic> data = {"bvn": ""};

  void createVirtualAcct() async {
    await virtualAcctCtrl.showVirtualAcct(data);
  }

  @override
  void initState() {
    super.initState();
    fetchUserWallets();
    selectedWallet = "NGN";
  }

  @override
  void dispose() {
    super.dispose();
    getUserWalletsController.getUserWallets();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    // call the function constantly
    profileCtrl.getProfile();

    return Scaffold(
      backgroundColor: XMColors.shade6,
      extendBody: true,
      appBar: const NewTitleBar(
        title: "Accounts",
        suffix: Icon(
          Iconsax.setting_2,
          size: 28,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: XMColors.shade6,
              padding: const EdgeInsets.fromLTRB(18, 14, 18, 26),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          userWallets.isEmpty
                              ? Text(
                                  "0.00",
                                  style: textTheme.headlineSmall?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              : Text(
                                  selectedWallet == "NGN"
                                      ? NumberFormat.currency(
                                          locale: "en_NG",
                                          symbol: "\u20A6",
                                        ).format(
                                          double.parse(
                                            userWallets[0]["balance"]
                                                .toString(),
                                          ),
                                        )
                                      : NumberFormat.currency(
                                          locale: "en_US",
                                          symbol: "\u0024",
                                        ).format(
                                          double.parse(
                                            userWallets[0]["balance"]
                                                .toString(),
                                          ),
                                        ),
                                  style: textTheme.headlineSmall?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                          const SizedBox(height: 3),
                          Row(
                            children: [
                              const Icon(
                                Iconsax.eye_slash,
                                color: XMColors.shade3,
                                size: 18,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                selectedWallet == "NGN"
                                    ? "NGN Balance"
                                    : "USD Balance",
                                style: textTheme.bodyText1?.copyWith(
                                  color: XMColors.shade3,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const CircleAvatar(
                        backgroundImage: NetworkImage(
                          "https://cdn.britannica.com/68/5068-004-72A3F250/Flag-Nigeria.jpg",
                        ),
                        backgroundColor: XMColors.shade3,
                      ),
                    ],
                  ),
                  const SizedBox(height: 26),
                  profileCtrl.data['kyc_status'] != 'verified'
                      ? ElevatedButton(
                          onPressed: () => Get.toNamed(routes.updateAddress),
                          child: Text(
                            "Verify your account",
                            style: textTheme.bodyText1?.copyWith(
                              color: XMColors.shade6,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      : profileCtrl.data['virtual_accounts'] == []
                          ? ElevatedButton(
                              onPressed: () => createVirtualAcct(),
                              child: Text(
                                "Create virtual account",
                                style: textTheme.bodyText1?.copyWith(
                                  color: XMColors.shade6,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          : Column(
                              children: [
                                Text(
                                  "Nigerian Naira Virtual Account",
                                  textAlign: TextAlign.start,
                                  style: textTheme.headline6?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "Send money to this account and we will fund your wallet automatically. Not more than 5 minutes!",
                                  style: textTheme.bodyLarge?.copyWith(
                                    color: XMColors.shade3,
                                    height: 1.5,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const ListItemFour(
                                  title: "Account Holder",
                                  subtitle: "Ibrahim Ibrahim",
                                  icon: Icons.copy,
                                ),
                                const ListItemFour(
                                  title: "Account Number",
                                  subtitle: "4EV221406142",
                                  icon: Icons.copy,
                                ),
                                const ListItemFour(
                                  title: "Bank Name",
                                  subtitle: "Barclays Bank",
                                  icon: Icons.copy,
                                ),
                              ],
                            ),
                  const SizedBox(height: 26),
                ],
              ),
            ),
            const SizedBox(height: 22),
          ],
        ),
      ),
    );
  }

  // virtual acct bvn
  virtualAcctBvn() {
    final textTheme = Theme.of(context).textTheme;

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            Container(
              height: 6,
              width: 64,
              decoration: BoxDecoration(
                color: XMColors.shade4,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            const SizedBox(height: 26),
            XnTextField(
              label: "Bank Verification Number",
              keyboardType: TextInputType.emailAddress,
              controller: bvnController,
              onSaved: (value) => data["bvn"] = value!,
              validator: (value) => validateBvn(value!),
            ),
            const SizedBox(height: 26),
            ElevatedButton(
              onPressed: () => createVirtualAcct(),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.only(bottom: 2),
                fixedSize: const Size(0, 64),
              ),
              child: Obx(
                () {
                  return virtualAcctCtrl.isLoading.value
                      ? Text(
                          "Please wait...",
                          style: textTheme.bodyLarge?.copyWith(
                            color: XMColors.shade6,
                          ),
                        )
                      : Text(
                          "Create Virtual Account",
                          style: textTheme.bodyLarge
                              ?.copyWith(color: XMColors.shade6),
                        );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  // >>> Show modal for wallets <<< //
  showUserWallets() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(4, 32, 4, 22),
              color: XMColors.shade6,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Text(
                    "Virtual Wallets",
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 18),
                  for (var wallet in userWallets)
                    ListTile(
                      onTap: () {
                        setState(() =>
                            selectedWallet = wallet["currency"].toString());
                        Navigator.pop(context);
                      },
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          wallet["currency"] == "NGN"
                              ? "https://cdn.britannica.com/68/5068-004-72A3F250/Flag-Nigeria.jpg"
                              : "https://upload.wikimedia.org/wikipedia/en/thumb/a/ae/Flag_of_the_United_Kingdom.svg/640px-Flag_of_the_United_Kingdom.svg.png",
                        ),
                        backgroundColor: XMColors.shade3,
                      ),
                      title: Text(
                        wallet["currency"] == "NGN"
                            ? "Nigerian Naira"
                            : "United States Dollars",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          wallet["currency"],
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: XMColors.shade3,
                                  ),
                        ),
                      ),
                      trailing: Text(
                        wallet["currency"] == "NGN"
                            ? NumberFormat.currency(
                                locale: "en_NG",
                                symbol: "\u20A6",
                              ).format(
                                double.parse(wallet["balance"].toString()),
                              )
                            : NumberFormat.currency(
                                locale: "en_US",
                                symbol: "\u0024",
                              ).format(
                                double.parse(wallet["balance"].toString()),
                              ),
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: XMColors.shade0,
                            ),
                      ),
                    ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  // >>> Show modal for funding <<< //
  showAddMoneyMethods() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(4, 22, 4, 22),
              color: XMColors.shade6,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Container(
                    height: 6,
                    width: 86,
                    decoration: BoxDecoration(
                      color: XMColors.shade4,
                      borderRadius: BorderRadius.circular(26),
                    ),
                  ),
                  const SizedBox(height: 18),
                  ListItemOne(
                    title: "Bank transfer, Momo & Mpesa",
                    subtitle: "Initiate a top up for your account",
                    iconOne: Iconsax.add,
                    iconTwo: Iconsax.arrow_right_3,
                    action: () {
                      Get.back();
                      Get.toNamed(
                        routes.addCash,
                        arguments: selectedWallet,
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
