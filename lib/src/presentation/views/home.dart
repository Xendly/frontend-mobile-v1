import 'package:flutter/material.dart';
import '../../core/utilities/interfaces/colors.dart';
import '../../core/utilities/interfaces/iconsax_icons.dart';
import '../../presentation/views/tabs/my_profile.dart';
import '../../presentation/views/tabs/transfer.dart';
import '../../presentation/views/tabs/wallets.dart';
import '../../presentation/views/tabs/accounts.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;
  final tabPages = [
    const Wallets(),
    const Accounts(),
    const SendMoney(),
    const MyProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
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
        backgroundColor: XMColors.shade6,
        elevation: 10,
        selectedLabelStyle: const TextStyle(height: 1),
        unselectedLabelStyle: const TextStyle(height: 1),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Column(
              children: [
                Icon(
                  Iconsax.home,
                  size: 26,
                  color:
                      selectedIndex == 0 ? XMColors.primary : XMColors.shade3,
                ),
                const SizedBox(height: 6),
                Text(
                  "Home",
                  style: textTheme.bodyMedium?.copyWith(
                    color: selectedIndex == 0 ? XMColors.primary : XMColors.shade3,
                  ),
                ),
              ],
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Column(
              children: [
                Icon(
                  Iconsax.info_circle,
                  size: 26,
                  color:
                      selectedIndex == 1 ? XMColors.primary : XMColors.shade3,
                ),
                const SizedBox(height: 6),
                Text(
                  "Accounts",
                  style: textTheme.bodyMedium?.copyWith(
                    color: selectedIndex == 1 ? XMColors.primary : XMColors.shade3,
                  ),
                ),
              ],
            ),
            label: "Accounts",
          ),
          BottomNavigationBarItem(
            icon: Column(
              children: [
                Icon(
                  Iconsax.send,
                  size: 26,
                  color:
                      selectedIndex == 2 ? XMColors.primary : XMColors.shade3,
                ),
                const SizedBox(height: 6),
                Text(
                  "Send",
                  style: textTheme.bodyMedium?.copyWith(
                    color: selectedIndex == 2 ? XMColors.primary : XMColors.shade3,
                  ),
                ),
              ],
            ),
            label: "Send",
          ),
          BottomNavigationBarItem(
            icon: Column(
              children: [
                Icon(
                  Iconsax.setting_2,
                  size: 26,
                  color:
                      selectedIndex == 3 ? XMColors.primary : XMColors.shade3,
                ),
                const SizedBox(height: 6),
                Text(
                  "Settings",
                  style: textTheme.bodyMedium?.copyWith(
                    color: selectedIndex == 3 ? XMColors.primary : XMColors.shade3,
                  ),
                ),
              ],
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
