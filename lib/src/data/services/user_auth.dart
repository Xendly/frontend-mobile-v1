import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:xendly_mobile/src/data/models/user_model_old.dart';
import 'package:xendly_mobile/src/data/services/constants.dart';
import 'package:xendly_mobile/src/data/services/token_storage.dart';

class UserAuth {
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
  final baseUrl = AppConstantData.baseUrl;
  Map<String, String>? headersValues = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept': 'application/json',
  };

  // === Sign Up New User === //
  Future<Map<String, dynamic>> registerUser(Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse(ApiUrls.userSignUp()),
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
          "status": "Success",
          "statusCode": response.statusCode,
          "data": responseData,
          "message": "Registration Successful",
        };
      } else if (response.statusCode == 422) {
        return <String, dynamic>{
          "status": "Failed",
          "statusCode": response.statusCode,
          "data": responseData,
          "message": _parseValidationError(
            responseData['message'],
          ),
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

  // === VERIFY EMAIL === //
  // Future<Map<String, dynamic>> verifyEmail(Map<String, dynamic> data) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse(ApiUrls.emailVerification()),
  //       headers: headersValues,
  //       body: jsonEncode(
  //         <String, dynamic>{
  //           "token": data["token"],
  //           'email': data['email'],
  //         },
  //       ),
  //     );

  //     final responseData = json.decode(response.body);
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       return {
  //         "status": "Success",
  //         "statusCode": response.statusCode,
  //         "message": responseData["message"],
  //       };
  //     } else {
  //       // throw Exception(_parseValidationError(responseData));
  //       return {
  //         "status": "Failed",
  //         "statusCode": response.statusCode,
  //         "message": responseData["message"],
  //         // "message": _parseValidationError(responseData),
  //       };
  //     }
  //   } catch (error) {
  //     return {
  //       "status": "Failed",
  //       'error': error.toString(),
  //       "message": "Unknown Error Occurred - $error",
  //     };
  //   }
  // }

  // === VERIFY EMAIL === //
  // Future<Map<String, dynamic>> resendOTP(String email) async {
  //   try {
  //     final url = '$baseUrl/api/auth/verify/resend';
  //     final response = await http.post(
  //       Uri.parse(url),
  //       headers: headersValues,
  //       body: jsonEncode(
  //         <String, dynamic>{
  //           'email': email,
  //         },
  //       ),
  //     );

  //     final responseData = json.decode(response.body);
  //     if ([200, 201].contains(response.statusCode)) {
  //       return {
  //         "status": "Success",
  //         "statusCode": response.statusCode,
  //         "message": responseData["message"],
  //       };
  //     } else if (response.statusCode == 422) {
  //       return <String, dynamic>{
  //         "status": "Failed",
  //         "statusCode": response.statusCode,
  //         "data": responseData,
  //         "message": _parseValidationError(
  //           responseData['message'],
  //         ),
  //       };
  //     } else {
  //       // throw Exception(_parseValidationError(responseData));
  //       return {
  //         "status": "Failed",
  //         "statusCode": response.statusCode,
  //         "message": responseData["message"],
  //         // "message": _parseValidationError(responseData),
  //       };
  //     }
  //   } catch (error) {
  //     return {
  //       "status": "Failed",
  //       'error': error.toString(),
  //       "message": "Unknown Error Occurred - $error",
  //     };
  //   }
  // }

  // === CREATE TRANSACTION PIN === //
  Future<Map<String, dynamic>> createTransactionPin(
      Map<String, dynamic> data) async {
    try {
      final token = TokenStorage().readToken();
      final url = '$baseUrl/api/users/pin/create';
      http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': "Bearer $token",
        },
        body: jsonEncode(
          <String, dynamic>{
            "pin": data["pin"],
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
          "message": _parseValidationError(
            responseData['message'],
          ),
        };
      } else {
        // throw Exception(_parseValidationError(responseData));
        return {
          "status": "Failed",
          "statusCode": response.statusCode,
          "data": responseData,
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

  // === FORGOT PASSWORD === //
  Future<Map<String, dynamic>> forgotPassword(Map<String, dynamic> data) async {
    try {
      final url =
          'https://web-production-efab.up.railway.app/api/auth/password/forgot';
      final response = await http.post(
        Uri.parse(url),
        headers: headersValues,
        body: jsonEncode(
          <String, dynamic>{
            "email": data["email"],
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
          "message": _parseValidationError(
            responseData['message'],
          ),
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
        'error': error,
        "message": "Unknown Error Occurred - $error",
      };
    }
  }

  // === RESET PASSWORD === //
  // Future<Map<String, dynamic>> resetPassword(Map<String, dynamic> data) async {
  //   try {
  //     final url = '$baseUrl/api/auth/password/reset';
  //     final response = await http.post(
  //       Uri.parse(url),
  //       headers: headersValues,
  //       body: jsonEncode(
  //         <String, dynamic>{
  //           "email": data["email"],
  //           "token": data["token"],
  //           "password": data["password"],
  //         },
  //       ),
  //     );

  //     final responseData = json.decode(response.body);
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       return {
  //         "status": "Success",
  //         "statusCode": response.statusCode,
  //         "message": responseData["message"],
  //       };
  //     } else if (response.statusCode == 422) {
  //       return <String, dynamic>{
  //         "status": "Failed",
  //         "statusCode": response.statusCode,
  //         "data": responseData,
  //         "message": _parseValidationError(
  //           responseData['message'],
  //         ),
  //       };
  //     } else {
  //       // throw Exception(_parseValidationError(responseData));
  //       return {
  //         "status": "Failed",
  //         "statusCode": response.statusCode,
  //         "message": responseData["message"],
  //         // "message": _parseValidationError(responseData),
  //       };
  //     }
  //   } catch (error) {
  //     return {
  //       "status": "Failed",
  //       'error': error,
  //       "message": "Unknown Error Occurred - $error",
  //     };
  //   }
  // }

  // === UPDATE PIN === //
  Future<Map<String, dynamic>> updatePIN(Map<String, dynamic> data) async {
    final token = TokenStorage().readToken();

    print("Token from TokenStorage GxS => $token");

    try {
      final url = '$baseUrl/api/users/pin/update';
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': "Bearer $token",
        },
        body: jsonEncode(
          <String, dynamic>{
            "old_pin": data["old_pin"],
            "pin": data["pin"],
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
        'error': error,
        "message": "Unknown Error Occurred - $error",
      };
    }
  }

  // === RESET PIN === //
  Future<Map<String, dynamic>> resetPin(Map<String, dynamic> data) async {
    final token = TokenStorage().readToken();

    print("Token from TokenStorage GxS => $token");

    try {
      final url = '$baseUrl/api/users/pin/reset';
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': "Bearer $token",
        },
        body: jsonEncode(
          <String, dynamic>{
            "password": data["password"],
            "pin": data["pin"],
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
        'error': error,
        "message": "Unknown Error Occurred - $error",
      };
    }
  }

  Future<Map<String, dynamic>> updateProfile(Map<String, dynamic> data) async {
    final token = TokenStorage().readToken();
    print("Token from TokenStorage GxS => $token");

    try {
      final url = '$baseUrl/api/users/update/profile';
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': "Bearer $token",
        },
        body: jsonEncode(
          <String, dynamic>{
            "type": data["type"],
            "value": data["value"],
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
        'error': error,
        "message": "Unknown Error Occurred - $error",
      };
    }
  }

  // === GET USER DATA === //
  Future<UserProfile> getProfile() async {
    final token = TokenStorage().readToken();

    http.Response response = await http.get(
      Uri.parse(
        "https://xendly-api.herokuapp.com/api/users/profile",
      ),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body)['data'];
      return UserProfile.fromJson(responseData);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
