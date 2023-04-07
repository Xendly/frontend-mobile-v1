import 'package:dartz/dartz.dart';
import 'package:xendly_mobile/src/core/errors/failure.dart';
import 'package:xendly_mobile/src/domain/entities/misc_entity.dart';
import 'package:xendly_mobile/src/domain/repositories/misc_repo.dart';

class GetAcctInfoUsecase {
  final MiscRepository repository;
  GetAcctInfoUsecase(this.repository);

  Future<Either<Failure, MiscEntity>> execute(Map<String, dynamic> data) {
    return repository.getAcctInfoRepo(data);
  }
}
