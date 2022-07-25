import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:xendly_mobile/controller/core/wallet_auth.dart';
import 'package:xendly_mobile/model/wallet_model.dart';
import 'package:xendly_mobile/view/shared/widgets/buttons/rounded.dart';
import 'package:xendly_mobile/view/shared/widgets/list_item_2.dart';
import 'package:xendly_mobile/view/shared/widgets/page_title_widgets.dart';
import 'package:xendly_mobile/view/shared/widgets/tabPage_title.dart';
import 'package:xendly_mobile/view/shared/widgets/wallets_item.dart';
import '../../shared/colors.dart';
import "../../shared/routes.dart" as routes;

class Wallets extends StatefulWidget {
  const Wallets({Key? key}) : super(key: key);
  @override
  State<Wallets> createState() => _WalletsState();
}

class _WalletsState extends State<Wallets> {
  // === WALLETS API ===//
  // late Future<List<Wallet>> futureWallet;
  // final walletAuth = WalletAuth();
  late List<Wallet>? _userWallet = [];

  late PageController _pageController;
  // var for current page index i.e the wallet on home
  int currentWallet = 0;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 0.85,
      initialPage: 0,
    );

    // futureWallet = walletAuth.getWallets();
    _getData();
  }

  void _getData() async {
    // _userWallet = (await WalletAuth().getWallets())?.toList();
    _userWallet = (await WalletAuth().getWallets())!;
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> walletsItems = [
      // _userWallet == null || _userWallet!.isEmpty
      //     ? const Center(
      //         child: CircularProgressIndicator(),
      //       )
      //     : SizedBox(
      //         height: 100,
      //         child: ListView.builder(
      //             itemCount: _userWallet!.length,
      //             itemBuilder: (context, index) {
      //               return Text(_userWallet![index].balance.toString());
      //             }),
      //       ),

      GestureDetector(
        onTap: () => {
          Navigator.pushNamed(
            context,
            routes.walletDetails,
          )
        },
        child: const WalletsItem(
          balance: "\$860,654.32",
          currency: "United States Dollar",
        ),
      ),

      // FutureBuilder<List<Wallet>>(
      //   future: walletsList,
      //   builder: (context, snapshot) {
      //     if (snapshot.hasData) {
      //       // snapshot.data?.map((wallet) {
      //       return GestureDetector(
      //         onTap: () => {
      //           Navigator.pushNamed(
      //             context,
      //             routes.walletDetails,
      //           )
      //         },
      //         // using map causes the section to load infinitely
      //         // child: WalletsItem(
      //         //   balance: "${wallet.balance} ${wallet.currency}",
      //         //   // currency: "Nigerian Naira",
      //         // ),
      //         child: WalletsItem(
      //           balance:
      //               // snapshot accepts index but I'm unable to make it dynamic
      //               "${snapshot.data![currentWallet].balance} ${snapshot.data![currentWallet].currency}",
      //           currency: "Nigerian Naira",
      //         ),
      //       );
      //       // });
      //     }
      //     return const Center(
      //       child: CupertinoActivityIndicator(),
      //     );
      //   },
      // ),
      // GestureDetector(
      //   onTap: () => {
      //     Navigator.pushNamed(
      //       context,
      //       routes.walletDetails,
      //     )
      //   },
      //   child: const WalletsItem(
      //     balance: "\$860,654.32",
      //     currency: "United States Dollar",
      //   ),
      // ),
      // const WalletsItem(
      //   balance: "€104,673.82",
      //   currency: "German Euro",
      // ),
      // const WalletsItem(
      //   balance: "£120,481.40",
      //   currency: "Great Britain Pound",
      // ),
      // === CREATE A WALLET === //
      // GestureDetector(
      //   onTap: () => {
      //     showDialog(
      //       context: context,
      //       builder: (BuildContext context) {
      //         return Dialog(
      //           insetPadding: const EdgeInsets.all(30),
      //           child: Column(
      //             children: [
      //               Text(
      //                 "Choose a Wallet",
      //                 style: Theme.of(context).textTheme.subtitle1,
      //               ),
      //               ListItemTwo(
      //                 image:
      //                     "https://upload.wikimedia.org/wikipedia/en/thumb/a/a4/Flag_of_the_United_States.svg/2560px-Flag_of_the_United_States.svg.png",
      //                 title: "United States Dollar",
      //                 subtitle: "With an Account Number and BSB Code",
      //               ),
      //             ],
      //           ),
      //         );
      //       },
      //     ),
      //   },
      //   child: Column(
      //     children: [
      //       Container(
      //         decoration: BoxDecoration(
      //           borderRadius: BorderRadius.circular(60),
      //           border: Border.all(
      //             color: XMColors.light,
      //             width: 1.5,
      //           ),
      //         ),
      //         padding: const EdgeInsets.all(18),
      //         child: SvgPicture.asset(
      //           "assets/icons/add.svg",
      //           color: XMColors.light,
      //           width: 30,
      //           height: 30,
      //         ),
      //       ),
      //       const SizedBox(height: 18),
      //       Text(
      //         "Create Wallet",
      //         style: Theme.of(context).textTheme.subtitle2!.copyWith(
      //               color: XMColors.light,
      //             ),
      //       ),
      //     ],
      //   ),
      // ),
    ];
    AnimatedContainer walletSlider(images, index, active) {
      double margin = active ? 8.5 : 8.5;
      return AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
        margin: EdgeInsets.all(margin),
        child: Center(
          child: walletsItems[index],
        ),
      );
    }

    return Scaffold(
      backgroundColor: XMColors.light,
      extendBody: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: XMColors.primary,
                child: Column(
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.fromLTRB(16, 22, 16, 55),
                    //   child: PageTitleWidgets(
                    //     title: "Fola's Wallets",
                    //     titleColor: XMColors.light,
                    //     prefix: const CircleAvatar(
                    //       backgroundImage: NetworkImage(
                    //         "https://images.pexels.com/photos/2379005/pexels-photo-2379005.jpeg",
                    //       ),
                    //       radius: 23,
                    //     ),
                    //     suffix: Container(
                    //       decoration: BoxDecoration(
                    //         color: XMColors.primary_20,
                    //         borderRadius: BorderRadius.circular(45),
                    //       ),
                    //       padding: const EdgeInsets.all(12),
                    //       child: SvgPicture.asset(
                    //         "assets/icons/notification.svg",
                    //         width: 24,
                    //         height: 24,
                    //         color: XMColors.light,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 22, 16, 55),
                      child: TabPageTitle(
                        title: Text(
                          "Mobile Wallets",
                          style:
                              Theme.of(context).textTheme.subtitle1!.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: XMColors.light,
                                  ),
                        ),
                        suffix: [
                          GestureDetector(
                            onTap: () => Navigator.pushNamed(
                              context,
                              routes.notifications,
                            ),
                            child: SvgPicture.asset(
                              "assets/icons/notification.svg",
                              width: 24,
                              height: 24,
                              color: XMColors.light,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 100,
                      child: Align(
                        alignment: Alignment.center,
                        child: _userWallet == null || _userWallet!.isEmpty
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : PageView.builder(
                                pageSnapping: true,
                                scrollDirection: Axis.horizontal,
                                controller: _pageController,
                                physics: const BouncingScrollPhysics(),
                                itemCount: _userWallet!.length,
                                onPageChanged: (page) {
                                  setState(() {
                                    currentWallet = page;
                                  });
                                },
                                itemBuilder: (context, index) {
                                  // return Text(
                                  //     _userWallet![index].balance.toString());
                                  return GestureDetector(
                                    onTap: () => {
                                      Navigator.pushNamed(
                                        context,
                                        routes.walletDetails,
                                      )
                                    },
                                    child: WalletsItem(
                                      balance:
                                          "${_userWallet![index].balance.toString()} ${_userWallet![index].currency}",
                                    ),
                                  );
                                },
                              ),
                        // child: PageView.builder(
                        //   itemCount: walletsItems.length,
                        //   pageSnapping: true,
                        //   scrollDirection: Axis.horizontal,
                        //   controller: _pageController,
                        //   physics: const BouncingScrollPhysics(),
                        //   onPageChanged: (page) {
                        //     setState(() {
                        //       currentWallet = page;
                        //     });
                        //   },
                        //   itemBuilder: (context, index) {
                        //     bool active = index == currentWallet;
                        //     return walletSlider(
                        //       walletsItems,
                        //       index,
                        //       active,
                        //     );
                        //   },
                        // ),
                      ),
                    ),
                    // buildDot(3, context),
                    // const SizedBox(height: 34),
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          _userWallet!.length,
                          (index) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: buildDot(index, context),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 54, 16, 34),
                      child: Row(
                        children: [
                          Expanded(
                            child: RoundedButton(
                              text: "Add Cash",
                              action: () => {
                                // showMaterialModalBottomSheet(
                                //   context: context,
                                //   builder: (BuildContext context) {
                                //     return Wrap(
                                //       crossAxisAlignment:
                                //           WrapCrossAlignment.center,
                                //       alignment: WrapAlignment.center,
                                //       children: [
                                //         Container(
                                //           padding: const EdgeInsets.symmetric(
                                //             horizontal: 20,
                                //             vertical: 38,
                                //           ),
                                //           child: Column(
                                //             children: [
                                //               Text(
                                //                 "Fund Your Wallet",
                                //                 textAlign: TextAlign.center,
                                //                 style: Theme.of(context)
                                //                     .textTheme
                                //                     .subtitle1!
                                //                     .copyWith(
                                //                       fontWeight:
                                //                           FontWeight.w600,
                                //                     ),
                                //               ),
                                //               const SizedBox(height: 12),
                                //               Text(
                                //                 "You can fund your wallet using either your Bank Card or a Virtual Account (NGN Only)",
                                //                 textAlign: TextAlign.center,
                                //                 style: Theme.of(context)
                                //                     .textTheme
                                //                     .bodyText1!
                                //                     .copyWith(
                                //                       color: XMColors.gray,
                                //                     ),
                                //               ),
                                //               const SizedBox(height: 26),

                                //             ],
                                //           ),
                                //         ),
                                //       ],
                                //     );
                                //   },
                                // )
                                Get.toNamed(routes.chooseFundMethod)
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: RoundedButton(
                              text: "Exchange",
                              action: () => Navigator.pushNamed(
                                  context, routes.exchangeCash),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: RoundedButton(
                              text: "Withdraw",
                              action: () => Navigator.pushNamed(
                                context,
                                routes.withdraw,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 22,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Transactions",
                          style:
                              Theme.of(context).textTheme.subtitle1!.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(
                            "See All",
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: XMColors.primary_10,
                                      fontWeight: FontWeight.w600,
                                    ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const ListItemTwo(
                      image:
                          "https://i.pinimg.com/originals/37/3c/0d/373c0d8e4df8cdba7d355db584abc642.jpg",
                      title: "Wanda Maximoff",
                      subtitle: "Jun 21st, 2021",
                      amount: "-\$1,000.00",
                      amountColor: XMColors.red,
                    ),
                    const SizedBox(height: 17),
                    const ListItemTwo(
                      image:
                          "https://i.pinimg.com/736x/ad/24/4e/ad244e38de5b1613a322f0c7aeb9147f.jpg",
                      title: "Steve Rogers",
                      subtitle: "Jun 18th, 2020",
                      amount: "+\$2,500.99",
                      amountColor: XMColors.green,
                    ),
                    const SizedBox(height: 17),
                    const ListItemTwo(
                      image:
                          "http://images6.fanpop.com/image/photos/43700000/Natasha-Romanoff-Black-Widow-black-widow-43788570-720-720.jpg",
                      title: "Natasha Romanoff",
                      subtitle: "Jun 16th, 2022",
                      amount: "-\$1,350.00",
                      amountColor: XMColors.red,
                    ),
                    const SizedBox(height: 17),
                    const ListItemTwo(
                      image:
                          "https://cutewallpaper.org/21/images-of-tony-stark/Anthony-Stark-Marvel-Wiki-FANDOM-powered-by-Wikia.jpg",
                      title: "Anthony Stark",
                      subtitle: "Jun 14th, 2022",
                      amount: "+\$14,730.61",
                      amountColor: XMColors.green,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 8,
      width: currentWallet == index ? 28 : 8,
      decoration: currentWallet == index
          ? (BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: XMColors.light,
            ))
          : (BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: XMColors.light),
              color: XMColors.light,
            )),
    );
  }
}
