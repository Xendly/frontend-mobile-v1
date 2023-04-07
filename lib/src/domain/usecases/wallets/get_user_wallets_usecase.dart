import 'package:dartz/dartz.dart';
import 'package:xendly_mobile/src/core/errors/failure.dart';
import 'package:xendly_mobile/src/domain/entities/wallet_entity.dart';
import 'package:xendly_mobile/src/domain/repositories/wallet_repo.dart';

class GetUserWalletsUseCase {
  final WalletRepository repository;
  GetUserWalletsUseCase(this.repository);

  Future<Either<Failure, WalletEntity>> execute() {
    return repository.getUserWalletsRepo();
  }
}
