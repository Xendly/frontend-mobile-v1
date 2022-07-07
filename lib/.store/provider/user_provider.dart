import 'package:flutter/foundation.dart' show debugPrint;
import 'package:xendly_mobile/model/http_result.dart';
import 'package:xendly_mobile/services/http_service.dart';

class UserProvider {
  final HttpService _httpService = HttpService();

  Future<HttpResult> getUserProfile() async {
    try {
      debugPrint('Running: GET USER PROFILE');
      return HttpResult.fromMap(await _httpService.get(
        "/user",
        useAuth: true,
      ));
    } catch (e) {
      debugPrint("$e");
      rethrow;
    }
  }
}
