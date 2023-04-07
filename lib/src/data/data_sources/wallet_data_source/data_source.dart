import 'package:xendly_mobile/src/data/models/wallet_model.dart';

abstract class WalletDataSource {
  Future<WalletModel> getUserWallets();
  Future<WalletModel> p2pTransfer(Map<String, dynamic> data);
  Future<WalletModel> exchange(Map<String, dynamic> data);
  Future<WalletModel> bankTransfer(Map<String, dynamic> data);
}
