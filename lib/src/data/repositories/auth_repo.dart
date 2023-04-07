import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthRepo extends GetxService {
  // declare providers here
  final _storage = GetStorage();
  // final _secureStorage = const FlutterSecureStorage(
  //     aOptions: AndroidOptions(
  //   encryptedSharedPreferences: true,
  // ));

  // declare properties here
  final Rx<String> userToken = "".obs;

  bool get isLoggedIn =>
      userToken.value.isNotEmpty && userToken.value.length > 2;

  //   @override
  // void onInit() {
  //   super.onInit();
  // }

  // initial state
  Future<AuthRepo> init() async {
    debugPrint('$runtimeType fetching user token');
    final token = await _storage.read("userToken");
    // final token = await _secureStorage.read(key: "user_key");
    if (token != null) {
      debugPrint('Saved user token:[$token]');
      userToken.value = token;
    }
    debugPrint('$runtimeType ready!');
    return this;
  }

  void clearLastPage() {
    _storage.remove("last_page");
  }

  void logout() async {
    userToken.value = "";
    // await _storage.remove('user_data');
    // await _secureStorage.delete(key: "user_key");
  }
}
