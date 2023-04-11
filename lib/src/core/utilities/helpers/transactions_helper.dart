import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:xendly_mobile/src/core/utilities/helpers/capitalize_helper.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/iconsax_icons.dart';
import 'package:xendly_mobile/src/presentation/widgets/sheets/transaction_info.dart';

import '../../../presentation/widgets/transaction_list_item.dart';

String formatAmount(String a) => a.replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );

Widget buildShimmer() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: ListView.builder(
      itemCount: 8,
      shrinkWrap: true,
      itemBuilder: (_, __) => Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: shimmerItem(),
      ),
    ),
  );
}

Widget shimmerItem() {
  return Row(
    children: <Widget>[
      Container(
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        height: 40.0,
        width: 40.0,
      ),
      const SizedBox(
        width: 12.0,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 120.0,
            height: 8.0,
            color: Colors.white,
          ),
          const SizedBox(
            height: 12.0,
          ),
          Container(
            width: 60.0,
            height: 8.0,
            color: Colors.white,
          ),
        ],
      ),
      const Spacer(),
      Container(
        width: 40.0,
        height: 8.0,
        color: Colors.white,
      ),
    ],
  );
}

// show transactions history //
Widget userTransactions(
  bool isLoading,
  List transactions,
  BuildContext context, [
  dynamic Function()? action,
]) {
  if (isLoading) {
    return buildShimmer();
  }
  if (transactions.isEmpty) {
    return emptyTransactions(context);
  } else {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (_, index) {
        final transaction = transactions[index];
        return TransactionListItem(
          action: () => transactionInfo(
            amount:
                "${transaction['currency'] == 'USD' ? '\$' : '₦'}${transaction['amount'].toString()}",
            note: transaction['title'].toString(),
            status: capitalizeLetter(transaction['status'].toString()),
            statusColor: transaction['status'] == "success"
                ? XMColors.success0
                : transaction['status'] == "pending"
                    ? Colors.orange.shade400
                    : XMColors.error0,
            refId: transaction['meta_data'].toString(),
            date: DateFormat.yMMMEd().format(
              DateTime.parse(transaction['created_at']),
            ),
            context: context,
          ),
          currency: transaction['currency'].toString(),
          title: transaction['title'].toString(),
          subtitle: DateFormat.yMMMEd().format(
            DateTime.parse(transaction['created_at']),
          ),
          amount: formatAmount(transaction['amount'].toString()),
          status: transaction['status'],
          entry: transaction['entry'],
        );
      },
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemCount: transactions.length,
    );
  }
}

Widget emptyTransactions(BuildContext context) {
  return SizedBox(
    height: MediaQuery.of(context).size.height * 0.4,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(
          Iconsax.receipt,
          size: 46,
        ),
        const SizedBox(height: 18),
        Text(
          "No transactions",
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

Widget emptyData(BuildContext context, String text, IconData icon) {
  return SizedBox(
    height: MediaQuery.of(context).size.height * 0.6,
    width: double.infinity,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 44,
        ),
        const SizedBox(height: 10),
        Text(
          text,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}
