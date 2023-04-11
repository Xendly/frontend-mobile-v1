import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/iconsax_icons.dart';
import 'package:xendly_mobile/src/domain/usecases/beneficiaries/delete_beneficiary.dart';
import 'package:xendly_mobile/src/presentation/widgets/notifications/snackbar.dart';

class DeleteBeneficiaryController extends GetxController with StateMixin {
  final DeleteBeneficiaryUsecase _usecase;

  DeleteBeneficiaryController(this._usecase);

  var isLoading = false.obs;

  Future<void> deleteBeneficiary(int id) async {
    isLoading.value = true;
    final result = await _usecase.execute(id);
    result.fold((failure) {
      xnSnack(
        "Failed!",
        failure.message.toString(),
        XMColors.error1,
        Iconsax.info_circle,
      );
    }, (result) {
      xnSnack(
        "Successful!",
        result.message.toString(),
        XMColors.success1,
        Icons.check_circle_outline,
      );
    });
    isLoading.value = false;
  }
}
