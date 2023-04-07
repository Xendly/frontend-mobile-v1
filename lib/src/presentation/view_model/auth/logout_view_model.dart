import 'package:equatable/equatable.dart';
import 'package:xendly_mobile/src/domain/entities/auth_entity.dart';
import 'package:get/get.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/iconsax_icons.dart';
import 'package:xendly_mobile/src/presentation/widgets/notifications/snackbar.dart';
import 'package:xendly_mobile/src/domain/usecases/auth/logout_usecase.dart';
import '../../../config/routes.dart' as routes;

abstract class LogoutLogic extends Equatable {
  const LogoutLogic();
  @override
  List<Object> get props => [];
}

class LogoutEvent extends LogoutLogic {
  const LogoutEvent();
  @override
  List<Object> get props => [];
}

class LogoutEmpty extends LogoutLogic {}

class LogoutLoading extends LogoutLogic {}

class LogoutLoaded extends LogoutLogic {
  final AuthEntity response;
  const LogoutLoaded(this.response);
  @override
  List<Object> get props => [response];
}

class LogoutError extends LogoutLogic {
  final String message;
  const LogoutError(this.message);
  @override
  List<Object> get props => [message];
}

class LogoutViewModel extends GetxController with StateMixin {
  final LogOutUsecase _logoutUsecase;

  LogoutViewModel(this._logoutUsecase);

  var isLoading = false.obs;

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
      Get.toNamed(routes.signIn);
    }, (result) {
      Get.toNamed(routes.signIn);
    });
    isLoading.value = false;
  }
}
