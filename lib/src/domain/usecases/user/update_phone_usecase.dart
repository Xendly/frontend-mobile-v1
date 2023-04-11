import 'package:dartz/dartz.dart';
import 'package:xendly_mobile/src/core/errors/failure.dart';
import 'package:xendly_mobile/src/domain/entities/user_entity.dart';
import 'package:xendly_mobile/src/domain/repositories/user_repo.dart';

class UpdatePhoneUsecase {
  final UserRepository repository;
  UpdatePhoneUsecase(this.repository);

  Future<Either<Failure, UserEntity>> execute(String? phone) {
    return repository.updatePhone(phone);
  }
}
