import 'package:dartz/dartz.dart';
import 'package:xendly_mobile/src/core/errors/failure.dart';
import 'package:xendly_mobile/src/domain/entities/auth_entity.dart';
import 'package:xendly_mobile/src/domain/repositories/auth_repo.dart';

class ResendOtpUsecase {
  final AuthRepository repository;
  ResendOtpUsecase(this.repository);

  Future<Either<Failure, AuthEntity>> execute(String? email) {
    return repository.resendOtpRepo(email);
  }
}
