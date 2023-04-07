import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/iconsax_icons.dart';
import 'package:xendly_mobile/src/domain/entities/auth_entity.dart';
import 'package:xendly_mobile/src/domain/usecases/auth/create_pin_usecase.dart';
import 'package:xendly_mobile/src/presentation/widgets/notifications/snackbar.dart';
import '../../../config/routes.dart' as routes;

abstract class CreatePinLogic extends Equatable {
  const CreatePinLogic();
  @override
  List<Object> get props => [];
}

class CreatePinEvent extends CreatePinLogic {
  final Map<String, dynamic> data;
  const CreatePinEvent(this.data);
  @override
  List<Object> get props => [];
}

class CreatePinEmpty extends CreatePinLogic {}

class CreatePinLoading extends CreatePinLogic {}

class CreatePinLoaded extends CreatePinLogic {
  final AuthEntity response;
  const CreatePinLoaded(this.response);
  @override
  List<Object> get props => [response];
}

class CreatePinError extends CreatePinLogic {
  final String message;
  const CreatePinError(this.message);
  @override
  List<Object> get props => [message];
}

class CreatePinController extends GetxController with StateMixin {
  final CreatePinUsecase _createPinUsecase;

  CreatePinController(this._createPinUsecase);

  RxString message = "".obs;
  RxBool retStatus = false.obs;
  var isLoading = false.obs;

  Future<void> createPin(Map<String, dynamic> data) async {
    isLoading.value = true;
    final result = await _createPinUsecase.execute(data);
    result.fold((failure) {
      printInfo(info: failure.message.toString());
      xnSnack(
        "Error Logging In!",
        failure.message.toString(),
        XMColors.error1,
        Iconsax.info_circle,
      );
    }, (result) {
      message.value = result.message!;
      retStatus.value = result.status!;
      print("data from create_pin - ${result.data.toString()}");
      Get.toNamed(routes.home);
    });
    isLoading.value = false;
  }
}
