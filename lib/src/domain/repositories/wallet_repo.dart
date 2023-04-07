import 'package:dartz/dartz.dart';
import 'package:xendly_mobile/src/core/errors/failure.dart';
import 'package:xendly_mobile/src/domain/entities/wallet_entity.dart';

abstract class WalletRepository {
  Future<Either<Failure, WalletEntity>> getUserWalletsRepo();
  Future<Either<Failure, WalletEntity>> p2pTransferRepo(
      Map<String, dynamic> data);
  Future<Either<Failure, WalletEntity>> exchangeRepo(
      Map<String, dynamic> data);
  Future<Either<Failure, WalletEntity>> bankTransferRepo(
      Map<String, dynamic> data);
}
