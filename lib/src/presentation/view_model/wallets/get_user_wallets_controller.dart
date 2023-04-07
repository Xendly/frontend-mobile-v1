import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/iconsax_icons.dart';
import 'package:xendly_mobile/src/domain/entities/wallet_entity.dart';
import 'package:xendly_mobile/src/domain/usecases/wallets/get_user_wallets_usecase.dart';
import 'package:xendly_mobile/src/presentation/widgets/notifications/snackbar.dart';

abstract class GetUserWalletsLogic extends Equatable {
  const GetUserWalletsLogic();

  @override
  List<Object> get props => [];
}

class GetUserWalletsEvent extends GetUserWalletsLogic {
  const GetUserWalletsEvent();

  @override
  List<Object> get props => [];
}

class GetUserWalletsEmpty extends GetUserWalletsLogic {}

class GetUserWalletsLoading extends GetUserWalletsLogic {}

class GetUserWalletsLoaded extends GetUserWalletsLogic {
  final WalletEntity response;

  const GetUserWalletsLoaded(this.response);

  @override
  List<Object> get props => [response];
}

class GetUserWalletsErrors extends GetUserWalletsLogic {
  final String message;

  const GetUserWalletsErrors(this.message);

  @override
  List<Object> get props => [message];
}

class GetUserWalletsController extends GetxController with StateMixin {
  final GetUserWalletsUseCase _getUserWalletsUseCase;

  GetUserWalletsController(this._getUserWalletsUseCase);

  RxString message = "".obs;
  RxBool retStatus = false.obs;
  RxList data = [].obs;
  var isLoading = false.obs;

  Future<void> getUserWallets() async {
    isLoading.value = true;
    final result = await _getUserWalletsUseCase.execute();
    result.fold((failure) {
      isLoading.value = false;
      xnSnack(
        "Error retrieving wallets",
        failure.message.toString(),
        XMColors.error1,
        Iconsax.info_circle,
      );
    }, (result) {
      isLoading.value = false;
      message.value = result.message!;
      retStatus.value = result.status!;
      data.value = result.data!;
    });
  }
}
