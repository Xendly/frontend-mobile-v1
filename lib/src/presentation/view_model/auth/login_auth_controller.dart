import 'dart:ffi';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/iconsax_icons.dart';
import 'package:xendly_mobile/src/domain/entities/auth_entity.dart';
import 'package:xendly_mobile/src/domain/usecases/auth/login_auth_usecase.dart';
import 'package:xendly_mobile/src/domain/usecases/auth/login_usecase.dart';
import 'package:xendly_mobile/src/presentation/widgets/notifications/snackbar.dart';
import '../../../config/routes.dart' as routes;

abstract class LoginAuthLogic extends Equatable {
  const LoginAuthLogic();
  @override
  List<Object> get props => [];
}

class LoginAuthEvent extends LoginAuthLogic {
  final Map<String, dynamic> data;
  const LoginAuthEvent(this.data);
  @override
  List<Object> get props => [];
}

class LoginAuthEmpty extends LoginAuthLogic {}

class LoginAuthLoading extends LoginAuthLogic {}

class LoginAuthLoaded extends LoginAuthLogic {
  final AuthEntity response;
  const LoginAuthLoaded(this.response);
  @override
  List<Object> get props => [response];
}

class LoginAuthError extends LoginAuthLogic {
  final String message;
  const LoginAuthError(this.message);
  @override
  List<Object> get props => [message];
}

class LoginAuthController extends GetxController with StateMixin {
  final LoginAuthUseCase _loginAuthUseCase;

  LoginAuthController(this._loginAuthUseCase);

  RxString message = "".obs;
  RxBool retStatus = false.obs;
  var isLoading = false.obs;

  Future<void> loginAuth(Map<String, dynamic> data) async {
    isLoading.value = true;
    final result = await _loginAuthUseCase.execute(data);
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
      print("check for a pincode - ${result.data['has_pincode'].toString()}");
      if (result.data['has_pincode'] != false) {
        Get.toNamed(routes.home);
      } else {
        Get.toNamed(routes.createPIN);
      }
    });
    isLoading.value = false;
  }
}
