import 'package:dartz/dartz.dart';
import 'package:xendly_mobile/src/core/errors/failure.dart';
import 'package:xendly_mobile/src/data/repositories/beneficiaries_repo_impl.dart';
import 'package:xendly_mobile/src/domain/entities/misc_entity.dart';

class CreateBankBeneficiaryUsecase {
  final BeneficiariesRepoImpl repository;
  CreateBankBeneficiaryUsecase(this.repository);

  Future<Either<Failure, MiscEntity>> execute(Map<String, dynamic> data) {
    return repository.createBankBeneficiaryRepo(data);
  }
}
