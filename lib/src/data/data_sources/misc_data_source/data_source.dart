import 'package:xendly_mobile/src/data/models/misc_model.dart';

abstract class MiscDataSource {
  Future<MiscModel> getRate(String from, String to);
  Future<MiscModel> getBanks();
  Future<MiscModel> getBanksList();
  Future<MiscModel> resolveAccount(Map<String, dynamic> data);
  Future<MiscModel> getAcctInfo(Map<String, dynamic> data);
}
