import 'dart:convert';
import 'package:xendly_mobile/controller/core/token_storage.dart';
import 'package:xendly_mobile/model/wallet_model.dart';
import 'package:http/http.dart' as http;

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

class WalletAuth {
  Future<List<Wallet>?> getWallets() async {
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
      final List responseData = jsonDecode(response.body)['data'];
      return responseData.map(((wallet) => Wallet.fromJson(wallet))).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}