import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:xendly_mobile/controller/core/cache_manager.dart';
import 'package:xendly_mobile/controller/core/cache_manager.dart';
import 'package:xendly_mobile/controller/core/constants.dart';
import 'package:xendly_mobile/controller/core/token_storage.dart';
import 'package:xendly_mobile/model/user_model.dart';

class BeneficiaryAuth {
  Future<Map<String, dynamic>> addBeneficiary(Map<String, dynamic> data) async {
    try {
      final token = TokenStorage().readToken();
      print("Add Beneficiary >>> TokenStorage => $token");
      const url = "https://xendly-api.herokuapp.com/api/beneficiaries";
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': "Bearer $token",
        },
        body: jsonEncode(
          <String, dynamic>{
            "name": data['name'],
            "phone": data['phoneNo'],
          },
        ),
      );

      final responseData = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          "status": "Success",
          "statusCode": response.statusCode,
          "message": responseData["message"],
        };
      } else if (response.statusCode == 422) {
        return <String, dynamic>{
          "status": "Failed",
          "statusCode": response.statusCode,
          "data": responseData,
          // "message": _parseValidationError(
          //   responseData['message'],
          // ),
          "message": responseData,
        };
      } else {
        // throw Exception(_parseValidationError(responseData));
        return {
          "status": "Failed",
          "statusCode": response.statusCode,
          "message": response.body,
          // "message": responseData["message"],
          // "message": _parseValidationError(responseData),
        };
      }
    } catch (error) {
      return {
        "status": "Failed",
        'data': error.toString(),
        "message": "An Unknown Error Occurred - $error",
      };
    }
  }
}
