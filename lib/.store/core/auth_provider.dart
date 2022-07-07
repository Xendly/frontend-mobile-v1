// import 'dart:convert';
// import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;
// import 'package:xendly_mobile/shared/constants.dart';

// class AuthProvider {
//   // === REGISTER A USER === //
//   Future<Map<String, dynamic>> registerUser(
//       Map<String, dynamic> userData) async {
//     try {
//       final response = await http.post(
//         Uri.parse('${AppData.apiUrl}/api/auth/register'),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         body: jsonEncode(<String, dynamic>{
//           "firstName": userData['firstName'],
//           "lastName": userData['lastName'],
//           "email": userData['email'],
//           "country": userData["country"],
//           "phoneNo": userData["phoneNo"],
//           "dateOfBirth": userData["dateOfBirth"],
//           "password": userData['password'],
//         }),
//       );

//       if (response.statusCode == 201) {
//         return jsonDecode(response.body) as Map<String, dynamic>;
//       } else {
//         throw Exception('user registration error');
//       }
//     } catch (e) {
//       debugPrint("$e");
//       rethrow;
//     }
//   }
// }
