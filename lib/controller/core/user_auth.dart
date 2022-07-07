import 'dart:convert';
import 'package:http/http.dart' as http;

class UserAuth {
  // === REGISTER A USER === //
  Future<Map<String, dynamic>> registerUser(Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse("https://xendly-api.herokuapp.com/api/auth/register"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
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
          "message": "Registration Successful! Code ${response.statusCode}",
        };
      } else if (response.statusCode == 422) {
        return <String, dynamic>{
          "status": "Failed",
          "statusCode": response.statusCode,
          "error": responseData,
          "message":
              "User Information Exists! Code ${response.statusCode} ${response.body}",
        };
      } else {
        return <String, dynamic>{
          "status": "Failed",
          "statusCode": response.statusCode,
          "error": responseData,
          "message":
              "Registration Failed! Code ${response.statusCode} ${response.body}",
        };
      }
    } catch (error) {
      return {
        "status": "failed",
        'error': error.toString(),
        "message": "Unknown Error Occurred",
      };
    }
  }
}
