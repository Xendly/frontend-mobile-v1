import 'package:get/get.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/iconsax_icons.dart';
import 'package:xendly_mobile/src/domain/usecases/auth/logout_usecase.dart';
import 'package:xendly_mobile/src/presentation/widgets/notifications/snackbar.dart';

import '../../../config/routes.dart' as routes;

class LogoutViewModel extends GetxController with StateMixin {
  final LogOutUsecase _logoutUsecase;

  LogoutViewModel(this._logoutUsecase);

  final isLoading = false.obs;

  Future<void> userLogout() async {
    isLoading.value = true;
    final result = await _logoutUsecase.execute();
    result.fold((failure) {
      printInfo(info: failure.message.toString());
      xnSnack(
        "Error Logging Out!",
        failure.message.toString(),
        XMColors.error1,
        Iconsax.info_circle,
      );
      // Get.toNamed(routes.signIn);
    }, (result) {
      Get.offAllNamed(routes.signIn);
    });
    isLoading.value = false;
  }
}
