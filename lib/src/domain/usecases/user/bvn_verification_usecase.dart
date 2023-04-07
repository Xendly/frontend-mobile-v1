import 'package:dartz/dartz.dart';
import 'package:xendly_mobile/src/core/errors/failure.dart';
import 'package:xendly_mobile/src/domain/entities/user_entity.dart';
import 'package:xendly_mobile/src/domain/repositories/user_repo.dart';

class BvnVerificationUsecase {
  final UserRepository repository;
  BvnVerificationUsecase(this.repository);

  Future<Either<Failure, UserEntity>> execute(Map<String, dynamic> data) {
    return repository.bvnVerificationRepo(data);
  }
}
