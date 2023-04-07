import 'package:dartz/dartz.dart';
import 'package:xendly_mobile/src/core/errors/exception.dart';
import 'package:xendly_mobile/src/core/errors/failure.dart';
import 'package:xendly_mobile/src/data/data_sources/transaction_data_source/data_source.dart';
import 'package:xendly_mobile/src/domain/entities/transaction_entity.dart';
import 'package:xendly_mobile/src/domain/repositories/transactions_repo.dart';

class TransactionRepoImpl implements TransactionRepo {
  final TransactionDataSource dataSource;
  TransactionRepoImpl(this.dataSource);

  // >>> Create Payment Link <<< //
  @override
  Future<Either<Failure, TransactionEntity>> createPaymentLinkRepo(
      Map<String, dynamic> data) async {
    try {
      final result = await dataSource.createPaymentLink(data);
      return Right(result.toEntity());
    } on ServerException catch (failure) {
      return Left(
        ServerFailure(failure.error.message),
      );
    }
  }

  // transactions summary repo
  @override
  Future<Either<Failure, TransactionEntity>> getTransactionsRepo() async {
    try {
      final result = await dataSource.getTransactions();
      return Right(result.toEntity());
    } on ServerException catch (failure) {
      return Left(
        ServerFailure(failure.error.message),
      );
    }
  }

  // currency transactions summary repo
  @override
  Future<Either<Failure, TransactionEntity>> getCurrencyTransactionsRepo(String currency) async {
    try {
      final result = await dataSource.getCurrencyTransactions(currency);
      return Right(result.toEntity());
    } on ServerException catch (failure) {
      return Left(
        ServerFailure(failure.error.message),
      );
    }
  }
}
