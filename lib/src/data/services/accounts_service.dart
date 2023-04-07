import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xendly_mobile/src/data/models/account_summary.dart';
import 'package:xendly_mobile/src/data/models/payout_account_model.dart';
import 'package:xendly_mobile/src/data/services/constants.dart';
import 'package:xendly_mobile/src/data/services/token_storage.dart';

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

  Future<Map<String, dynamic>> createPayoutAccount(
      Map<String, dynamic> data) async {
    final token = TokenStorage().readToken();
    print("Token from TokenStorage GxS => $token");

    try {
      http.Response response = await http.post(
        Uri.parse('$baseUrl/api/bank-beneficiaries'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': "Bearer $token",
        },
        body: jsonEncode(data),
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

  Future<List<PayoutAccountModel>> getPayoutAccounts() async {
    final token = TokenStorage().readToken();
    print("Token from TokenStorage GxS => $token");
    try {
      http.Response response = await http.get(
        Uri.parse('$baseUrl/api/bank-beneficiaries/all'),
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
        return results.map((e) => PayoutAccountModel.fromJson(e)).toList();
      }
      return [];
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<AccountSummaryModel> getAccountLimits() async {
    final token = TokenStorage().readToken();
    print("Token >>> Account Limits => $token");
    try {
      http.Response response = await http.get(
        Uri.parse('$baseUrl/api/wallets/withdrawal/summary'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body)["data"];
        final results = AccountSummaryModel.fromJson(responseData);
        print("Account Limits Results => $results");
        return results;
      } else {
        throw Exception(response.reasonPhrase);
      }
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<Map<String, dynamic>> deleteBankAccount(String bankID) async {
    try {
      final token = TokenStorage().readToken();
      final String url =
          "https://xendly-api.herokuapp.com/api/bank-beneficiaries/remove/$bankID";
      final response = await http.delete(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': "Bearer $token",
        },
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
