import 'package:dartz/dartz.dart';
import 'package:xendly_mobile/src/core/errors/failure.dart';
import 'package:xendly_mobile/src/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<Either<Failure, UserEntity>> getUserDataRepo(String username);
  Future<Either<Failure, UserEntity>> updatePinRepo(Map<String, dynamic> data);
  Future<Either<Failure, UserEntity>> bvnVerificationRepo(
      Map<String, dynamic> data);
  Future<Either<Failure, UserEntity>> updateAddressRepo(
      Map<String, dynamic> data);
  Future<Either<Failure, UserEntity>> updateUsername(String? username);
  Future<Either<Failure, UserEntity>> updatePhone(String? phone);
  Future<Either<Failure, UserEntity>> getProfileRepo();
  Future<Either<Failure, UserEntity>> virtualAcctRepo(
    Map<String, dynamic> data,
  );
}
