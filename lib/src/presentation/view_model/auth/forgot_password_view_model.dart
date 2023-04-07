import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/domain/usecases/auth/forgot_password_usecase.dart';

import '../../../core/utilities/interfaces/iconsax_icons.dart';
import '../../widgets/notifications/snackbar.dart';

class ForgotPasswordViewModel extends GetxController with StateMixin {
  final ForgotPasswordUseCase _usecase;

  ForgotPasswordViewModel(this._usecase);

  final isLoading = false.obs;

  Future<void> forgotPassword(Map<String, dynamic> data) async {
    isLoading.value = true;
    final result = await _usecase.execute(data);
    result.fold((failure) {
      xnSnack(
        "Error sending code",
        failure.message,
        XMColors.error1,
        Iconsax.info_circle,
      );
    }, (result) {
      xnSnack(
        "Email sent",
        result.message,
        XMColors.success1,
        Icons.check,
      );
    });
    isLoading.value = false;
  }
}
