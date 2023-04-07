import 'package:dartz/dartz.dart';
import 'package:xendly_mobile/src/core/errors/failure.dart';
import 'package:xendly_mobile/src/domain/entities/auth_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthEntity>> userLogin(Map<String, dynamic> data);
  Future<Either<Failure, AuthEntity>> signUpRepo(Map<String, dynamic> data);
  Future<Either<Failure, AuthEntity>> forgotPasswordRepo(
      Map<String, dynamic> data);
  Future<Either<Failure, AuthEntity>> resetPasswordRepo(
    Map<String, dynamic> data,
  );
  Future<Either<Failure, AuthEntity>> verifyEmailRepo(
      Map<String, dynamic> data);
  Future<Either<Failure, AuthEntity>> loginAuthRepo(Map<String, dynamic> data);
  Future<Either<Failure, AuthEntity>> createPinRepo(Map<String, dynamic> data);
  Future<Either<Failure, AuthEntity>> verifyPinRepo(Map<String, dynamic> data);
  Future<Either<Failure, AuthEntity>> resendOtpRepo(String? email);
  Future<Either<Failure, AuthEntity>> logoutRepo();
}
