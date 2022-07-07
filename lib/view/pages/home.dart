import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xendly_mobile/view/pages/tabs/profile.dart';
import 'package:xendly_mobile/view/pages/tabs/transfer.dart';
import 'package:xendly_mobile/view/pages/tabs/wallets.dart';
import 'package:xendly_mobile/view/shared/colors.dart';
import 'package:xendly_mobile/view/shared/widgets.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int pageIndex = 0;
  final pages = [
    const Wallets(),
    const Transfer(),
    const Profile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: XMColors.light,
      extendBody: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overScroll) {
                overScroll.disallowIndicator();
                return true;
              },
              child: pages[pageIndex],
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        height: 95,
        padding: const EdgeInsets.fromLTRB(25, 10, 25, 25),
        decoration: BoxDecoration(
          color: XMColors.light,
          boxShadow: [
            BoxShadow(
              color: const Color(0XFF000000).withOpacity(0.3),
              blurRadius: 25.0,
              spreadRadius: 5.0,
              offset: const Offset(
                15.0,
                15.0,
              ),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      pageIndex = 0;
                    });
                  },
                  child: Column(
                    children: [
                      SvgPicture.asset("assets/icons/notification.svg",
                          height: 22,
                          width: 22,
                          color: pageIndex == 0
                              ? XMColors.primary
                              : XMColors.lightGray),
                      const SizedBox(
                        height: 10,
                      ),
                      pageIndex == 0
                          ? strongBody(
                              "Browse",
                              XMColors.primary,
                            )
                          : strongBody("Browse", XMColors.lightGray),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      pageIndex = 1;
                    });
                  },
                  child: Column(
                    children: [
                      SvgPicture.asset("assets/icons/notification.svg",
                          height: 22,
                          width: 22,
                          color: pageIndex == 1
                              ? XMColors.primary
                              : XMColors.lightGray),
                      const SizedBox(
                        height: 10,
                      ),
                      pageIndex == 1
                          ? strongBody(
                              "Transfer",
                              XMColors.primary,
                            )
                          : strongBody("Transfer", XMColors.lightGray),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      pageIndex = 2;
                    });
                  },
                  child: Column(
                    children: [
                      SvgPicture.asset("assets/icons/notification.svg",
                          height: 22,
                          width: 22,
                          color: pageIndex == 2
                              ? XMColors.primary
                              : XMColors.lightGray),
                      const SizedBox(
                        height: 10,
                      ),
                      pageIndex == 2
                          ? strongBody(
                              "Sell",
                              XMColors.primary,
                            )
                          : strongBody("Sell", XMColors.lightGray),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
