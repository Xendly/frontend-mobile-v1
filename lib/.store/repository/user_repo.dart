import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:xendly_mobile/model/user_model.dart';

class UserRepo extends GetxService {
  final _storage = GetStorage();
  final userData = User.empty().obs;

  User get user => userData.value;

  Future<UserRepo> init() async {
    final user = _storage.read<Map<String, dynamic>>('user_data');
    if (user != null) {
      userData.value = User.fromMap(user);
      debugPrint('Saved user data:[$user]');
      // userData.refresh();
    }
    debugPrint('$runtimeType delays 1 sec');
    // await 1.delay();
    debugPrint('$runtimeType ready!');
    return this;
  }
}
