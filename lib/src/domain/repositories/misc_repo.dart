import 'package:dartz/dartz.dart';
import 'package:xendly_mobile/src/core/errors/failure.dart';
import 'package:xendly_mobile/src/domain/entities/misc_entity.dart';

abstract class MiscRepository {
  Future<Either<Failure, MiscEntity>> getRateRepo(String from, String to);
  Future<Either<Failure, MiscEntity>> getBanksRepo();
  Future<Either<Failure, MiscEntity>> getBanksListRepo();
  Future<Either<Failure, MiscEntity>> getAcctInfoRepo(
      Map<String, dynamic> data);
  Future<Either<Failure, MiscEntity>> resolveAccountRepo(
      Map<String, dynamic> data);
}
