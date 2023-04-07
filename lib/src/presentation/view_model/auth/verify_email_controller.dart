import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/iconsax_icons.dart';
import 'package:xendly_mobile/src/domain/entities/auth_entity.dart';
import 'package:xendly_mobile/src/domain/usecases/auth/verify_email_usecase.dart';
import 'package:xendly_mobile/src/presentation/widgets/notifications/snackbar.dart';

import '../../../config/routes.dart' as routes;

abstract class VerifyEmailLogic extends Equatable {
  const VerifyEmailLogic();
  @override
  List<Object> get props => [];
}

class VerifyEmailEvent extends VerifyEmailLogic {
  final Map<String, dynamic> data;
  const VerifyEmailEvent(this.data);
  @override
  List<Object> get props => [];
}

class VerifyEmailEmpty extends VerifyEmailLogic {}

class VerifyEmailLoading extends VerifyEmailLogic {}

class VerifyEmailLoaded extends VerifyEmailLogic {
  final AuthEntity response;
  const VerifyEmailLoaded(this.response);
  @override
  List<Object> get props => [response];
}

class VerifyEmailError extends VerifyEmailLogic {
  final String message;
  const VerifyEmailError(this.message);
  @override
  List<Object> get props => [message];
}

class VerifyEmailController extends GetxController with StateMixin {
  final VerifyEmailUseCase _verifyEmailUseCase;

  VerifyEmailController(this._verifyEmailUseCase);

  RxString message = "".obs;
  RxBool retStatus = false.obs;
  var isLoading = false.obs;

  Future<void> verifyEmail(Map<String, dynamic> data) async {
    isLoading.value = true;
    final result = await _verifyEmailUseCase.execute(data);
    result.fold((failure) {
      xnSnack(
        "Verification Failed!",
        failure.message.toString(),
        XMColors.error1,
        Iconsax.info_circle,
      );
    }, (result) {
      message.value = result.message!;
      retStatus.value = result.status!;
      // if (result.data["has_pincode"] != true) {
      //   Get.toNamed(routes.createPIN);
      // }
      // else {
      Get.toNamed(routes.signIn);
      // }
    });
    isLoading.value = false;
  }
}
