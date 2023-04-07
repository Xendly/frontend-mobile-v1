import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xendly_mobile/src/data/models/bank_model.dart';
import 'package:xendly_mobile/src/data/services/constants.dart';
import 'package:xendly_mobile/src/data/services/token_storage.dart';

class MiscService {
  // === VARIABLES === //
  final baseUrl = AppConstantData.apiUrl;

  Future<List<BankModel>> getBanks([String country = 'NG']) async {
    final token = TokenStorage().readToken();
    print("Token from TokenStorage GxS => $token");

    try {
      http.Response response = await http.get(
        Uri.parse(
          '$baseUrl/api/misc/banks/$country',
        ),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': "Bearer $token",
        },
      );

      final responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final List? results = responseData['data'];
        print(results);
        if (results == null) return [];
        results.sort((b1, b2) => b1['name'].compareTo(b2['name']));
        // return results as List<Map<String, dynamic>>;
        return results.map((e) => BankModel.fromJson(e)).toList();
      }
      return [];
      // else {
      //   return {
      //     "status": "failed",
      //     "statusCode": response.statusCode,
      //     "data": responseData,
      //     "message": responseData["message"],
      //   };
      // }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<String?> resolveAccountNumber(
    String accountNumber,
    String bankCode,
  ) async {
    print(accountNumber);
    print(bankCode);
    try {
      final token = TokenStorage().readToken();
      http.Response response = await http.post(
        Uri.parse(
          "https://xendly-api.herokuapp.com/api/misc/resolve-bank-account",
        ),
        body: json.encode({
          "account_number": accountNumber,
          "bank_code": bankCode,
        }),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body)['data'];
        print(responseData);
        if (responseData == null) return null;
        return responseData['account_name'];
      }
      return null;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
