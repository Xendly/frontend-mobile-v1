import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:xendly_mobile/src/core/constants/api_paths.dart';

class AuthService {
  // >>> Public <<< //
  Map<String, String>? headersValues = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept': 'application/json',
  };

  // >>> User Login <<< //
  Future<Map<String, dynamic>> loginUser(Map<String, dynamic> data) async {
    try {
      final storage = GetStorage();

      final response = await http.post(
        Uri.parse(ApiUrls.login()),
        headers: headersValues,
        body: jsonEncode(
          <String, dynamic>{
            "email": data["email"],
            'password': data['password'],
          },
        ),
      );

      final responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        return {
          "status": responseData['status'],
          "statusCode": response.statusCode,
          "data": responseData["data"],
          "message": responseData["message"],
          "token": responseData["token"],
        };
      } else {
        return {
          "status": responseData['status'],
          "statusCode": response.statusCode,
          "message": responseData["message"],
        };
      }
    } catch (error) {
      return {
        "error": error.toString(),
        "message": "Unknown Error Occurred - $error",
      };
    }
  }

  // >>> User Register <<< //
  Future<Map<String, dynamic>> registerUser(Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse(ApiUrls.register()),
        headers: headersValues,
        body: jsonEncode(
          <String, dynamic>{
            "first_name": data['firstName'],
            "last_name": data['lastName'],
            "email": data['email'],
            "country": data['country'],
            "phone": data['phoneNo'],
            "dob": data['dob'],
            "pin": data['pin'],
            "password": data['password'],
          },
        ),
      );

      final responseData = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          "status": responseData['status'],
          "statusCode": response.statusCode,
          "data": responseData["data"],
          "message": responseData["message"],
          "token": responseData["token"],
        };
      } else {
        return {
          "status": responseData['status'],
          "statusCode": response.statusCode,
          "message": responseData["message"],
        };
      }
    } catch (error) {
      return {
        "error": error.toString(),
        "message": "Unknown Error Occurred - $error",
      };
    }
  }

  // >>> Reset Password <<< //
  Future<Map<String, dynamic>> forgotPassword(Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse(ApiUrls.forgotPassword()),
        headers: headersValues,
        body: jsonEncode(
          <String, dynamic>{
            'email': data['email'],
          },
        ),
      );

      final responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        return {
          "status": responseData['status'],
          "statusCode": response.statusCode,
          "data": responseData["data"],
          "message": responseData["message"],
          "token": responseData["token"],
        };
      } else {
        return {
          "status": responseData['status'],
          "statusCode": response.statusCode,
          "message": responseData["message"],
        };
      }
    } catch (error) {
      return {
        "error": error.toString(),
        "message": "Unknown Error - $error",
      };
    }
  }

  // >>> Email Verification <<< //
  Future<Map<String, dynamic>> verifyEmail(Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse(ApiUrls.verifyEmail()),
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
          "status": responseData['status'],
          "statusCode": response.statusCode,
          "data": responseData["data"],
          "message": responseData["message"],
          "token": responseData["token"],
        };
      } else {
        return {
          "status": responseData['status'],
          "statusCode": response.statusCode,
          "message": responseData["message"],
        };
      }
    } catch (error) {
      return {
        "error": error.toString(),
        "message": "Caught error on Password Reset - $error",
      };
    }
  }

  // >>> Resend OTP <<< //
  Future<Map<String, dynamic>> resendOtp(String email) async {
    try {
      final response = await http.post(
        Uri.parse(ApiUrls.resendOtp()),
        headers: headersValues,
        body: jsonEncode(
          <String, dynamic>{
            'email': email,
          },
        ),
      );

      final responseData = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          "status": responseData['status'],
          "statusCode": response.statusCode,
          "data": responseData["data"],
          "message": responseData["message"],
          "token": responseData["token"],
        };
      } else {
        return {
          "status": responseData['status'],
          "statusCode": response.statusCode,
          "message": responseData["message"],
        };
      }
    } catch (error) {
      return {
        "error": error.toString(),
        "message": "Unknown Error - $error",
      };
    }
  }
}
