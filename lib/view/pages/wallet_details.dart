import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xendly_mobile/view/shared/colors.dart';
import 'package:xendly_mobile/view/shared/widgets/list_item_2.dart';
import 'package:xendly_mobile/view/shared/widgets/page_title_widgets.dart';

class WalletDetails extends StatelessWidget {
  const WalletDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: XMColors.light,
      extendBody: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 22, 16, 55),
                child: PageTitleWidgets(
                  title: "USD Wallet",
                  titleColor: XMColors.dark,
                  prefix: SvgPicture.asset(
                    "assets/icons/arrow-left-1.svg",
                    width: 24,
                    height: 24,
                    color: XMColors.dark,
                  ),
                  suffix: SvgPicture.asset(
                    "assets/icons/more.svg",
                    width: 24,
                    height: 24,
                    color: XMColors.dark,
                  ),
                ),
              ),
              Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.network(
                      "https://upload.wikimedia.org/wikipedia/en/thumb/a/a4/Flag_of_the_United_States.svg/2560px-Flag_of_the_United_States.svg.png",
                      width: 62,
                      height: 62,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "\$860,654.32",
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                          fontWeight: FontWeight.w600,
                          fontFamily: "TTFirsNeue",
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Available Balance",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: XMColors.gray_50,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 38),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Flex(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      direction: Axis.horizontal,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: XMColors.gray_70,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                padding: const EdgeInsets.all(20),
                                child: SvgPicture.asset(
                                  "assets/icons/wallet-add.svg",
                                  width: 26,
                                  height: 26,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                "Fund",
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: XMColors.gray_70,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                padding: const EdgeInsets.all(20),
                                child: SvgPicture.asset(
                                  "assets/icons/wallet-remove.svg",
                                  width: 26,
                                  height: 26,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                "Withdraw",
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: XMColors.gray_70,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                padding: const EdgeInsets.all(20),
                                child: SvgPicture.asset(
                                  "assets/icons/wallet-money.svg",
                                  width: 26,
                                  height: 26,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                "Send",
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: XMColors.gray_70,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                padding: const EdgeInsets.all(20),
                                child: SvgPicture.asset(
                                  "assets/icons/bank.svg",
                                  width: 26,
                                  height: 26,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                "Details",
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 24,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Transactions",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text(
                                "See All",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
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
            ],
          ),
        ),
      ),
    );
  }
}
