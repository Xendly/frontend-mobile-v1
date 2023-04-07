import 'package:get/get.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/iconsax_icons.dart';
import 'package:xendly_mobile/src/domain/usecases/misc/get_banks_list_usecase.dart';
import 'package:xendly_mobile/src/presentation/widgets/notifications/snackbar.dart';

class GetBanksListController extends GetxController with StateMixin {
  final GetBanksListUsecase usecase;

  GetBanksListController(this.usecase);

  RxString message = "".obs;
  RxBool retStatus = false.obs;
  RxList data = [].obs;
  var isLoading = false.obs;

  Future<void> getBanksList() async {
    isLoading.value = true;
    final result = await usecase.execute();
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
      data.value = result.data!;
      print("results - ${result.data.toString()}");
    });
    isLoading.value = false;
  }
}
