
import 'package:xendly_mobile/src/data/models/transaction_model.dart';

abstract class TransactionDataSource {
  Future<TransactionModel> createPaymentLink(Map<String, dynamic> data);
  Future<TransactionModel> getTransactions();
  Future<TransactionModel> getCurrencyTransactions(String gcurrency);
}
