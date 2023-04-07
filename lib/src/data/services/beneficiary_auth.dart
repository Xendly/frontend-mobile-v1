import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:xendly_mobile/src/data/models/beneficiary_model.dart';
import 'package:xendly_mobile/src/data/services/token_storage.dart';

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

  Future<List<BeneficiaryData>> getBeneficiaries() async {
    try {
      final token = TokenStorage().readToken();
      http.Response response = await http.get(
        Uri.parse(
          "https://xendly-api.herokuapp.com/api/beneficiaries/all",
        ),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        final List? responseData = jsonDecode(response.body)['data'];
        print(responseData);
        if (responseData == null) return [];
        return responseData
            .map(((beneficiary) => BeneficiaryData.fromJson(beneficiary)))
            .toList();
      } else {
        throw Exception(response.reasonPhrase);
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<Map<String, dynamic>> deleteBeneficiary(String beneficiaryID) async {
    try {
      final token = TokenStorage().readToken();
      final String url = "https://xendly-api.herokuapp.com/api/beneficiaries/remove/$beneficiaryID";
      final response = await http.delete(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': "Bearer $token",
        },
        // body: jsonEncode(
        //   <String, dynamic>{
        //     "id": data['id'],
        //   },
        // ),
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
          "message": responseData,
        };
      } else {
        return {
          "status": "Failed",
          "statusCode": response.statusCode,
          "message": response.body,
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
