import 'package:get/get.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/iconsax_icons.dart';
import 'package:xendly_mobile/src/domain/usecases/beneficiaries/create_bank_beneficiary_usecase.dart';
import 'package:xendly_mobile/src/presentation/widgets/notifications/snackbar.dart';

class CreateBankBeneficiaryController extends GetxController with StateMixin {
  final CreateBankBeneficiaryUsecase _usecase;

  CreateBankBeneficiaryController(this._usecase);

  RxString message = "".obs;
  RxBool retStatus = false.obs;
  RxList responseData = [].obs;
  var isLoading = false.obs;

  Future<void> resolveBankAccount(Map<String, dynamic> data) async {
    isLoading.value = true;
    final result = await _usecase.execute(data);
    result.fold((failure) {
      printInfo(info: failure.message.toString());
      xnSnack(
        "Error!",
        failure.message.toString(),
        XMColors.error1,
        Iconsax.info_circle,
      );
    }, (result) {
      message.value = result.message!;
      retStatus.value = result.status!;
      responseData.value = result.data!;
      print("results - ${result.data.toString()}");
    });
    isLoading.value = false;
  }
}
