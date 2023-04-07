import 'package:dartz/dartz.dart';
import 'package:xendly_mobile/src/core/errors/exception.dart';
import 'package:xendly_mobile/src/core/errors/failure.dart';
import 'package:xendly_mobile/src/data/data_sources/wallet_data_source/data_source.dart';
import 'package:xendly_mobile/src/domain/entities/wallet_entity.dart';
import 'package:xendly_mobile/src/domain/repositories/wallet_repo.dart';

class WalletRepoImpl implements WalletRepository {
  final WalletDataSource dataSource;
  WalletRepoImpl(this.dataSource);

  // >>> Get User Wallets <<< //
  @override
  Future<Either<Failure, WalletEntity>> getUserWalletsRepo() async {
    try {
      final result = await dataSource.getUserWallets();
      return Right(result.toEntity());
    } on ServerException catch (failure) {
      return Left(
        ServerFailure(failure.error.message),
      );
    }
  }

  // peer to peer transfer repo
  @override
  Future<Either<Failure, WalletEntity>> p2pTransferRepo(
      Map<String, dynamic> data) async {
    try {
      final result = await dataSource.p2pTransfer(data);
      return Right(result.toEntity());
    } on ServerException catch (failure) {
      return Left(
        ServerFailure(failure.error.message),
      );
    }
  }

  // currency exchange repo
  @override
  Future<Either<Failure, WalletEntity>> exchangeRepo(
      Map<String, dynamic> data) async {
    try {
      final result = await dataSource.exchange(data);
      return Right(result.toEntity());
    } on ServerException catch (failure) {
      return Left(
        ServerFailure(failure.error.message),
      );
    }
  }

  // bank transfers repo - enable withdrawal to local banks
  @override
  Future<Either<Failure, WalletEntity>> bankTransferRepo(
      Map<String, dynamic> data) async {
    try {
      final result = await dataSource.bankTransfer(data);
      return Right(result.toEntity());
    } on ServerException catch (failure) {
      return Left(
        ServerFailure(failure.error.message),
      );
    }
  }
}
