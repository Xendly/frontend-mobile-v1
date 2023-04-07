import 'package:dartz/dartz.dart';
import 'package:xendly_mobile/src/core/errors/failure.dart';
import 'package:xendly_mobile/src/domain/entities/transaction_entity.dart';
import 'package:xendly_mobile/src/domain/repositories/transactions_repo.dart';

class CreatePaymentLinkUseCase {
  final TransactionRepo repository;
  CreatePaymentLinkUseCase(this.repository);

  Future<Either<Failure, TransactionEntity>> execute(
      Map<String, dynamic> data) {
    return repository.createPaymentLinkRepo(data);
  }
}
