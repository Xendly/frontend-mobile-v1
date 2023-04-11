import 'package:dartz/dartz.dart';
import 'package:xendly_mobile/src/core/errors/exception.dart';
import 'package:xendly_mobile/src/core/errors/failure.dart';
import 'package:xendly_mobile/src/data/data_sources/beneficiaries_data_source/data_source.dart';
import 'package:xendly_mobile/src/domain/entities/misc_entity.dart';
import 'package:xendly_mobile/src/domain/repositories/beneficiaries_repo.dart';

class BeneficiariesRepoImpl implements BeneficiariesRepo {
  final BeneficiariesDataSource dataSource;
  BeneficiariesRepoImpl(this.dataSource);

  // delete beneficiaries
  @override
  Future<Either<Failure, MiscEntity>> deleteBeneficiaryRepo(int id) async {
    try {
      final result = await dataSource.deleteBeneficiary(id);
      return Right(result.toEntity());
    } on ServerException catch (failure) {
      return Left(
        ServerFailure(failure.error.message),
      );
    }
  }

  // get beneficiaries
  @override
  Future<Either<Failure, MiscEntity>> getBeneficiariesRepo() async {
    try {
      final result = await dataSource.getBeneficiaries();
      return Right(result.toEntity());
    } on ServerException catch (failure) {
      return Left(
        ServerFailure(failure.error.message),
      );
    }
  }

  // bank beneficiaries
  @override
  Future<Either<Failure, MiscEntity>> createBankBeneficiaryRepo(
      Map<String, dynamic> data) async {
    try {
      final result = await dataSource.createBankBeneficiary(data);
      return Right(result.toEntity());
    } on ServerException catch (failure) {
      return Left(
        ServerFailure(failure.error.message),
      );
    }
  }
}
