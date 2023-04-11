import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';

class TransactionListItem extends StatelessWidget {
  final String? image, title, subtitle, amount, entry, status;
  final String currency;
  final Color? amountColor;
  final Function()? action;
  const TransactionListItem({
    Key? key,
    this.image,
    this.title,
    this.entry,
    this.subtitle,
    this.action,
    required this.currency,
    this.amount,
    this.status,
    this.amountColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String theEntry = entry ?? 'debit';

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.6),
      color: XMColors.light,
      child: GestureDetector(
        onTap: action,
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: status == "credit"
                  ? XMColors.success0.withOpacity(0.1)
                  : XMColors.error0.withOpacity(0.1),
              child: theEntry == "credit"
                  ? const Icon(FlutterRemix.arrow_left_down_line,
                      size: 22, color: XMColors.success0)
                  : const Icon(
                      FlutterRemix.arrow_right_up_line,
                      size: 22,
                      color: XMColors.error0,
                    ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 2),
                  Text(
                    title ?? "",
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle ?? "",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: XMColors.shade3,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 4.0),
            Text(
              _buildAmount(),
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: status == "credit"
                        ? XMColors.success0
                        : XMColors.error0,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  String _buildAmount() {
    return currency == "NGN" ? '₦${amount ?? "0.00"}' : '\$${amount ?? "0.00"}';
  }
}
