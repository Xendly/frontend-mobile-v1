import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:xendly_mobile/src/core/utilities/widgets/wallets_list.dart';
import 'package:xendly_mobile/src/presentation/view_model/wallets/get_user_wallets_controller.dart';

import '../interfaces/colors.dart';

class SelectWallets extends StatefulWidget {
  final Widget? child;
  String? selectedWallet;
  final GetUserWalletsController controller;

  SelectWallets({
    Key? key,
    required this.child,
    required this.selectedWallet,
    required this.controller,
  }) : super(key: key);

  @override
  State<SelectWallets> createState() => _SelectWalletsState();
}

class _SelectWalletsState extends State<SelectWallets> {
  @override
  Widget build(BuildContext context) {
    print(widget.selectedWallet.toString());
    return GestureDetector(
      onTap: () => showWallets(),
      child: widget.child,
    );
  }

  showWallets(
      // void Function()? onTap,
      ) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        final walletOut = widget.controller.data;
        return WalletsList(
          itemCount: walletOut.length,
          itemBuilder: (_, index) {
            final wallet = walletOut[index];
            return Obx(
              () {
                return widget.controller.isLoading.value
                    ? const CupertinoActivityIndicator()
                    : ListTile(
                        onTap: () => setState(() {
                          widget.selectedWallet = wallet['currency'].toString();
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
}
