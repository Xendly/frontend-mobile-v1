import 'dart:convert';

import 'package:xendly_mobile/controller/core/constants.dart';
import 'package:xendly_mobile/controller/core/token_storage.dart';
import 'package:http/http.dart' as http;

class AccountsService {
  // === VARIABLES === //
  final baseUrl = AppConstantData.apiUrl;

  Future<Map<String, dynamic>> createVirtualAccount(
      Map<String, dynamic> data) async {
    final token = TokenStorage().readToken();
    print("Token from TokenStorage GxS => $token");

    try {
      http.Response response = await http.post(
        Uri.parse('$baseUrl/api/users/virtual-account'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': "Bearer $token",
        },
        body: jsonEncode(
          <String, dynamic>{
            "bvn": data["bvn"],
          },
        ),
      );

      final responseData = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          "status": "success",
          "statusCode": response.statusCode,
          "message": responseData["message"],
        };
      } else {
        return {
          "status": "failed",
          "statusCode": response.statusCode,
          "data": responseData,
          "message": responseData["message"],
        };
      }
    } catch (error) {
      return {
        "status": "Failed",
        'error': error.toString(),
        "message": "Unknown Error Occurred - $error",
      };
    }
  }
}
