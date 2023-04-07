import 'package:dartz/dartz.dart';
import 'package:xendly_mobile/src/core/errors/exception.dart';
import 'package:xendly_mobile/src/core/errors/failure.dart';
import 'package:xendly_mobile/src/data/data_sources/auth_data_sources/data_source.dart';
import 'package:xendly_mobile/src/domain/entities/auth_entity.dart';
import 'package:xendly_mobile/src/domain/repositories/auth_repo.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource dataSource;
  AuthRepositoryImpl(this.dataSource);

  // >>> User Login <<< //
  @override
  Future<Either<Failure, AuthEntity>> userLogin(
      Map<String, dynamic> data) async {
    try {
      final result = await dataSource.userLogin(data);
      return Right(result.toEntity());
    } on ServerException catch (failure) {
      return Left(
        ServerFailure(failure.error.message),
      );
    }
  }

  // >>> Create transaction pin <<< //
  @override
  Future<Either<Failure, AuthEntity>> createPinRepo(
      Map<String, dynamic> data) async {
    try {
      final result = await dataSource.createPin(data);
      return Right(result.toEntity());
    } on ServerException catch (failure) {
      return Left(
        ServerFailure(failure.error.message),
      );
    }
  }

  // >>> Register a User <<< //
  @override
  Future<Either<Failure, AuthEntity>> signUpRepo(
      Map<String, dynamic> data) async {
    try {
      final result = await dataSource.signUp(data);
      return Right(result.toEntity());
    } on ServerException catch (failure) {
      return Left(
        ServerFailure(failure.error.message),
      );
    }
  }

  // >>> Authorize User Login <<< //
  @override
  Future<Either<Failure, AuthEntity>> loginAuthRepo(
      Map<String, dynamic> data) async {
    try {
      final result = await dataSource.loginAuth(data);
      return Right(result.toEntity());
    } on ServerException catch (failure) {
      return Left(
        ServerFailure(failure.error.message),
      );
    }
  }

  // >>> Forgot a Password <<< //
  @override
  Future<Either<Failure, AuthEntity>> forgotPasswordRepo(
      Map<String, dynamic> data) async {
    try {
      final result = await dataSource.forgotPassword(data);
      return Right(result.toEntity());
    } on ServerException catch (failure) {
      return Left(
        ServerFailure(failure.error.message),
      );
    }
  }

  @override
  Future<Either<Failure, AuthEntity>> resetPasswordRepo(
    Map<String, dynamic> data,
  ) async {
    try {
      final result = await dataSource.resetPassword(data);
      return Right(result.toEntity());
    } on ServerException catch (failure) {
      return Left(
        ServerFailure(failure.error.message),
      );
    }
  }

  // >>> Verify an Email <<< //
  @override
  Future<Either<Failure, AuthEntity>> verifyEmailRepo(
      Map<String, dynamic> data) async {
    try {
      final result = await dataSource.verifyEmail(data);
      return Right(result.toEntity());
    } on ServerException catch (failure) {
      return Left(
        ServerFailure(failure.error.message),
      );
    }
  }

  // resend verification otp
  @override
  Future<Either<Failure, AuthEntity>> resendOtpRepo(String? email) async {
    try {
      final result = await dataSource.resendOtp(email);
      return Right(result.toEntity());
    } on ServerException catch (failure) {
      return Left(
        ServerFailure(failure.error.message),
      );
    }
  }

  // >>> Verify PIN <<< //
  @override
  Future<Either<Failure, AuthEntity>> verifyPinRepo(
      Map<String, dynamic> data) async {
    try {
      final result = await dataSource.verifyPin(data);
      return Right(result.toEntity());
    } on ServerException catch (failure) {
      return Left(
        ServerFailure(failure.error.message),
      );
    }
  }

  // >>> Log Out Repo <<< //
  @override
  Future<Either<Failure, AuthEntity>> logoutRepo() async {
    try {
      final result = await dataSource.logout();
      return Right(result.toEntity());
    } on ServerException catch (failure) {
      return Left(
        ServerFailure(failure.error.message),
      );
    }
  }
}
