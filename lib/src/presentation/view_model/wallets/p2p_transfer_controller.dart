import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/iconsax_icons.dart';
import 'package:xendly_mobile/src/domain/usecases/wallets/p2p_transfer_usecase.dart';
import 'package:xendly_mobile/src/presentation/widgets/notifications/snackbar.dart';

import '../../../config/routes.dart' as routes;

class P2PTransferController extends GetxController with StateMixin {
  final P2PTransferUsecase _p2pTransferUseCase;

  P2PTransferController(this._p2pTransferUseCase);
  var isLoading = false.obs;

  Future<void> p2pTransfer(Map<String, dynamic> data) async {
    isLoading.value = true;
    final result = await _p2pTransferUseCase.execute(data);
    result.fold((failure) {
      printInfo(info: failure.message.toString());
      xnSnack(
        "Transfer Failed!",
        failure.message.toString(),
        XMColors.error1,
        Iconsax.info_circle,
      );
    }, (result) {
      xnSnack(
        "Transfer Successful!",
        result.message.toString(),
        XMColors.success1,
        Icons.check_circle_outline,
      );
      Get.toNamed(routes.home);
    });
    isLoading.value = false;
  }
}
