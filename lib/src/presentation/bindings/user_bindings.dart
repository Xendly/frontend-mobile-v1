import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:xendly_mobile/src/domain/usecases/user/update_phone_usecase.dart';
import 'package:xendly_mobile/src/domain/usecases/user/update_username_usecase.dart';
import 'package:xendly_mobile/src/domain/usecases/user/virtual_acct_usecase.dart';
import 'package:xendly_mobile/src/presentation/view_model/user/update_phone_controller.dart';

import '../../data/data_sources/user_data_source/data_source_impl.dart';
import '../../data/repositories/user_repo_impl.dart';
import '../../domain/usecases/user/bvn_verification_usecase.dart';
import '../../domain/usecases/user/get_profile_usecase.dart';
import '../../domain/usecases/user/get_user_data_usecase.dart';
import '../../domain/usecases/user/update_address_usecase.dart';
import '../../domain/usecases/user/update_pin_usecase.dart';
import '../view_model/user/bvn_verification_controller.dart';
import '../view_model/user/get_profile_controller.dart';
import '../view_model/user/get_user_data_controller.dart';
import '../view_model/user/update_address_controller.dart';
import '../view_model/user/update_pin_controller.dart';
import '../view_model/user/update_username_controller.dart';
import '../view_model/user/virtual_acct_controller.dart';

class UserBindings extends Bindings {
  @override
  void dependencies() {
    // controllers
    Get.lazyPut(
      () => GetProfileController(
        Get.find<GetProfileUsecase>(),
      ),
    );
    Get.put(
      () => GetUserDataController(
        Get.find<GetUserDataUsecase>(),
      ),
    );
    Get.put(
      () => UpdateAddressController(
        Get.find<UpdateAddressUsecase>(),
      ),
    );
    Get.put(
      () => UpdatePinController(
        Get.find<UpdatePinUsecase>(),
      ),
    );
    Get.put(
      () => BvnVerificationController(
        Get.find<BvnVerificationUsecase>(),
      ),
    );
    Get.put(
      () => VirtualAcctController(
        Get.find<VirtualAcctUsecase>(),
      ),
    );
    Get.put(
      () => UpdatePhoneController(
        Get.find<UpdatePhoneUsecase>(),
      ),
    );
    Get.put(
      () => UpdateUsernameController(
        Get.find<UpdateUsernameUsecase>(),
      ),
    );

    // usecases
    Get.lazyPut(
      () => GetUserDataUsecase(
        Get.find<UserRepoImpl>(),
      ),
    );
    Get.lazyPut(
      () => GetProfileUsecase(
        Get.find<UserRepoImpl>(),
      ),
    );
    Get.lazyPut(
      () => UpdatePinUsecase(
        Get.find<UserRepoImpl>(),
      ),
    );
    Get.lazyPut(
      () => UpdateAddressUsecase(
        Get.find<UserRepoImpl>(),
      ),
    );
    Get.lazyPut(
      () => BvnVerificationUsecase(
        Get.find<UserRepoImpl>(),
      ),
    );
    Get.lazyPut(
      () => VirtualAcctUsecase(
        Get.find<UserRepoImpl>(),
      ),
    );
    Get.lazyPut(
      () => UpdatePhoneUsecase(
        Get.find<UserRepoImpl>(),
      ),
    );
    Get.lazyPut(
      () => UpdateUsernameUsecase(
        Get.find<UserRepoImpl>(),
      ),
    );
    // others
    Get.put(
      http.Client(),
    );
    Get.put(
      UserDataSourceImpl(
        Get.find<http.Client>(),
      ),
    );
    Get.put(
      UserRepoImpl(
        Get.find<UserDataSourceImpl>(),
      ),
    );
  }
}
