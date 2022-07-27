import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xendly_mobile/controller/core/wallet_auth.dart';
import 'package:xendly_mobile/model/wallet_model.dart';
import 'package:xendly_mobile/view/pages/tabs/my_profile.dart';
import '../pages/tabs/profile.dart';
import '../pages/tabs/transfer.dart';
import '../pages/tabs/wallets.dart';
import '../shared/colors.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;
  final tabPages = [
    const Wallets(),
    const Transfer(),
    const MyProfile(),
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
              child: tabPages[selectedIndex],
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: XMColors.light,
        elevation: 25,
        selectedLabelStyle: const TextStyle(
          height: 0.7,
        ),
        unselectedLabelStyle: const TextStyle(
          height: 0.7,
        ),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(
                top: 4,
                bottom: 4,
              ),
              child: Column(
                children: [
                  selectedIndex == 0
                      ? SvgPicture.asset('assets/icons/bold/wallet-4.svg',
                          color: selectedIndex == 0
                              ? XMColors.dark
                              : XMColors.gray)
                      : SvgPicture.asset('assets/icons/wallet-4.svg',
                          color: selectedIndex == 0
                              ? XMColors.dark
                              : XMColors.gray),
                  const SizedBox(height: 6),
                  Text(
                    "Wallets",
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: selectedIndex == 0
                              ? XMColors.dark
                              : XMColors.gray,
                        ),
                  ),
                ],
              ),
            ),
            label: "Wallets",
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(
                top: 4,
                bottom: 4,
              ),
              child: Column(
                children: [
                  selectedIndex == 1
                      ? SvgPicture.asset('assets/icons/bold/dollar-circle.svg',
                          color: selectedIndex == 1
                              ? XMColors.dark
                              : XMColors.gray)
                      : SvgPicture.asset('assets/icons/dollar-circle.svg',
                          color: selectedIndex == 1
                              ? XMColors.dark
                              : XMColors.gray),
                  const SizedBox(height: 6),
                  Text(
                    "Transfer",
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: selectedIndex == 1
                              ? XMColors.dark
                              : XMColors.gray,
                        ),
                  ),
                ],
              ),
            ),
            label: "Transfer",
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(
                top: 4,
                bottom: 4,
              ),
              child: Column(
                children: [
                  selectedIndex == 2
                      ? SvgPicture.asset('assets/icons/bold/setting-2.svg',
                          color: selectedIndex == 2
                              ? XMColors.dark
                              : XMColors.gray)
                      : SvgPicture.asset('assets/icons/setting-2.svg',
                          color: selectedIndex == 2
                              ? XMColors.dark
                              : XMColors.gray),
                  const SizedBox(height: 6),
                  Text(
                    "Settings",
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: selectedIndex == 2
                              ? XMColors.dark
                              : XMColors.gray,
                        ),
                  ),
                ],
              ),
            ),
            label: "Settings",
          ),
        ],
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        currentIndex: selectedIndex,
      ),
    );
  }
}
