import 'package:dartz/dartz.dart';
import 'package:xendly_mobile/src/core/errors/failure.dart';
import 'package:xendly_mobile/src/domain/entities/user_entity.dart';
import 'package:xendly_mobile/src/domain/repositories/user_repo.dart';

class GetUserDataUsecase {
  final UserRepository repository;
  GetUserDataUsecase(this.repository);

  Future<Either<Failure, UserEntity>> execute(String username) {
    return repository.getUserDataRepo(username);
  }
}
