import 'package:dartz/dartz.dart';
import 'package:xendly_mobile/src/core/errors/exception.dart';
import 'package:xendly_mobile/src/core/errors/failure.dart';
import 'package:xendly_mobile/src/data/data_sources/misc_data_source/data_source.dart';
import 'package:xendly_mobile/src/data/data_sources/wallet_data_source/data_source.dart';
import 'package:xendly_mobile/src/domain/entities/misc_entity.dart';
import 'package:xendly_mobile/src/domain/entities/wallet_entity.dart';
import 'package:xendly_mobile/src/domain/repositories/misc_repo.dart';
import 'package:xendly_mobile/src/domain/repositories/wallet_repo.dart';

class MiscRepoImpl implements MiscRepository {
  final MiscDataSource dataSource;
  MiscRepoImpl(this.dataSource);

  // get conversion rates repo
  @override
  Future<Either<Failure, MiscEntity>> getRateRepo(
      String from, String to) async {
    try {
      final result = await dataSource.getRate(from, to);
      return Right(result.toEntity());
    } on ServerException catch (failure) {
      return Left(
        ServerFailure(failure.error.message),
      );
    }
  }



  // resolve account details
  @override
  Future<Either<Failure, MiscEntity>> resolveAccountRepo(
      Map<String, dynamic> data) async {
    try {
      final result = await dataSource.resolveAccount(data);
      return Right(result.toEntity());
    } on ServerException catch (failure) {
      return Left(
        ServerFailure(failure.error.message),
      );
    }
  }

  // resolve account details
  @override
  Future<Either<Failure, MiscEntity>> getAcctInfoRepo(
      Map<String, dynamic> data) async {
    try {
      final result = await dataSource.getAcctInfo(data);
      return Right(result.toEntity());
    } on ServerException catch (failure) {
      return Left(
        ServerFailure(failure.error.message),
      );
    }
  }

  // get banks repo
  @override
  Future<Either<Failure, MiscEntity>> getBanksRepo() async {
    try {
      final result = await dataSource.getBanks();
      return Right(result.toEntity());
    } on ServerException catch (failure) {
      return Left(
        ServerFailure(failure.error.message),
      );
    }
  }

  // get banks list
  @override
  Future<Either<Failure, MiscEntity>> getBanksListRepo() async {
    try {
      final result = await dataSource.getBanksList();
      return Right(result.toEntity());
    } on ServerException catch (failure) {
      return Left(
        ServerFailure(failure.error.message),
      );
    }
  }
}
