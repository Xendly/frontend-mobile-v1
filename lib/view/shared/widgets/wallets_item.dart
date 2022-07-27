import 'package:flutter/material.dart';
import 'package:xendly_mobile/view/shared/colors.dart';

class WalletsItem extends StatelessWidget {
  final String? currency;
  final String? balance;
  const WalletsItem({
    Key? key,
    this.currency,
    this.balance,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          balance ?? "0.00",
          style: Theme.of(context).textTheme.headline4!.copyWith(
                color: XMColors.light,
                fontWeight: FontWeight.w600,
                fontFamily: "TTFirsNeue",
              ),
        ),
        const SizedBox(height: 4),
        Text(
          currency ?? "Currency Type",
          style: Theme.of(context).textTheme.subtitle2!.copyWith(
                color: XMColors.gray_50,
                fontWeight: FontWeight.w500,
                fontFamily: "Gilroy",
              ),
        ),
      ],
    );
  }
}
