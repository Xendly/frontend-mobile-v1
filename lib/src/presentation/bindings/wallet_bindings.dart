import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:xendly_mobile/src/data/data_sources/wallet_data_source/data_source_impl.dart';
import 'package:xendly_mobile/src/data/repositories/wallets_repo_impl.dart';
import 'package:xendly_mobile/src/domain/usecases/wallets/bank_transfer_usecase.dart';
import 'package:xendly_mobile/src/domain/usecases/wallets/get_user_wallets_usecase.dart';
import 'package:xendly_mobile/src/domain/usecases/wallets/p2p_transfer_usecase.dart';
import 'package:xendly_mobile/src/presentation/view_model/wallets/bank_transfer_controller.dart';
import 'package:xendly_mobile/src/presentation/view_model/wallets/get_user_wallets_controller.dart';
import 'package:xendly_mobile/src/presentation/view_model/wallets/p2p_transfer_controller.dart';
import 'package:xendly_mobile/src/domain/usecases/wallets/exchange_usecase.dart';
import 'package:xendly_mobile/src/presentation/view_model/wallets/exchange_controller.dart';

class WalletBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => http.Client());
    Get.lazyPut(() => WalletDataSourceImpl(Get.find<http.Client>()));
    Get.lazyPut(() => WalletRepoImpl(Get.find<WalletDataSourceImpl>()));
    // >>> Get User Wallets Binding <<< //
    Get.lazyPut(() => GetUserWalletsUseCase(Get.find<WalletRepoImpl>()));
    Get.put(() => GetUserWalletsController(Get.find<GetUserWalletsUseCase>()));
    // p2p transfer wallet binding
    Get.lazyPut(() => P2PTransferUsecase(Get.find<WalletRepoImpl>()));
    Get.put(() => P2PTransferController(Get.find<P2PTransferUsecase>()));
    // currency exchange binding
    Get.lazyPut(() => ExchangeUsecase(Get.find<WalletRepoImpl>()));
    Get.put(() => ExchangeController(Get.find<ExchangeUsecase>()));
    // bank transfer binding
    Get.lazyPut(() => BankTransferUsecase(Get.find<WalletRepoImpl>()));
    Get.put(() => BankTransferController(Get.find<BankTransferUsecase>()));
  }
}
