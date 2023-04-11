import 'package:xendly_mobile/src/data/models/misc_model.dart';

abstract class BeneficiariesDataSource {
  Future<MiscModel> getBeneficiaries();
  Future<MiscModel> deleteBeneficiary(int id);

  // bank beneficiaries
  Future<MiscModel> createBankBeneficiary(Map<String, dynamic> data);
}
