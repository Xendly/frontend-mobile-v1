import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:xendly_mobile/src/data/data_sources/misc_data_source/data_source_impl.dart';
import 'package:xendly_mobile/src/data/repositories/misc_repo_impl.dart';
import 'package:xendly_mobile/src/domain/usecases/misc/get_acct_info_usecase.dart';
import 'package:xendly_mobile/src/domain/usecases/misc/get_banks_list_usecase.dart';
import 'package:xendly_mobile/src/domain/usecases/misc/get_rate_usecase.dart';
import 'package:xendly_mobile/src/domain/usecases/misc/resolve_account_usecase.dart';
import 'package:xendly_mobile/src/features/withdrawal/presentation/logic/get_account_info_controller.dart';
import 'package:xendly_mobile/src/features/withdrawal/presentation/logic/get_banks_list_controller.dart';
import 'package:xendly_mobile/src/presentation/view_model/misc/get_rate_controller.dart';
import '../../domain/usecases/misc/get_banks_usecase.dart';
import '../../presentation/view_model/misc/get_banks_controller.dart';
import '../../presentation/view_model/misc/resolve_account_controller.dart';

class MiscBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => http.Client());
    Get.lazyPut(() => MiscDataSourceImpl(Get.find<http.Client>()));
    Get.lazyPut(() => MiscRepoImpl(Get.find<MiscDataSourceImpl>()));
    // get conversion rates
    Get.lazyPut(() => RateUsecase(Get.find<MiscRepoImpl>()));
    Get.put(() => RateController(Get.find<RateUsecase>()));
    // get the list of banks
    Get.lazyPut(() => GetBanksUsecase(Get.find<MiscRepoImpl>()));
    Get.put(() => GetBanksController(Get.find<GetBanksUsecase>()));
    // get the new list of banks
    Get.lazyPut(() => GetBanksListUsecase(Get.find<MiscRepoImpl>()));
    Get.put(() => GetBanksListController(Get.find<GetBanksListUsecase>()));
    // resolve account number
    Get.lazyPut(() => ResolveAccountUsecase(Get.find<MiscRepoImpl>()));
    Get.put(() => ResolveAccountController(Get.find<ResolveAccountUsecase>()));
    // resolve account number
    Get.lazyPut(() => GetAcctInfoUsecase(Get.find<MiscRepoImpl>()));
    Get.put(() => GetAcctInfoController(Get.find<GetAcctInfoUsecase>()));
  }
}
