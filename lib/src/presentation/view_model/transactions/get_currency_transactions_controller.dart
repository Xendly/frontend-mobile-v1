import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/iconsax_icons.dart';
import 'package:xendly_mobile/src/domain/entities/transaction_entity.dart';
import 'package:xendly_mobile/src/domain/usecases/transactions/get_currency_transactions_usecase.dart';
import 'package:xendly_mobile/src/presentation/widgets/notifications/snackbar.dart';

abstract class GetCurrencyTransactionsLogic extends Equatable {
  const GetCurrencyTransactionsLogic();
  @override
  List<Object> get props => [];
}

class GetCurrencyTransactionsEvent extends GetCurrencyTransactionsLogic {
  final Map<String, dynamic> data;
  const GetCurrencyTransactionsEvent(this.data);
  @override
  List<Object> get props => [];
}

class GetCurrencyTransactionsEmpty extends GetCurrencyTransactionsLogic {}

class GetCurrencyTransactionsLoading extends GetCurrencyTransactionsLogic {}

class GetCurrencyTransactionsLoaded extends GetCurrencyTransactionsLogic {
  final TransactionEntity response;
  const GetCurrencyTransactionsLoaded(this.response);
  @override
  List<Object> get props => [response];
}

class GetCurrencyTransactionsError extends GetCurrencyTransactionsLogic {
  final String message;
  const GetCurrencyTransactionsError(this.message);
  @override
  List<Object> get props => [message];
}

class GetCurrencyTransactionsController extends GetxController with StateMixin {
  final GetCurrencyTransactionsUsecase _getCurrencyTransactionsUsecase;

  GetCurrencyTransactionsController(this._getCurrencyTransactionsUsecase);

  RxString message = "".obs;
  RxBool retStatus = false.obs;
  RxMap data = {}.obs;
  var isLoading = false.obs;

  Future<void> getCurrencyTransactions(String currency) async {
    isLoading.value = true;
    final result = await _getCurrencyTransactionsUsecase.execute(currency);
    result.fold((failure) {
      printInfo(info: failure.message.toString());
      xnSnack(
        "Error Loading Transactions",
        failure.message.toString(),
        XMColors.error1,
        Iconsax.info_circle,
      );
    }, (result) {
      message.value = result.message!;
      retStatus.value = result.status!;
      data.value = result.data;
    });
    isLoading.value = false;
  }
}
