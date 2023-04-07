import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';

import '../../../config/routes.dart' as routes;
import '../../../core/utilities/interfaces/iconsax_icons.dart';
import '../../../domain/usecases/auth/reset_password_usecase.dart';
import '../../widgets/notifications/snackbar.dart';

class ResetPasswordController extends GetxController with StateMixin {
  final ResetPasswordUsecase _usecase;

  ResetPasswordController(this._usecase);

  final isLoading = false.obs;

  Future<void> resetPassword(Map<String, dynamic> data) async {
    isLoading.value = true;
    final result = await _usecase.execute(data);
    result.fold((failure) {
      xnSnack(
        "Error resetting password",
        failure.message,
        XMColors.error1,
        Iconsax.info_circle,
      );
    }, (result) {
      xnSnack(
        "Completed",
        result.message,
        XMColors.success1,
        Icons.check,
      );
      Get.toNamed(routes.signIn);
    });
    isLoading.value = false;
  }
}
