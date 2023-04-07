import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/iconsax_icons.dart';
import 'package:xendly_mobile/src/domain/usecases/wallets/bank_transfer_usecase.dart';
import 'package:xendly_mobile/src/presentation/widgets/notifications/snackbar.dart';

class BankTransferController extends GetxController with StateMixin {
  final BankTransferUsecase _bankTransferUsecase;

  BankTransferController(this._bankTransferUsecase);

  RxString message = "".obs;
  RxBool retStatus = false.obs;
  RxList data = [].obs;
  var isLoading = false.obs;

  Future<void> bankTransfer(Map<String, dynamic> data) async {
    isLoading.value = true;
    final result = await _bankTransferUsecase.execute(data);
    result.fold((failure) {
      printInfo(info: failure.message.toString());
      xnSnack(
        "Error!",
        failure.message.toString(),
        XMColors.error1,
        Iconsax.info_circle,
      );
    }, (result) {
      message.value = result.message!;
      retStatus.value = result.status!;
      print("result - ${result.toString()}");
    });
    isLoading.value = false;
  }
}
