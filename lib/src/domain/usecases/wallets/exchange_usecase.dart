import 'package:dartz/dartz.dart';
import 'package:xendly_mobile/src/core/errors/failure.dart';
import 'package:xendly_mobile/src/domain/entities/wallet_entity.dart';
import 'package:xendly_mobile/src/domain/repositories/wallet_repo.dart';

class ExchangeUsecase {
  final WalletRepository repository;
  ExchangeUsecase(this.repository);

  Future<Either<Failure, WalletEntity>> execute(Map<String, dynamic> data) {
    return repository.exchangeRepo(data);
  }
}
