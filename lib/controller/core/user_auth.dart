import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xendly_mobile/controller/core/constants.dart';

class UserAuth {
<<<<<<< HEAD
=======
  String _parseValidationError(dynamic data) {
    if (data is List) {
      return data[0];
    } else if (data is String) {
      return data;
    } else {
      return "Invalid Request, Try Again";
    }
  }

  // === VARIABLES === //
  final baseUrl = AppConstantData.apiUrl;
  Map<String, String>? headersValues = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept': 'application/json',
  };

  // === VERIFY EMAIL === //
  Future<Map<String, dynamic>> verifyEmail(Map<String, dynamic> data) async {
    try {
      final url = '$baseUrl/api/auth/verify/email';
      final response = await http.post(
        Uri.parse(url),
        headers: headersValues,
        body: jsonEncode(
          <String, dynamic>{
            "token": data["token"],
            'email': data['email'],
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
      } else {
        // throw Exception(_parseValidationError(responseData));
        return {
          "status": "Failed",
          "statusCode": response.statusCode,
          "message": responseData["message"],
          // "message": _parseValidationError(responseData),
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

>>>>>>> 905e601 (Registration; 6 Digits Code Validation;)
  // === REGISTER A USER === //
  Future<Map<String, dynamic>> registerUser(Map<String, dynamic> data) async {
    try {
      final url = "$baseUrl/api/auth/register";
      final response = await http.post(
        Uri.parse(url),
        headers: headersValues,
        body: jsonEncode(
          <String, dynamic>{
            "first_name": data['firstName'],
            "last_name": data['lastName'],
            "email": data['email'],
            "country": data['country'],
            "phone": data['phoneNo'],
            "dob": data['dob'],
            "password": data['password'],
          },
        ),
      );

      final responseData = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          "status": "Success",
          "statusCode": response.statusCode,
          "data": responseData,
          "message": "Registration Successful",
        };
      } else if (response.statusCode == 422) {
        return <String, dynamic>{
          "status": "Failed",
          "statusCode": response.statusCode,
<<<<<<< HEAD
          "error": responseData,
          "message":
              "User Information Exists! Code ${response.statusCode} ${response.body}",
=======
          "data": responseData,
          "message": _parseValidationError(
            responseData['message'],
          ),
>>>>>>> 905e601 (Registration; 6 Digits Code Validation;)
        };
      } else {
        return <String, dynamic>{
          "status": "Failed",
          "statusCode": response.statusCode,
          "data": responseData,
          "message": "Registration Failed",
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
