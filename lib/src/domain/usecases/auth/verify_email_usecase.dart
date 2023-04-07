import 'package:dartz/dartz.dart';
import 'package:xendly_mobile/src/core/errors/failure.dart';
import 'package:xendly_mobile/src/domain/entities/auth_entity.dart';
import 'package:xendly_mobile/src/domain/repositories/auth_repo.dart';

class VerifyEmailUseCase {
  final AuthRepository repository;
  VerifyEmailUseCase(this.repository);

  Future<Either<Failure, AuthEntity>> execute(Map<String, dynamic> data) {
    return repository.verifyEmailRepo(data);
  }
}
