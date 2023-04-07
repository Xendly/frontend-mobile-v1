import 'package:get/get.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/iconsax_icons.dart';
import 'package:xendly_mobile/src/domain/usecases/beneficiaries/get_beneficiaries_usecase.dart';
import 'package:xendly_mobile/src/presentation/widgets/notifications/snackbar.dart';

class GetBeneficiariesController extends GetxController with StateMixin {
  final GetBeneficiariesUsecase _usecase;

  GetBeneficiariesController(this._usecase);

  RxString message = "".obs;
  RxBool retStatus = false.obs;
  RxList data = [].obs;
  var isLoading = false.obs;

  Future<void> getBeneficiaries() async {
    isLoading.value = true;
    final result = await _usecase.execute();
    result.fold((failure) {
      xnSnack(
        "Error!",
        failure.message.toString(),
        XMColors.error1,
        Iconsax.info_circle,
      );
    }, (result) {
      message.value = result.message!;
      retStatus.value = result.status!;
      data.value = result.data!;
    });
    isLoading.value = false;
  }
}
