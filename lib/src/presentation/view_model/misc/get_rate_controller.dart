import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/iconsax_icons.dart';
import 'package:xendly_mobile/src/domain/entities/misc_entity.dart';
import 'package:xendly_mobile/src/domain/usecases/misc/get_rate_usecase.dart';
import 'package:xendly_mobile/src/presentation/widgets/notifications/snackbar.dart';

abstract class RateLogic extends Equatable {
  const RateLogic();
  @override
  List<Object> get props => [];
}

class RateEvent extends RateLogic {
  const RateEvent();
  @override
  List<Object> get props => [];
}

class RateEmpty extends RateLogic {}

class RateLoading extends RateLogic {}

class RateLoaded extends RateLogic {
  final MiscEntity response;
  const RateLoaded(this.response);
  @override
  List<Object> get props => [response];
}

class RateError extends RateLogic {
  final String message;
  const RateError(this.message);
  @override
  List<Object> get props => [message];
}

class RateController extends GetxController with StateMixin {
  final RateUsecase _rateUsecase;

  RateController(this._rateUsecase);

  RxString message = "".obs;
  RxBool retStatus = false.obs;
  RxMap data = {}.obs;
  var isLoading = false.obs;

  Future<void> getRate(String from, String to) async {
    isLoading.value = true;
    final result = await _rateUsecase.execute(from, to);
    result.fold((failure) {
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
    });
    isLoading.value = false;
  }
}
