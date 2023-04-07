import 'package:get/get.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/iconsax_icons.dart';
import 'package:xendly_mobile/src/presentation/widgets/notifications/snackbar.dart';

import '../../../domain/usecases/user/virtual_acct_usecase.dart';

class VirtualAcctController extends GetxController with StateMixin {
  final VirtualAcctUsecase _usecase;

  VirtualAcctController(this._usecase);

  var isLoading = false.obs;
  final data = {}.obs;

  Future<void> showVirtualAcct(Map<String, dynamic> postData) async {
    isLoading.value = true;
    final result = await _usecase.execute(postData);
    result.fold((failure) {
      xnSnack(
        "Error!",
        failure.message.toString(),
        XMColors.error1,
        Iconsax.info_circle,
      );
    }, (result) {
      data.value = result.data!;
    });
    isLoading.value = false;
  }
}
