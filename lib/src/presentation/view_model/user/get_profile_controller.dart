import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/iconsax_icons.dart';
import 'package:xendly_mobile/src/domain/entities/user_entity.dart';
import 'package:xendly_mobile/src/domain/usecases/user/get_profile_usecase.dart';
import 'package:xendly_mobile/src/presentation/widgets/notifications/snackbar.dart';

abstract class GetProfile extends Equatable {
  const GetProfile();
  @override
  List<Object> get props => [];
}

class GetProfileEvent extends GetProfile {
  const GetProfileEvent();
  @override
  List<Object> get props => [];
}

class GetProfileEmpty extends GetProfile {}

class GetProfileLoading extends GetProfile {}

class GetProfileLoaded extends GetProfile {
  final UserEntity response;
  const GetProfileLoaded(this.response);
  @override
  List<Object> get props => [response];
}

class GetProfileErrors extends GetProfile {
  final String message;
  const GetProfileErrors(this.message);
  @override
  List<Object> get props => [message];
}

class GetProfileController extends GetxController with StateMixin {
  final GetProfileUsecase _usecase;

  GetProfileController(this._usecase);

  RxString message = "".obs;
  RxMap data = {}.obs;
  var isLoading = false.obs;

  Future<void> getProfile() async {
    isLoading.value = true;
    final result = await _usecase.execute();
    result.fold((failure) {
      message.value = failure.message.toString();
      xnSnack(
        "Error!",
        failure.message.toString(),
        XMColors.error1,
        Iconsax.info_circle,
      );
    }, (result) {
      message.value = result.message!;
      data.value = result.data!;
    });
    isLoading.value = false;
  }
}
