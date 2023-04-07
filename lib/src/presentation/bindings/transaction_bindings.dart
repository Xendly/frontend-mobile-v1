import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:xendly_mobile/src/data/data_sources/transaction_data_source/data_source_impl.dart';
import 'package:xendly_mobile/src/data/repositories/transactions_repo_impl.dart';
import 'package:xendly_mobile/src/domain/usecases/transactions/create_payment_link_usecase.dart';
import 'package:xendly_mobile/src/domain/usecases/transactions/get_currency_transactions_usecase.dart';
import 'package:xendly_mobile/src/domain/usecases/transactions/get_transactions_usecase.dart';
import 'package:xendly_mobile/src/presentation/view_model/transactions/create_payment_link_controller.dart';
import 'package:xendly_mobile/src/presentation/view_model/transactions/get_currency_transactions_controller.dart';
import 'package:xendly_mobile/src/presentation/view_model/transactions/get_transactions_controller.dart';

class TransactionBindings extends Bindings {
  @override
  void dependencies() {
    // fetching the list of transactions
    Get.lazyPut(
      () => TransactionsController(
        Get.find<GetTransactionsUsecase>(),
      ),
    );
    Get.lazyPut(
      () => TransactionRepoImpl(
        Get.find<TransactionDataSourceImpl>(),
      ),
    );
    Get.lazyPut(
      () => TransactionDataSourceImpl(
        Get.find<http.Client>(),
      ),
    );
    Get.lazyPut(() => http.Client());

    // unsorted ones
    Get.lazyPut(
      () => CreatePaymentLinkUseCase(
        Get.find<TransactionRepoImpl>(),
      ),
    );
    Get.put(
      () => CreatePaymentLinkController(
        Get.find<CreatePaymentLinkUseCase>(),
      ),
    );
    // get transactions summary binding
    Get.lazyPut(
      () => GetTransactionsUsecase(
        Get.find<TransactionRepoImpl>(),
      ),
    );
    // get currency transactions summary binding
    Get.lazyPut(
      () => GetCurrencyTransactionsUsecase(
        Get.find<TransactionRepoImpl>(),
      ),
    );
    Get.put(
      () => GetCurrencyTransactionsController(
        Get.find<GetCurrencyTransactionsUsecase>(),
      ),
    );
  }
}
