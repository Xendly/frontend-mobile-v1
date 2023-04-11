import 'package:get/get.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/iconsax_icons.dart';
import 'package:xendly_mobile/src/domain/usecases/user/get_profile_usecase.dart';
import 'package:xendly_mobile/src/presentation/widgets/notifications/snackbar.dart';

class GetProfileController extends GetxController with StateMixin {
  final GetProfileUsecase _usecase;
  GetProfileController(this._usecase);

  final isLoading = false.obs;
  final data = {}.obs;

  Future<void> getProfile() async {
    try {
      isLoading.value = true;
      final result = await _usecase.execute();
      result.fold(
        (failure) {
          xnSnack(
            "Error!",
            failure.message.toString(),
            XMColors.error1,
            Iconsax.info_circle,
          );
        },
        (result) {
          data.value = result.data!;
          // notify changes
          update();
        },
      );
    } catch (error) {
      print(error);
    } finally {
      isLoading.value = false;
    }
  }
}
