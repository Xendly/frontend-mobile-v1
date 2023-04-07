import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/iconsax_icons.dart';
import 'package:xendly_mobile/src/domain/entities/auth_entity.dart';
import 'package:xendly_mobile/src/presentation/widgets/notifications/snackbar.dart';
import '../../../config/routes.dart' as routes;
import 'package:xendly_mobile/src/domain/usecases/auth/signup_usecase.dart';

abstract class SignUpLogic extends Equatable {
  const SignUpLogic();
  @override
  List<Object> get props => [];
}

class SignUpEvent extends SignUpLogic {
  final Map<String, dynamic> data;
  const SignUpEvent(this.data);
  @override
  List<Object> get props => [];
}

class SignUpEmpty extends SignUpLogic {}

class SignUpLoading extends SignUpLogic {}

class SignUpLoaded extends SignUpLogic {
  final AuthEntity response;
  const SignUpLoaded(this.response);
  @override
  List<Object> get props => [response];
}

class SignUpError extends SignUpLogic {
  final String message;
  const SignUpError(this.message);
  @override
  List<Object> get props => [message];
}

class SignUpViewModel extends GetxController with StateMixin {
  final SignUpUseCase _signUpUseCase;

  SignUpViewModel(this._signUpUseCase);

  RxString message = "".obs;
  RxBool retStatus = false.obs;
  var isLoading = false.obs;

  Future<void> signUp(Map<String, dynamic> data) async {
    isLoading.value = true;
    final result = await _signUpUseCase.execute(data);
    result.fold((failure) {
      xnSnack(
        "Error Creating Account!",
        failure.message.toString(),
        XMColors.error1,
        Iconsax.info_circle,
      );
    }, (result) {
      message.value = result.message!;
      retStatus.value = result.status!;
      Get.toNamed(
        routes.verifyEmail,
        parameters: {
          "email": data["email"],
        },
      );
    });
    isLoading.value = false;
  }
}
