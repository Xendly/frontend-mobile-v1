import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:xendly_mobile/src/data/data_sources/auth_data_sources/data_source_impl.dart';
import 'package:xendly_mobile/src/data/repositories/auth_repo_impl.dart';
import 'package:xendly_mobile/src/domain/usecases/auth/create_pin_usecase.dart';
import 'package:xendly_mobile/src/domain/usecases/auth/forgot_password_usecase.dart';
import 'package:xendly_mobile/src/domain/usecases/auth/login_auth_usecase.dart';
import 'package:xendly_mobile/src/domain/usecases/auth/login_usecase.dart';
import 'package:xendly_mobile/src/domain/usecases/auth/logout_usecase.dart';
import 'package:xendly_mobile/src/domain/usecases/auth/resend_otp_usecase.dart';
import 'package:xendly_mobile/src/domain/usecases/auth/reset_password_usecase.dart';
import 'package:xendly_mobile/src/domain/usecases/auth/signup_usecase.dart';
import 'package:xendly_mobile/src/domain/usecases/auth/verify_email_usecase.dart';
import 'package:xendly_mobile/src/domain/usecases/auth/verify_pin_usecase.dart';
import 'package:xendly_mobile/src/presentation/view_model/auth/create_pin_controller.dart';
import 'package:xendly_mobile/src/presentation/view_model/auth/forgot_password_view_model.dart';
import 'package:xendly_mobile/src/presentation/view_model/auth/login_auth_controller.dart';
import 'package:xendly_mobile/src/presentation/view_model/auth/login_view_model.dart';
import 'package:xendly_mobile/src/presentation/view_model/auth/logout_view_model.dart';
import 'package:xendly_mobile/src/presentation/view_model/auth/resend_otp_controller.dart';
import 'package:xendly_mobile/src/presentation/view_model/auth/reset_password_controller.dart';
import 'package:xendly_mobile/src/presentation/view_model/auth/signup_view_model.dart';
import 'package:xendly_mobile/src/presentation/view_model/auth/verify_email_controller.dart';
import 'package:xendly_mobile/src/presentation/view_model/auth/verify_pin_controller.dart';

class AuthBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(http.Client());
    Get.put(AuthDataSourceImpl(Get.find<http.Client>()));
    Get.put(AuthRepositoryImpl(Get.find<AuthDataSourceImpl>()));
    // >>> Login Binding <<< //
    Get.lazyPut(() => LoginUseCase(Get.find<AuthRepositoryImpl>()));
    Get.put(() => LoginViewModel(Get.find<LoginUseCase>()));
    // >>> Sign Up Binding <<< //
    Get.lazyPut(() => SignUpUseCase(Get.find<AuthRepositoryImpl>()));
    Get.put(() => SignUpViewModel(Get.find<SignUpUseCase>()));
    // >>> Forgot Password Binding <<< //
    Get.lazyPut(() => ForgotPasswordUseCase(Get.find<AuthRepositoryImpl>()));
    Get.put(() => ForgotPasswordViewModel(Get.find<ForgotPasswordUseCase>()));
    // reset password binding
    Get.lazyPut(() => ResetPasswordUsecase(Get.find<AuthRepositoryImpl>()));
    Get.put(() => ResetPasswordController(Get.find<ResetPasswordUsecase>()));
    // >>> Verify Email Binding <<< //
    Get.lazyPut(() => VerifyEmailUseCase(Get.find<AuthRepositoryImpl>()));
    Get.put(() => VerifyEmailController(Get.find<VerifyEmailUseCase>()));
    // >>> Login Auth Binding <<< //
    Get.lazyPut(() => LoginAuthUseCase(Get.find<AuthRepositoryImpl>()));
    Get.put(() => LoginAuthController(Get.find<LoginAuthUseCase>()));
    // >>> Create Pin Binding <<< //
    Get.lazyPut(() => CreatePinUsecase(Get.find<AuthRepositoryImpl>()));
    Get.put(() => CreatePinController(Get.find<CreatePinUsecase>()));
    // >>> Verify Pin Binding <<< //
    Get.lazyPut(() => VerifyPinUseCase(Get.find<AuthRepositoryImpl>()));
    Get.put(() => VerifyPinController(Get.find<VerifyPinUseCase>()));
    // >>> resend otp binding <<< //
    Get.lazyPut(() => ResendOtpUsecase(Get.find<AuthRepositoryImpl>()));
    Get.put(() => ResendOtpController(Get.find<ResendOtpUsecase>()));
    // >>> logout binding <<< //
    Get.lazyPut(() => LogOutUsecase(Get.find<AuthRepositoryImpl>()));
    Get.lazyPut(() => LogoutViewModel(Get.find<LogOutUsecase>()));
  }
}
