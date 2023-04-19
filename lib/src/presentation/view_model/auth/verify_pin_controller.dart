import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/iconsax_icons.dart';
import 'package:xendly_mobile/src/domain/entities/auth_entity.dart';
import 'package:xendly_mobile/src/domain/usecases/auth/verify_pin_usecase.dart';
import 'package:xendly_mobile/src/presentation/widgets/notifications/snackbar.dart';

abstract class VerifyPinLogic extends Equatable {
  const VerifyPinLogic();
  @override
  List<Object> get props => [];
}

class VerifyPinEvent extends VerifyPinLogic {
  final Map<String, dynamic> data;
  const VerifyPinEvent(this.data);
  @override
  List<Object> get props => [];
}

class VerifyPinEmpty extends VerifyPinLogic {}

class VerifyPinLoading extends VerifyPinLogic {}

class VerifyPinLoaded extends VerifyPinLogic {
  final AuthEntity response;
  const VerifyPinLoaded(this.response);
  @override
  List<Object> get props => [response];
}

class VerifyPinError extends VerifyPinLogic {
  final String message;
  const VerifyPinError(this.message);
  @override
  List<Object> get props => [message];
}

class VerifyPinController extends GetxController with StateMixin {
  final VerifyPinUseCase _verifyPinUsecase;

  VerifyPinController(this._verifyPinUsecase);

  RxString message = "".obs;
  RxBool retStatus = false.obs;
  var isLoading = false.obs;

  Future<void> verifyPin(Map<String, dynamic> data) async {
    isLoading.value = true;
    final result = await _verifyPinUsecase.execute(data);
    result.fold((failure) {
      message.value = failure.message;
      xnSnack(
        "Error Logging In!",
        failure.message.toString(),
        XMColors.error1,
        Iconsax.info_circle,
      );
    }, (result) {
      message.value = result.message!;
      retStatus.value = result.status;
      print("pin res - ${result.status.toString()}");
    });
    isLoading.value = false;
  }
}
