import 'package:get/get.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/iconsax_icons.dart';
import 'package:xendly_mobile/src/presentation/widgets/notifications/snackbar.dart';

import '../../../domain/usecases/user/update_username_usecase.dart';

class UpdateUsernameController extends GetxController with StateMixin {
  final UpdateUsernameUsecase _usecase;

  UpdateUsernameController(this._usecase);

  var isLoading = false.obs;

  Future<void> updateUsername(String? username) async {
    isLoading.value = true;
    final result = await _usecase.execute(username);
    result.fold((failure) {
      xnSnack(
        "Error!",
        failure.message.toString(),
        XMColors.error1,
        Iconsax.info_circle,
      );
    }, (result) {
      xnSnack(
        "Profile Updated",
        result.message.toString(),
        XMColors.success1,
        Iconsax.info_circle,
      );
    });
    isLoading.value = false;
  }
}
