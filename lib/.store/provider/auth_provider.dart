import 'package:flutter/cupertino.dart';
import 'package:xendly_mobile/model/http_result.dart';
import 'package:xendly_mobile/services/http_service.dart';

class AuthProvider {
  final HttpService _httpService = HttpService();

  // ===  REGISTER A USER === //
  Future<HttpResult> signUpUser(Map<String, dynamic> userData) async {
    try {
      return HttpResult.fromMap(
        await _httpService.send(
          "/api/auth/register",
          HttpType.post,
          body: {
            "firstName": userData['firstName'],
            "lastName": userData['lastName'],
            "email": userData['email'],
            "country": userData["country"],
            "phoneNo": userData["phoneNo"],
            "dateOfBirth": userData["dateOfBirth"],
            "password": userData['password'],
          },
        ),
      );
    } catch (e) {
      debugPrint("$e");
      rethrow;
    }
  }
}
