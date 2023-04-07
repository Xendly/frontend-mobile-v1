import 'package:dartz/dartz.dart';
import 'package:xendly_mobile/src/core/errors/exception.dart';
import 'package:xendly_mobile/src/core/errors/failure.dart';
import 'package:xendly_mobile/src/data/data_sources/user_data_source/data_source.dart';
import 'package:xendly_mobile/src/domain/entities/user_entity.dart';
import 'package:xendly_mobile/src/domain/repositories/user_repo.dart';

class UserRepoImpl implements UserRepository {
  final UserDataSource dataSource;
  UserRepoImpl(this.dataSource);

  @override
  Future<Either<Failure, UserEntity>> getProfileRepo() async {
    try {
      final result = await dataSource.getProfile();
      return Right(result.toEntity());
    } on ServerException catch (failure) {
      return Left(
        ServerFailure(failure.error.message),
      );
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getUserDataRepo(String username) async {
    try {
      final result = await dataSource.getUserData(username);
      return Right(result.toEntity());
    } on ServerException catch (failure) {
      return Left(
        ServerFailure(failure.error.message),
      );
    }
  }

  @override
  Future<Either<Failure, UserEntity>> updatePinRepo(
      Map<String, dynamic> map) async {
    try {
      final result = await dataSource.updatePin(map);
      return Right(result.toEntity());
    } on ServerException catch (failure) {
      return Left(
        ServerFailure(failure.error.message),
      );
    }
  }

  @override
  Future<Either<Failure, UserEntity>> bvnVerificationRepo(
      Map<String, dynamic> map) async {
    try {
      final result = await dataSource.bvnVerification(map);
      return Right(result.toEntity());
    } on ServerException catch (failure) {
      return Left(
        ServerFailure(failure.error.message),
      );
    }
  }

  @override
  Future<Either<Failure, UserEntity>> updateAddressRepo(
      Map<String, dynamic> data) async {
    try {
      final result = await dataSource.updateAddress(data);
      return Right(result.toEntity());
    } on ServerException catch (failure) {
      return Left(
        ServerFailure(failure.error.message),
      );
    }
  }

  @override
  Future<Either<Failure, UserEntity>> virtualAcctRepo(
    Map<String, dynamic> data,
  ) async {
    try {
      final result = await dataSource.virtualAccount(data);
      return Right(result.toEntity());
    } on ServerException catch (failure) {
      return Left(
        ServerFailure(failure.error.message),
      );
    }
  }
}
