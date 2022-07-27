import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:xendly_mobile/view/shared/colors.dart';
import 'package:xendly_mobile/view/shared/widgets.dart';
import 'package:xendly_mobile/view/shared/widgets/buttons/rounded.dart';
import 'package:xendly_mobile/view/shared/widgets/dropdown_input.dart';
import 'package:xendly_mobile/view/shared/widgets/inputs/plain_dropdown_input.dart';
import 'package:xendly_mobile/view/shared/widgets/inputs/plain_input.dart';
import 'package:xendly_mobile/view/shared/widgets/page_title.dart';
import 'package:xendly_mobile/view/shared/widgets/safe_area.dart';
import 'package:xendly_mobile/view/shared/widgets/solid_button.dart';
import 'package:xendly_mobile/view/shared/routes.dart' as routes;

class ExchangeCash extends StatefulWidget {
  const ExchangeCash({Key? key}) : super(key: key);
  @override
  State<ExchangeCash> createState() => _ExchangeCashState();
}

class _ExchangeCashState extends State<ExchangeCash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // === TITLE SECTION === //
              PageTitleIcons(
                prefixIcon: "assets/icons/bold/icl-arrow-left-2.svg",
                title: "Exhange USD to NGN",
                prefixIconColor: XMColors.dark,
                prefixIconAction: () => Get.back(),
              ),
              const SizedBox(height: 38),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "You send",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: XMColors.gray,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "500 CAD",
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                              color: XMColors.primary_20,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: XMColors.gray_70,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.fromLTRB(10, 8, 8, 4),
                        child: Text(
                          "Canadian Dollar",
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 22),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "You receive",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: XMColors.gray,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "350,000 NGN",
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                              color: XMColors.primary_20,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: XMColors.gray_70,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.fromLTRB(10, 8, 8, 4),
                        child: Text(
                          "Nigerian Naira",
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "Exchange Rate:",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: XMColors.gray,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ],
                  ),
                  Text(
                    "1 CAD = 323.07 NGN",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: XMColors.dark,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "Transaction Fees:",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: XMColors.gray,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ],
                  ),
                  Text(
                    "80% (400 CAD)",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: XMColors.dark,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "You'll Receive:",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: XMColors.gray,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ],
                  ),
                  Text(
                    "100,000 NGN (100 CAD)",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: XMColors.dark,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              ),
              const Spacer(),
              RoundedButton(
                text: "Continue",
                action: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      // return Dialog(
                      //   shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(12),
                      //   ),
                      //   child: Padding(
                      //     padding: const EdgeInsets.symmetric(
                      //       vertical: 50,
                      //       horizontal: 26,
                      //     ),
                      //     child: Column(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       mainAxisSize: MainAxisSize.min,
                      //       children: [
                      //         // icon
                      //         // SvgPicture.asset(
                      //         //   "assets/icons/search.svg",
                      //         //   width: 75,
                      //         //   height: 75,
                      //         // ),
                      //         const CupertinoActivityIndicator(),
                      //         const SizedBox(
                      //           height: 25,
                      //         ),
                      //         Text(
                      //           "Transaction In Progress",
                      //           style: Theme.of(context)
                      //               .textTheme
                      //               .subtitle1!
                      //               .copyWith(
                      //                 fontWeight: FontWeight.w600,
                      //               ),
                      //         ),
                      //         const SizedBox(height: 8),
                      //         Text(
                      //           "Please wait while your transaction to Bruce Banner is processing",
                      //           textAlign: TextAlign.center,
                      //           style: Theme.of(context)
                      //               .textTheme
                      //               .bodyText1!
                      //               .copyWith(
                      //                 fontWeight: FontWeight.w500,
                      //                 color: XMColors.gray_50,
                      //               ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // );
                      return Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 50,
                            horizontal: 26,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // icon
                              // SvgPicture.asset(
                              //   "assets/icons/search.svg",
                              //   width: 75,
                              //   height: 75,
                              // ),
                              const CupertinoActivityIndicator
                                  .partiallyRevealed(),
                              const SizedBox(
                                height: 25,
                              ),
                              Text(
                                "Transaction Successful",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Your transaction to Bruce Banner is complete. Transaction ID is 123456789",
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: XMColors.gray_50,
                                    ),
                              ),
                              const SizedBox(height: 26),
                              RoundedButton(
                                text: "Finish",
                                action: () {
                                  Get.toNamed(routes.home);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              // Text(
              //   "500",
              //   style: Theme.of(context).textTheme.headline2!.copyWith(
              //         color: XMColors.primary_20,
              //       ),
              // ),
              // const SizedBox(height: 10),
              // Container(
              //   decoration: BoxDecoration(
              //     color: XMColors.gray_70,
              //     borderRadius: BorderRadius.circular(10),
              //   ),
              //   padding: const EdgeInsets.fromLTRB(10, 8, 8, 4),
              //   child: Text(
              //     "USD",
              //     style: Theme.of(context).textTheme.bodyText1!.copyWith(
              //           fontWeight: FontWeight.w700,
              //         ),
              //   ),
              // ),
              // const SizedBox(height: 40),
              // SvgPicture.asset(
              //   "assets/icons/arrow-down-2.svg",
              //   width: 42,
              //   height: 42,
              // ),
              // const SizedBox(height: 40),
              // Text(
              //   "You recieve",
              //   style: Theme.of(context).textTheme.bodyText1!.copyWith(
              //         color: XMColors.gray,
              //         fontWeight: FontWeight.w600,
              //       ),
              // ),
              // const SizedBox(height: 6),
              // Text(
              //   "350,000",
              //   style: Theme.of(context).textTheme.headline2!.copyWith(
              //         color: XMColors.primary_20,
              //       ),
              // ),
              // const SizedBox(height: 10),
              // Container(
              //   decoration: BoxDecoration(
              //     color: XMColors.gray_70,
              //     borderRadius: BorderRadius.circular(10),
              //   ),
              //   padding: const EdgeInsets.fromLTRB(10, 8, 8, 4),
              //   child: Text(
              //     "NGN",
              //     style: Theme.of(context).textTheme.bodyText1!.copyWith(
              //           fontWeight: FontWeight.w700,
              //         ),
              //   ),
              // ),
              // const SizedBox(height: 26),
              // Container(
              //   decoration: BoxDecoration(
              //     color: XMColors.none,
              //     border: Border.all(
              //       color: XMColors.dark,
              //     ),
              //   ),
              //   padding: const EdgeInsets.fromLTRB(20, 20, 20, 19),
              //   child: Column(
              //     children: [
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           bodyText("Transfer From:"),
              //           bodyText("United States Dollars"),
              //         ],
              //       ),
              //       const SizedBox(height: 8),
              //       const Divider(),
              //       const SizedBox(height: 14),
              //       bodyText("You are sending:"),
              //       const SizedBox(height: 6),
              //       heading(
              //         "-\$65,483.48",
              //         XMColors.dark,
              //         28,
              //       ),
              //       const SizedBox(height: 14),
              //       const Divider(),
              //       const SizedBox(height: 10),
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           bodyText("Wallet Balance (USD):"),
              //           bodyText("358,241.97 USD"),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
              // const SizedBox(height: 28),
              // Container(
              //   padding: const EdgeInsets.all(18),
              //   decoration: BoxDecoration(
              //     color: XMColors.primary,
              //     borderRadius: BorderRadius.circular(50),
              //   ),
              //   child: SvgPicture.asset(
              //     "assets/icons/arrow-swap.svg",
              //     width: 26,
              //     height: 26,
              //     color: XMColors.light,
              //   ),
              // ),
              // const SizedBox(height: 28),
              // Container(
              //   decoration: BoxDecoration(
              //     color: XMColors.none,
              //     border: Border.all(
              //       color: XMColors.dark,
              //     ),
              //   ),
              //   padding: const EdgeInsets.fromLTRB(20, 20, 20, 19),
              //   child: Column(
              //     children: [
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           bodyText("Transfer To:"),
              //           bodyText("United States Dollars"),
              //         ],
              //       ),
              //       const SizedBox(height: 8),
              //       const Divider(),
              //       const SizedBox(height: 14),
              //       bodyText("Jardaani will receive:"),
              //       const SizedBox(height: 6),
              //       heading(
              //         "+\$65,383.48",
              //         XMColors.dark,
              //         28,
              //       ),
              //       const SizedBox(height: 14),
              //       const Divider(),
              //       const SizedBox(height: 10),
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           bodyText("Transaction Fee:"),
              //           bodyText("1,000 USD"),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
              // const SizedBox(height: 22),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     bodyText(
              //       "Exchange Rate:",
              //       XMColors.gray,
              //       FontWeight.w600,
              //     ),
              //     bodyText(
              //       "USD 1 = NGN 650",
              //       XMColors.dark,
              //       FontWeight.w600,
              //     ),
              //   ],
              // ),
              // const SizedBox(height: 10),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     bodyText(
              //       "Delivery Time:",
              //       XMColors.gray,
              //       FontWeight.w600,
              //     ),
              //     bodyText(
              //       "15 Minutes",
              //       XMColors.dark,
              //       FontWeight.w600,
              //     ),
              //   ],
              // ),
              // const SizedBox(height: 32),
              // SolidButton(
              //   text: "Transfer \$65,383",
              //   textColor: XMColors.light,
              //   buttonColor: XMColors.primary,
              //   action: () => {
              //     Navigator.pushNamed(
              //       context,
              //       routes.confirmTransaction,
              //     )
              //   },
              // ),
              // const Spacer(),
              // RoundedButton(
              //   text: "Continue",
              //   action: () {
              //     showDialog(
              //       context: context,
              //       builder: (BuildContext context) {
              //         // return Dialog(
              //         //   shape: RoundedRectangleBorder(
              //         //     borderRadius: BorderRadius.circular(12),
              //         //   ),
              //         //   child: Padding(
              //         //     padding: const EdgeInsets.symmetric(
              //         //       vertical: 50,
              //         //       horizontal: 26,
              //         //     ),
              //         //     child: Column(
              //         //       mainAxisAlignment: MainAxisAlignment.center,
              //         //       mainAxisSize: MainAxisSize.min,
              //         //       children: [
              //         //         // icon
              //         //         // SvgPicture.asset(
              //         //         //   "assets/icons/search.svg",
              //         //         //   width: 75,
              //         //         //   height: 75,
              //         //         // ),
              //         //         const CupertinoActivityIndicator(),
              //         //         const SizedBox(
              //         //           height: 25,
              //         //         ),
              //         //         Text(
              //         //           "Transaction In Progress",
              //         //           style: Theme.of(context)
              //         //               .textTheme
              //         //               .subtitle1!
              //         //               .copyWith(
              //         //                 fontWeight: FontWeight.w600,
              //         //               ),
              //         //         ),
              //         //         const SizedBox(height: 8),
              //         //         Text(
              //         //           "Please wait while your transaction to Bruce Banner is processing",
              //         //           textAlign: TextAlign.center,
              //         //           style: Theme.of(context)
              //         //               .textTheme
              //         //               .bodyText1!
              //         //               .copyWith(
              //         //                 fontWeight: FontWeight.w500,
              //         //                 color: XMColors.gray_50,
              //         //               ),
              //         //         ),
              //         //       ],
              //         //     ),
              //         //   ),
              //         // );
              //         return Dialog(
              //           shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(12),
              //           ),
              //           child: Padding(
              //             padding: const EdgeInsets.symmetric(
              //               vertical: 50,
              //               horizontal: 26,
              //             ),
              //             child: Column(
              //               mainAxisAlignment: MainAxisAlignment.center,
              //               mainAxisSize: MainAxisSize.min,
              //               children: [
              //                 // icon
              //                 // SvgPicture.asset(
              //                 //   "assets/icons/search.svg",
              //                 //   width: 75,
              //                 //   height: 75,
              //                 // ),
              //                 const CupertinoActivityIndicator
              //                     .partiallyRevealed(),
              //                 const SizedBox(
              //                   height: 25,
              //                 ),
              //                 Text(
              //                   "Transaction Successful",
              //                   style: Theme.of(context)
              //                       .textTheme
              //                       .subtitle1!
              //                       .copyWith(
              //                         fontWeight: FontWeight.w600,
              //                       ),
              //                 ),
              //                 const SizedBox(height: 8),
              //                 Text(
              //                   "Your transaction to Bruce Banner is complete. Transaction ID is 123456789",
              //                   textAlign: TextAlign.center,
              //                   style: Theme.of(context)
              //                       .textTheme
              //                       .bodyText1!
              //                       .copyWith(
              //                         fontWeight: FontWeight.w500,
              //                         color: XMColors.gray_50,
              //                       ),
              //                 ),
              //                 const SizedBox(height: 14),
              //                 RoundedButton(
              //                   text: "Finish",
              //                   action: () {
              //                     Get.toNamed(routes.home);
              //                   },
              //                 ),
              //               ],
              //             ),
              //           ),
              //         );
              //       },
              //     );
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
