import 'package:dartz/dartz.dart';
import 'package:xendly_mobile/src/core/errors/failure.dart';
import 'package:xendly_mobile/src/domain/entities/transaction_entity.dart';

abstract class TransactionRepo {
  Future<Either<Failure, TransactionEntity>> createPaymentLinkRepo(
      Map<String, dynamic> data);
  Future<Either<Failure, TransactionEntity>> getTransactionsRepo();
  Future<Either<Failure, TransactionEntity>> getCurrencyTransactionsRepo(String currency);
}
