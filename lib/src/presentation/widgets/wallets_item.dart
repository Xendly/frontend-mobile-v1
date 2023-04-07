import 'package:flutter/material.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/config/utilities.dart';

class WalletsItem extends StatelessWidget {
  final String currency;
  final String? balance;

  const WalletsItem({
    Key? key,
    required this.currency,
    this.balance,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '$currency ${_formatAmount(balance!)}',
          style: Theme.of(context).textTheme.headline3!.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          getCurrency(currency),
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: XMColors.gray,
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }

  String _formatAmount(String a) => a.replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (Match m) => '${m[1]},',
      );
}
