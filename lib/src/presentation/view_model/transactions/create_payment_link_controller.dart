import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/iconsax_icons.dart';
import 'package:xendly_mobile/src/domain/entities/transaction_entity.dart';
import 'package:xendly_mobile/src/domain/usecases/transactions/create_payment_link_usecase.dart';
import 'package:xendly_mobile/src/presentation/widgets/notifications/snackbar.dart';
import '../../../config/routes.dart' as routes;

abstract class CreatePaymentLinkLogic extends Equatable {
  const CreatePaymentLinkLogic();
  @override
  List<Object> get props => [];
}

class CreatePaymentLinkEvent extends CreatePaymentLinkLogic {
  final Map<String, dynamic> data;
  const CreatePaymentLinkEvent(this.data);
  @override
  List<Object> get props => [];
}

class CreatePaymentLinkEmpty extends CreatePaymentLinkLogic {}

class CreatePaymentLinkLoading extends CreatePaymentLinkLogic {}

class CreatePaymentLinkLoaded extends CreatePaymentLinkLogic {
  final TransactionEntity response;
  const CreatePaymentLinkLoaded(this.response);
  @override
  List<Object> get props => [response];
}

class CreatePaymentLinkError extends CreatePaymentLinkLogic {
  final String message;
  const CreatePaymentLinkError(this.message);
  @override
  List<Object> get props => [message];
}

class CreatePaymentLinkController extends GetxController with StateMixin {
  final CreatePaymentLinkUseCase _createPaymentLinkUsecase;

  CreatePaymentLinkController(this._createPaymentLinkUsecase);

  RxString message = "".obs;
  RxBool retStatus = false.obs;
  RxMap paymentLinkData = {}.obs;
  var isLoading = false.obs;

  Future<void> createPaymentLink(Map<String, dynamic> data) async {
    isLoading.value = true;
    final result = await _createPaymentLinkUsecase.execute(data);
    result.fold((failure) {
      printInfo(info: failure.message.toString());
      xnSnack(
        "Error Logging In!",
        failure.message.toString(),
        XMColors.error1,
        Iconsax.info_circle,
      );
    }, (result) {
      message.value = result.message!;
      retStatus.value = result.status!;
      paymentLinkData.value = result.data;
      printInfo(info: message.value.toString());
      // Get.toNamed(routes.home);
    });
    isLoading.value = false;
  }
}
