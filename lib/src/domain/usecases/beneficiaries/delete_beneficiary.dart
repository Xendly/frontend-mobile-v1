import 'package:dartz/dartz.dart';
import 'package:xendly_mobile/src/core/errors/failure.dart';
import 'package:xendly_mobile/src/data/repositories/beneficiaries_repo_impl.dart';
import 'package:xendly_mobile/src/domain/entities/misc_entity.dart';

class DeleteBeneficiaryUsecase {
  final BeneficiariesRepoImpl repository;
  DeleteBeneficiaryUsecase(this.repository);

  Future<Either<Failure, MiscEntity>> execute(int id) {
    return repository.deleteBeneficiaryRepo(id);
  }
}
