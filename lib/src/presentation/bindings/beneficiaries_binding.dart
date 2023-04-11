import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:xendly_mobile/src/data/data_sources/beneficiaries_data_source/data_source_impl.dart';
import 'package:xendly_mobile/src/data/repositories/beneficiaries_repo_impl.dart';
import 'package:xendly_mobile/src/domain/usecases/beneficiaries/create_bank_beneficiary_usecase.dart';
import 'package:xendly_mobile/src/domain/usecases/beneficiaries/delete_beneficiary.dart';
import 'package:xendly_mobile/src/domain/usecases/beneficiaries/get_beneficiaries_usecase.dart';
import 'package:xendly_mobile/src/presentation/view_model/beneficiaries/create_bank_beneficiary_controller.dart';
import 'package:xendly_mobile/src/presentation/view_model/beneficiaries/delete_beneficiary_controller.dart';
import 'package:xendly_mobile/src/presentation/view_model/beneficiaries/get_beneficiaries_controller.dart';

class BeneficiariesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => http.Client());
    Get.lazyPut(() => BeneficiariesDataSourceImpl(Get.find<http.Client>()));
    Get.lazyPut(
        () => BeneficiariesRepoImpl(Get.find<BeneficiariesDataSourceImpl>()));
    Get.lazyPut(
      () => DeleteBeneficiaryUsecase(
        Get.find<BeneficiariesRepoImpl>(),
      ),
    );
    Get.put(
      () => DeleteBeneficiaryController(
        Get.find<DeleteBeneficiaryUsecase>(),
      ),
    );
    // get user's beneficiaries
    Get.lazyPut(
        () => GetBeneficiariesUsecase(Get.find<BeneficiariesRepoImpl>()));
    Get.put(
        () => GetBeneficiariesController(Get.find<GetBeneficiariesUsecase>()));
    // create bank beneficiary
    Get.lazyPut(
        () => CreateBankBeneficiaryUsecase(Get.find<BeneficiariesRepoImpl>()));
    Get.put(() => CreateBankBeneficiaryController(
        Get.find<CreateBankBeneficiaryUsecase>()));
  }
}
