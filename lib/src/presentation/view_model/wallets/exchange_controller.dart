import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/iconsax_icons.dart';
import 'package:xendly_mobile/src/domain/usecases/wallets/exchange_usecase.dart';
import 'package:xendly_mobile/src/presentation/widgets/notifications/snackbar.dart';

import '../../../config/routes.dart' as routes;

class ExchangeController extends GetxController with StateMixin {
  final ExchangeUsecase _exchangeUseCase;

  ExchangeController(this._exchangeUseCase);
  var isLoading = false.obs;

  Future<void> exchange(Map<String, dynamic> data) async {
    isLoading.value = true;
    final result = await _exchangeUseCase.execute(data);
    result.fold((failure) {
      xnSnack(
        "Swap Failed!",
        failure.message.toString(),
        XMColors.error1,
        Iconsax.info_circle,
      );
    }, (result) {
      xnSnack(
        "Swap Successful!",
        result.message.toString(),
        XMColors.success1,
        Icons.check_circle_outline,
      );
      Get.toNamed(routes.home);
    });
    isLoading.value = false;
  }
}
