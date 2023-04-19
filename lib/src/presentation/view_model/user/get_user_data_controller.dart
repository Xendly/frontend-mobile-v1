import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/iconsax_icons.dart';
import 'package:xendly_mobile/src/domain/entities/user_entity.dart';
import 'package:xendly_mobile/src/domain/usecases/user/get_user_data_usecase.dart';
import 'package:xendly_mobile/src/presentation/widgets/notifications/snackbar.dart';

abstract class GetUserDataLogic extends Equatable {
  const GetUserDataLogic();
  @override
  List<Object> get props => [];
}

class GetUserDataEvent extends GetUserDataLogic {
  const GetUserDataEvent();
  @override
  List<Object> get props => [];
}

class GetUserDataEmpty extends GetUserDataLogic {}

class GetUserDataLoading extends GetUserDataLogic {}

class GetUserDataLoaded extends GetUserDataLogic {
  final UserEntity response;
  const GetUserDataLoaded(this.response);
  @override
  List<Object> get props => [response];
}

class GetUserDataErrors extends GetUserDataLogic {
  final String message;
  const GetUserDataErrors(this.message);
  @override
  List<Object> get props => [message];
}

class GetUserDataController extends GetxController with StateMixin {
  final GetUserDataUsecase _getUserDataUseCase;

  GetUserDataController(this._getUserDataUseCase);

  RxString message = "".obs;
  RxString beneficiaryId = "".obs;
  RxString fullName = "".obs;
  RxBool retStatus = false.obs;
  RxList data = [].obs;
  var isLoading = false.obs;

  Future<void> getUserData(String username) async {
    isLoading.value = true;
    final result = await _getUserDataUseCase.execute(username);
    result.fold((failure) {
      printInfo(info: failure.message.toString());
      message.value = failure.message.toString();
      beneficiaryId.value = "";
      fullName.value = "";
      xnSnack(
        "Error!",
        failure.message.toString(),
        XMColors.error1,
        Iconsax.info_circle,
      );
    }, (result) {
      message.value = result.message!;
      retStatus.value = result.status!;
      beneficiaryId.value = result.data['id']!;
      fullName.value = result.data['full_name'];
    });
    isLoading.value = false;
  }
}
