import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:xendly_mobile/src/data/repositories/auth_repo.dart';

Future<void> setupServiceLocator() async {
  await GetStorage.init();
  await Get.putAsync<AuthRepo>(() => AuthRepo().init());
  debugPrint('All services started...');
}
