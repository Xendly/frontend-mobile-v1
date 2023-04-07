import 'package:get/get.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/iconsax_icons.dart';
import 'package:xendly_mobile/src/domain/usecases/misc/get_acct_info_usecase.dart';
import 'package:xendly_mobile/src/presentation/widgets/notifications/snackbar.dart';

class GetAcctInfoController extends GetxController with StateMixin {
  final GetAcctInfoUsecase usecase;

  GetAcctInfoController(this.usecase);

  RxString message = "".obs;
  RxBool retStatus = false.obs;
  RxMap response = {}.obs;
  var isLoading = false.obs;

  Future<void> getAccountInfo(Map<String, dynamic> data) async {
    isLoading.value = true;
    final result = await usecase.execute(data);
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
      response.value = result.data!;
      print("results - ${result.data.toString()}");
    });
    isLoading.value = false;
  }
}
