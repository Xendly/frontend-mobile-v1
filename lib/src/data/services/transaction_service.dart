import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xendly_mobile/src/data/models/transaction_model_old.dart';
import 'package:xendly_mobile/src/data/models/wallet_model_old.dart';
import 'package:xendly_mobile/src/data/services/token_storage.dart';

// class WalletAuth {
//   // === GET USER WALLETS === //
//   Future<List<Wallet>> getWallets() async {
//     final token = TokenStorage().readToken();
//     print("GetWallets - Token from TokenStorage => $token");

//     http.Response response = await http.get(
//       Uri.parse(
//         "https://xendly-api.herokuapp.com/api/wallets/user",
//       ),
//       headers: {
//         'Content-Type': 'application/json; charset=UTF-8',
//         'Accept': 'application/json',
//         'Authorization': "Bearer $token",
//       },
//     );

//     if (response.statusCode == 200) {
//       final List responseData = jsonDecode(response.body)['data'];
//       return responseData.map(((wallet) => Wallet.fromJson(wallet))).toList();
//     } else {
//       throw Exception(response.reasonPhrase);
//     }
//   }
// }

class TransactionService {
  Future<String?> createPaymentLink(String amount, String currency) async {
    final token = TokenStorage().readToken();
    http.Response response = await http.post(
      Uri.parse(
        "https://xendly-api.herokuapp.com/api/transactions/create-payment-link",
      ),
      body: json.encode({"currency": currency, "amount": amount}),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body)['data'];
      if (responseData == null) return null;
      return responseData['payment_url'];
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<List<Wallet>> getWallets() async {
    final token = TokenStorage().readToken();
    http.Response response = await http.get(
      Uri.parse(
        "https://xendly-api.herokuapp.com/api/wallets/user",
      ),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      final List? responseData = jsonDecode(response.body)['data'];
      if (responseData == null) return [];
      return responseData.map(((wallet) => Wallet.fromJson(wallet))).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<List<TransactionModel>> getTransactionsSummary() async {
    try {
      final token = TokenStorage().readToken();
      http.Response response = await http.get(
        Uri.parse(
          "https://xendly-api.herokuapp.com/api/transactions/summary?page=1&limit=30",
        ),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        final List? responseData =
            jsonDecode(response.body)['data']['transactions'];
        print(responseData?.reversed);
        if (responseData == null) return [];
        return responseData.map((t) => TransactionModel.fromJson(t)).toList();
      } else {
        throw Exception(response.reasonPhrase);
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
