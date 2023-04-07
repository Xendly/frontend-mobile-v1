import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class TokenStorage extends GetxService {
  final storage = GetStorage();

  void storeToken(dynamic value) async {
    await storage.write("userToken", value);
  }

  String readToken() {
    return storage.read("userToken");
  }
}
