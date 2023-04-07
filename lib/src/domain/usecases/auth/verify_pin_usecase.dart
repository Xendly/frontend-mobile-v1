import 'package:dartz/dartz.dart';
import 'package:xendly_mobile/src/core/errors/failure.dart';
import 'package:xendly_mobile/src/domain/entities/auth_entity.dart';
import 'package:xendly_mobile/src/domain/repositories/auth_repo.dart';

class VerifyPinUseCase {
  final AuthRepository repository;
  VerifyPinUseCase(this.repository);

  Future<Either<Failure, AuthEntity>> execute(Map<String, dynamic> data) {
    return repository.verifyPinRepo(data);
  }
}
