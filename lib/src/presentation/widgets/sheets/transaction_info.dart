// show more info on a transaction
import 'package:flutter/material.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/widgets/info_row.dart';

transactionInfo({
  required String amount,
  required String note,
  required String status,
  required Color statusColor,
  required String refId,
  required String date,
  required BuildContext context,
}) {
  final textTheme = Theme.of(context).textTheme;

  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Wrap(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 34,
            ),
            color: XMColors.shade6,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Transaction Details",
                  style: textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 30),
                infoRow(
                  "Amount",
                  amount,
                  XMColors.shade0,
                  context,
                ),
                const SizedBox(height: 32),
                infoRow(
                  "Note",
                  note,
                  XMColors.shade0,
                  context,
                ),
                const SizedBox(height: 32),
                infoRow(
                  "Status",
                  status,
                  statusColor,
                  context,
                ),
                const SizedBox(height: 32),
                infoRow(
                  "Ref ID",
                  refId,
                  Colors.black,
                  context,
                ),
                const SizedBox(height: 32),
                infoRow(
                  "Date",
                  date,
                  Colors.black,
                  context,
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}
