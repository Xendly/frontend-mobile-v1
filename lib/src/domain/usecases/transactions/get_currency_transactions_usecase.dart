import 'package:dartz/dartz.dart';
import 'package:xendly_mobile/src/core/errors/failure.dart';
import 'package:xendly_mobile/src/domain/entities/transaction_entity.dart';
import 'package:xendly_mobile/src/domain/repositories/transactions_repo.dart';

class GetCurrencyTransactionsUsecase {
  final TransactionRepo repository;
  GetCurrencyTransactionsUsecase(this.repository);

  Future<Either<Failure, TransactionEntity>> execute(String currency) {
    return repository.getCurrencyTransactionsRepo(currency);
  }
}
