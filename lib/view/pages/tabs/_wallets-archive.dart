import 'package:draggable_bottom_sheet/draggable_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xendly_mobile/view/shared/widgets/buttons/rounded.dart';
import 'package:xendly_mobile/view/shared/widgets/page_title_widgets.dart';
import '../../shared/colors.dart';
import '../../shared/widgets.dart';
import '../../shared/widgets/solid_button.dart';

class Wallets extends StatefulWidget {
  const Wallets({Key? key}) : super(key: key);
  @override
  State<Wallets> createState() => _WalletsState();
}

class _WalletsState extends State<Wallets> {
  late PageController _pageController;
  int currentCard = 0;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 0.85,
      initialPage: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> walletCards = [
      walletCard(context),
      walletCard(context),
      walletCard(context),
      walletCard(context),
    ];
    AnimatedContainer cardSlider(images, index, active) {
      double margin = active ? 8.5 : 8.5;
      return AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
        margin: EdgeInsets.all(margin),
        child: Center(
          child: walletCards[index],
        ),
      );
    }

    return Scaffold(
      backgroundColor: XMColors.primary,
      extendBody: true,
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 24,
                ),
                child: Column(
                  children: [
                    PageTitleWidgets(
                      title: "John's Wallets",
                      titleColor: XMColors.light,
                      prefix: const CircleAvatar(
                        backgroundImage: NetworkImage(
                          "https://images.pexels.com/photos/2379005/pexels-photo-2379005.jpeg",
                        ),
                        radius: 23,
                      ),
                      suffix: Container(
                        decoration: BoxDecoration(
                          color: XMColors.primary_20,
                          borderRadius: BorderRadius.circular(45),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: SvgPicture.asset(
                          "assets/icons/notification.svg",
                          width: 24,
                          height: 24,
                          color: XMColors.light,
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    Column(
                      children: [
                        Text(
                          "\$987,654.32",
                          style:
                              Theme.of(context).textTheme.headline4!.copyWith(
                                    color: XMColors.light,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Canadian Dollar",
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: XMColors.gray_50,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 60),
                    Row(
                      children: [
                        Expanded(
                          child: RoundedButton(
                            text: "Add Money",
                            action: () => {},
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: RoundedButton(
                            text: "Exchange",
                            action: () => {},
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: DraggableScrollableSheet(
                    initialChildSize: 0.375,
                    minChildSize: 0.375,
                    maxChildSize: 0.698,
                    snap: true,
                    builder: (BuildContext context,
                        ScrollController scrollController) {
                      return Container(
                        color: XMColors.gray_90,
                        child: ListView.builder(
                          controller: scrollController,
                          itemCount: 12,
                          itemBuilder: (BuildContext context, int index) {
                            return listItem();
                          },
                        ),
                      );
                    },
                  ),
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
      width: currentCard == index ? 28 : 8,
      decoration: currentCard == index
          ? (BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: XMColors.primary,
            ))
          : (BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: XMColors.primary),
              color: XMColors.none,
            )),
    );
  }
}
