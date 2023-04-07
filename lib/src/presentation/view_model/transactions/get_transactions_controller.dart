import 'package:get/get.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/iconsax_icons.dart';
import 'package:xendly_mobile/src/domain/usecases/transactions/get_transactions_usecase.dart';
import 'package:xendly_mobile/src/presentation/widgets/notifications/snackbar.dart';

class TransactionsController extends GetxController {
  final GetTransactionsUsecase _getTransactionsUsecase;
  TransactionsController(this._getTransactionsUsecase);

  final isLoading = false.obs;
  final data = {}.obs;

  Future<void> fetchTransactions() async {
    try {
      isLoading.value = true;
      final result = await _getTransactionsUsecase.execute();
      result.fold(
        (failure) {
          xnSnack(
            "Error Loading Transactions",
            failure.message.toString(),
            XMColors.error1,
            Iconsax.info_circle,
          );
        },
        (result) {
          data.value = result.data;
          // notify changes
          update();
        },
      );
    } catch (error) {
      print("error fetching data: $error");
    } finally {
      isLoading.value = false;
    }
  }
}
