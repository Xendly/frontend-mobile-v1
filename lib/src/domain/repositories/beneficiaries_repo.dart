import 'package:dartz/dartz.dart';
import 'package:xendly_mobile/src/core/errors/failure.dart';
import 'package:xendly_mobile/src/domain/entities/misc_entity.dart';

abstract class BeneficiariesRepo {
  Future<Either<Failure, MiscEntity>> getBeneficiariesRepo();

  // bank beneficiaries
  Future<Either<Failure, MiscEntity>> createBankBeneficiaryRepo(Map<String, dynamic> data);  
}
