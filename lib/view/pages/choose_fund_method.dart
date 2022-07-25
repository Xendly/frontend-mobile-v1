import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:xendly_mobile/controller/core/public_auth.dart';
import 'package:xendly_mobile/controller/core/user_auth.dart';
import 'package:xendly_mobile/model/user_model.dart';
import 'package:xendly_mobile/model/virtual_account.dart';
import 'package:xendly_mobile/view/shared/colors.dart';
import 'package:xendly_mobile/view/shared/widgets/buttons/rounded.dart';
import 'package:xendly_mobile/view/shared/widgets/micro_list_item.dart';
import 'package:xendly_mobile/view/shared/widgets/page_title.dart';
import "../shared/routes.dart" as routes;

class ChooseFundMethod extends StatefulWidget {
  const ChooseFundMethod({Key? key}) : super(key: key);
  @override
  State<ChooseFundMethod> createState() => _ChooseFundMethodState();
}

class _ChooseFundMethodState extends State<ChooseFundMethod> {
  // === PROFILE API === //
  // late Future<VirtualAccount> virtualAccount;
  // final publicAuth = PublicAuth();
  // late int currentUser;
  late List<VirtualAccount>? _userVAccount = [];

  @override
  void initState() {
    super.initState();
    // virtualAccount = publicAuth.getVirtualAccount();
    _getData();
  }

  void _getData() async {
    _userVAccount = (await PublicAuth().getVirtualAccount())!;
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const _divider = Divider(
      height: 0,
      color: XMColors.gray_70,
      thickness: 1.35,
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
              PageTitleIcons(
                prefixIcon: "assets/icons/bold/arrow-left.svg",
                title: "Choose Fund Method",
                prefixIconColor: XMColors.dark,
                prefixIconAction: () => Get.back(),
              ),
              const SizedBox(height: 36),
              // plugin for dropdown

              InkWell(
                onTap: () => {
                  Get.toNamed(routes.addMoney),
                },
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: XMColors.gray_70,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: SvgPicture.asset(
                        "assets/icons/card.svg",
                        width: 24,
                        height: 24,
                        color: XMColors.dark,
                      ),
                    ),
                    const SizedBox(width: 18),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Fund with Card",
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: XMColors.dark,
                                  ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "Available for both NGN and USD",
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: XMColors.gray_50,
                                  ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 26),
              InkWell(
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: XMColors.gray_70,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: SvgPicture.asset(
                        "assets/icons/bank.svg",
                        width: 24,
                        height: 24,
                        color: XMColors.dark,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Fund with Virtual Account",
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: XMColors.dark,
                                  ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "Available only for NGN",
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: XMColors.gray_50,
                                  ),
                        ),
                      ],
                    ),
                  ],
                ),
                onTap: () => {
                  showMaterialModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        alignment: WrapAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 38,
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "NGN Virtual Account Details",
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
                                  "Here is your virtual account information to easily fund your NGN wallet",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        color: XMColors.gray,
                                      ),
                                ),
                                const SizedBox(height: 26),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Account Number",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: XMColors.dark,
                                          ),
                                    ),
                                    Text(
                                      _userVAccount![0].accountNumber!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: XMColors.gray,
                                          ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Account Name",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: XMColors.dark,
                                          ),
                                    ),
                                    Text(
                                      _userVAccount![0].accountName!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: XMColors.gray,
                                          ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Bank Name",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: XMColors.dark,
                                          ),
                                    ),
                                    Text(
                                      _userVAccount![0].bankName!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: XMColors.gray,
                                          ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Currency",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: XMColors.dark,
                                          ),
                                    ),
                                    Text(
                                      _userVAccount![0].currency!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: XMColors.gray,
                                          ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 30),
                                RoundedButton(
                                  text: "Cancel",
                                  action: () => {
                                    Get.back(),
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                },
              ),
              // GestureDetector(
              //   child: Container(
              //     color: XMColors.gray_90,
              //     padding:
              //         const EdgeInsets.symmetric(horizontal: 18, vertical: 22),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Column(children: [
              //           Text(
              //             "Fund wallet with Card",
              //             style: Theme.of(context).textTheme.bodyText1!.copyWith(
              //                   fontWeight: FontWeight.w500,
              //                 ),
              //           ),
              //           const SizedBox(height: ,)
              //           Text(
              //             "Fund wallet with Card",
              //             style: Theme.of(context).textTheme.bodyText1!.copyWith(
              //                   fontWeight: FontWeight.w500,
              //                 ),
              //           ),
              //         ]),
              //         SvgPicture.asset(
              //           "assets/icons/arrow-right-4.svg",
              //           width: 24,
              //           height: 24,
              //           color: XMColors.dark,
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
