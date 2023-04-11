import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:xendly_mobile/src/domain/usecases/transactions/get_transactions_usecase.dart';
import 'package:xendly_mobile/src/presentation/view_model/transactions/get_transactions_controller.dart';

import '../../../presentation/widgets/sheets/transaction_info.dart';
import '../../../presentation/widgets/transaction_list_item.dart';
import '../helpers/capitalize_helper.dart';
import '../helpers/transactions_helper.dart';
import '../interfaces/colors.dart';

class TransactionsList extends StatefulWidget {
  const TransactionsList({
    Key? key,
  }) : super(key: key);

  @override
  State<TransactionsList> createState() => _TransactionsListState();
}

class _TransactionsListState extends State<TransactionsList> {
  final controller = Get.put(
    TransactionsController(
      Get.find<GetTransactionsUsecase>(),
    ),
  );
  @override
  Widget build(BuildContext context) {
    controller.fetchTransactions();

    return GetBuilder<TransactionsController>(
      init: controller,
      builder: (_) {
        return controller.isLoading.value
            ? buildShimmer()
            : controller.data['transactions'].length == 0
                ? emptyTransactions(context)
                : ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemCount: controller.data['transactions'].length,
                    itemBuilder: (_, index) {
                      final transaction =
                          controller.data['transactions'][index];
                      return TransactionListItem(
                        action: () => transactionInfo(
                          amount:
                              "${transaction['currency'] == 'USD' ? '\$' : '₦'}${transaction['amount'].toString()}",
                          note: transaction['title'].toString(),
                          status:
                              capitalizeLetter(transaction['entry'].toString()),
                          statusColor: transaction['entry'] == "credit"
                              ? XMColors.success0
                              : transaction['entry'] == "debit"
                                  ? XMColors.error0
                                  : Colors.orange.shade400,
                          refId: transaction['reference'].toString(),
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
                        status: transaction['entry'],
                        entry: transaction['entry'],
                      );
                    },
                  );
      },
    );
  }
}
