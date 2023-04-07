import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xendly_mobile/src/core/utilities/helpers/fcm_token_api.dart';
import 'package:xendly_mobile/src/core/utilities/widgets/wallets_list.dart';
import 'package:xendly_mobile/src/domain/usecases/wallets/get_user_wallets_usecase.dart';
import 'package:xendly_mobile/src/presentation/view_model/wallets/get_user_wallets_controller.dart';
import 'package:xendly_mobile/src/presentation/widgets/list_items/list_item_four.dart';
import 'package:xendly_mobile/src/presentation/widgets/list_items/list_item_one.dart';

import '../../../config/routes.dart' as routes;
import '../../../core/utilities/interfaces/colors.dart';
import '../../../core/utilities/interfaces/iconsax_icons.dart';
import '../../../core/utilities/widgets/transactions_list.dart';
import '../../../presentation/widgets/new_title_bar.dart' '';

class Wallets extends StatefulWidget {
  const Wallets({Key? key}) : super(key: key);

  @override
  State<Wallets> createState() => _WalletsState();
}

class _WalletsState extends State<Wallets> {
  static final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  void showToken() async {
    final prefs = await SharedPreferences.getInstance();
    String? fcmToken = await _fcm.getToken();
    final String? storedFcmToken = prefs.getString('fcm_token');
    if (fcmToken != storedFcmToken) {
      handleFcmToken(fcmToken);
    }
  }

  final GetUserWalletsController getUserWalletsController = Get.put(
    GetUserWalletsController(
      Get.find<GetUserWalletsUseCase>(),
    ),
  );

  final formatCurrency = NumberFormat.currency();
  late String selectedWallet;

  @override
  void initState() {
    super.initState();
    showToken();
    getUserWalletsController.getUserWallets();
    selectedWallet = "NGN";
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: XMColors.shade6,
      extendBody: true,
      appBar: const NewTitleBar(
        title: "Dashboard",
        suffix: Icon(
          Icons.swap_vertical_circle_rounded,
          size: 26,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: XMColors.shade6,
              padding: const EdgeInsets.fromLTRB(18, 10, 18, 26),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(
                            () {
                              return getUserWalletsController.isLoading.value
                                  ? Text(
                                      "---",
                                      style: textTheme.headlineSmall?.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  : Text(
                                      selectedWallet ==
                                              getUserWalletsController.data[0]
                                                  ['currency']
                                          ? NumberFormat.currency(
                                              locale: "en_NG",
                                              symbol: getUserWalletsController
                                                              .data[0]
                                                          ['currency'] ==
                                                      "NGN"
                                                  ? "\u20A6"
                                                  : "\u0024",
                                            ).format(
                                              double.parse(
                                                getUserWalletsController.data[0]
                                                        ["balance"]
                                                    .toString(),
                                              ),
                                            )
                                          : NumberFormat.currency(
                                              locale: "en_US",
                                              symbol: getUserWalletsController
                                                              .data[0]
                                                          ['currency'] ==
                                                      "NGN"
                                                  ? "\u0024"
                                                  : "\u20A6",
                                            ).format(
                                              double.parse(
                                                getUserWalletsController.data[1]
                                                        ["balance"]
                                                    .toString(),
                                              ),
                                            ),
                                      style: textTheme.headlineMedium,
                                    );
                            },
                          ),
                          const SizedBox(height: 2),
                        ],
                      ),
                      GestureDetector(
                        onTap: () => showUserWallets(),
                        child: Chip(
                          backgroundColor: XMColors.shade4,
                          label: Padding(
                            padding: const EdgeInsets.only(left: 2),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 1),
                                  child: Text(
                                    selectedWallet,
                                    style: textTheme.bodyMedium?.copyWith(
                                      color: XMColors.shade0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 4),
                                const Icon(
                                  Iconsax.arrow_down_1,
                                  color: XMColors.shade0,
                                  size: 16,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: showAddMoneyMethods,
                          icon: const Padding(
                            padding: EdgeInsets.only(top: 2),
                            child: Icon(Icons.add),
                          ),
                          label: Text(
                            "Fund",
                            style: textTheme.bodyLarge?.copyWith(
                              color: XMColors.shade6,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => Get.toNamed(
                            routes.exchangeCash,
                            parameters: selectedWallet == "NGN"
                                ? {
                                    "from_currency": selectedWallet!,
                                    "to_currency": "USD",
                                  }
                                : {
                                    "from_currency": "USD",
                                    "to_currency": "NGN",
                                  },
                          ),
                          icon: const Padding(
                            padding: EdgeInsets.only(top: 2),
                            child: Icon(Icons.swap_horiz),
                          ),
                          label: Text(
                            "Swap",
                            style: textTheme.bodyLarge?.copyWith(
                              color: XMColors.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Transactions",
                        style: textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Get.toNamed(routes.transactions),
                        child: Container(
                          margin: const EdgeInsets.only(top: 2),
                          child: Text(
                            "View all",
                            style: textTheme.bodyLarge?.copyWith(
                              color: XMColors.primary0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const TransactionsList(),
                ],
              ),
            ),
            const SizedBox(height: 22),
          ],
        ),
      ),
    );
  }

  showUserWallets() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        final walletOut = getUserWalletsController.data;
        return WalletsList(
          itemCount: walletOut.length,
          itemBuilder: (_, index) {
            final wallet = walletOut[index];
            return Obx(
              () {
                return getUserWalletsController.isLoading.value
                    ? const CupertinoActivityIndicator()
                    : ListTile(
                        onTap: () => setState(() {
                          selectedWallet = wallet['currency'].toString();
                          Get.back();
                        }),
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(
                            wallet["currency"] == "NGN"
                                ? "assets/images/ngn.png"
                                : "assets/images/usd.png",
                          ),
                          backgroundColor: XMColors.shade3,
                        ),
                        title: Text(
                          wallet["currency"] == "NGN"
                              ? "Nigerian Naira"
                              : "United States Dollar",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            wallet["currency"],
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
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
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: XMColors.shade0,
                                  ),
                        ),
                      );
              },
            );
          },
        );
      },
    );
  }

  showAddMoneyMethods() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 22,
              ),
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
                    title: "Virtual Bank Transfer",
                    subtitle: "Top up your account instantly",
                    iconOne: Iconsax.bank,
                    iconTwo: Icons.arrow_forward_ios,
                    iconColor: XMColors.shade4,
                    action: () {
                      Get.back();
                      virtualAccountDetails();
                    },
                  ),
                  ListItemOne(
                    title: "Debit or Credit Card",
                    subtitle: "Top up your account instantly",
                    iconOne: Iconsax.card,
                    iconTwo: Icons.arrow_forward_ios,
                    iconColor: XMColors.shade4,
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

  virtualAccountDetails() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(18, 22, 18, 22),
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
            )
          ],
        );
      },
    );
  }
}
