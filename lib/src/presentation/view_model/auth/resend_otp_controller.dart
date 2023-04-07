import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/iconsax_icons.dart';
import 'package:xendly_mobile/src/domain/entities/auth_entity.dart';
import 'package:xendly_mobile/src/domain/usecases/auth/create_pin_usecase.dart';
import 'package:xendly_mobile/src/domain/usecases/auth/resend_otp_usecase.dart';
import 'package:xendly_mobile/src/presentation/widgets/notifications/snackbar.dart';
import '../../../config/routes.dart' as routes;

abstract class ResendOtpLogic extends Equatable {
  const ResendOtpLogic();
  @override
  List<Object> get props => [];
}

class ResendOtpEvent extends ResendOtpLogic {
  final Map<String, dynamic> data;
  const ResendOtpEvent(this.data);
  @override
  List<Object> get props => [];
}

class ResendOtpEmpty extends ResendOtpLogic {}

class ResendOtpLoading extends ResendOtpLogic {}

class ResendOtpLoaded extends ResendOtpLogic {
  final AuthEntity response;
  const ResendOtpLoaded(this.response);
  @override
  List<Object> get props => [response];
}

class ResendOtpError extends ResendOtpLogic {
  final String message;
  const ResendOtpError(this.message);
  @override
  List<Object> get props => [message];
}

class ResendOtpController extends GetxController with StateMixin {
  final ResendOtpUsecase _resendOtpUsecase;

  ResendOtpController(this._resendOtpUsecase);

  RxString message = "".obs;
  RxBool retStatus = false.obs;
  var isLoading = false.obs;

  Future<void> resendOtp(String? email) async {
    isLoading.value = true;
    final result = await _resendOtpUsecase.execute(email);
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
    });
    isLoading.value = false;
  }
}
