import 'package:get/get.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/iconsax_icons.dart';
import 'package:xendly_mobile/src/domain/usecases/auth/login_usecase.dart';
import 'package:xendly_mobile/src/presentation/widgets/notifications/snackbar.dart';

import '../../../config/routes.dart' as routes;

class LoginViewModel extends GetxController with StateMixin {
  final LoginUseCase _loginUseCase;

  LoginViewModel(this._loginUseCase);

  RxString message = "".obs;
  RxBool retStatus = false.obs;
  var isLoading = false.obs;

  Future<void> userLogin(Map<String, dynamic> data) async {
    isLoading.value = true;
    final result = await _loginUseCase.execute(data);
    result.fold((failure) {
      printInfo(info: failure.message.toString());
      xnSnack(
        "Error Logging In!",
        failure.message.toString(),
        XMColors.error1,
        Iconsax.info_circle,
      );
      if (failure.message == "Please verify your email") {
        Get.offAndToNamed(routes.verifyEmail, parameters: {
          "email": data["email"],
        });
      }
    }, (result) {
      message.value = result.message!;
      retStatus.value = result.status;
      if (result.verifyOtpStatus == true) {
        Get.toNamed(routes.loginOtp, parameters: {
          "email": data["email"],
        });
      } else {
        Get.toNamed(routes.createPIN);
      }
    });
    isLoading.value = false;
  }
}
