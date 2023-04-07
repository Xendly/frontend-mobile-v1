import 'package:get/get.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/iconsax_icons.dart';
import 'package:xendly_mobile/src/domain/usecases/user/bvn_verification_usecase.dart';
import 'package:xendly_mobile/src/presentation/widgets/notifications/snackbar.dart';

class BvnVerificationController extends GetxController with StateMixin {
  final BvnVerificationUsecase _usecase;

  BvnVerificationController(this._usecase);

  RxString message = "".obs;
  var isLoading = false.obs;

  Future<void> bvnVerification(Map<String, dynamic> data) async {
    isLoading.value = true;
    final result = await _usecase.execute(data);
    result.fold((failure) {
      xnSnack(
        "Error!",
        failure.message.toString(),
        XMColors.error1,
        Iconsax.info_circle,
      );
    }, (result) {
      message.value = result.message!;
      xnSnack(
        "Successful!",
        result.message.toString(),
        XMColors.success1,
        Iconsax.info_circle,
      );
    });
    isLoading.value = false;
  }
}
