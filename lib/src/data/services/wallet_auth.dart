// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:xendly_mobile/src/data/models/wallet_model.dart';
// import 'package:xendly_mobile/src/data/services/constants.dart';
// import 'package:xendly_mobile/src/data/services/token_storage.dart';

// // class WalletAuth {
// //   // === GET USER WALLETS === //
// //   Future<List<Wallet>> getWallets() async {
// //     final token = TokenStorage().readToken();
// //     print("GetWallets - Token from TokenStorage => $token");

// //     http.Response response = await http.get(
// //       Uri.parse(
// //         "https://xendly-api.herokuapp.com/api/wallets/user",
// //       ),
// //       headers: {
// //         'Content-Type': 'application/json; charset=UTF-8',
// //         'Accept': 'application/json',
// //         'Authorization': "Bearer $token",
// //       },
// //     );

// //     if (response.statusCode == 200) {
// //       final List responseData = jsonDecode(response.body)['data'];
// //       return responseData.map(((wallet) => Wallet.fromJson(wallet))).toList();
// //     } else {
// //       throw Exception(response.reasonPhrase);
// //     }
// //   }
// // }

// const baseUrl = AppConstantData.baseUrl;

// class WalletAuth {
//   Future<List<Wallet>> getWallets() async {
//     final token = TokenStorage().readToken();
//     http.Response response = await http.get(
//       Uri.parse(
//         "$baseUrl/api/wallets/user",
//       ),
//       headers: {
//         'Content-Type': 'application/json; charset=UTF-8',
//         'Accept': 'application/json',
//         'Authorization': "Bearer $token",
//       },
//     );

//     if (response.statusCode == 200) {
//       final List? responseData = jsonDecode(response.body)['data'];
//       if (responseData == null) return [];
//       return responseData.map(((wallet) => Wallet.fromJson(wallet))).toList();
//     } else {
//       throw Exception(response.reasonPhrase);
//     }
//   }

//   Future<Map<String, dynamic>> getCurrencyExchangePair(
//     String fromCurrency,
//     String toCurrency,
//   ) async {
//     final token = TokenStorage().readToken();
//     http.Response response = await http.get(
//       Uri.parse(
//         "https://xendly-api.herokuapp.com/api/misc/single-currency-pair/$fromCurrency/$toCurrency",
//       ),
//       headers: {
//         'Content-Type': 'application/json; charset=UTF-8',
//         'Accept': 'application/json',
//         'Authorization': "Bearer $token",
//       },
//     );

//     if (response.statusCode == 200) {
//       final Map<String, dynamic>? responseData =
//           jsonDecode(response.body)['data'];
//       if (responseData == null) return {};
//       return responseData;
//     } else {
//       throw Exception(response.reasonPhrase);
//     }
//   }

//   Future<Map<String, dynamic>> currencyExchange(
//     double amount,
//     String fromCurrency,
//     String toCurrency,
//   ) async {
//     try {
//       final token = TokenStorage().readToken();
//       http.Response response = await http.post(
//         Uri.parse(
//           "https://xendly-api.herokuapp.com/api/wallets/currency/exchange",
//         ),
//         body: jsonEncode({
//           "amount": amount,
//           "from_currency": fromCurrency,
//           "to_currency": toCurrency
//         }),
//         headers: {
//           'Content-Type': 'application/json; charset=UTF-8',
//           'Accept': 'application/json',
//           'Authorization': "Bearer $token",
//         },
//       );
//       final Map<String, dynamic>? responseBody = jsonDecode(response.body);
//       if (responseBody != null) {
//         if (response.statusCode == 200) {
//           return {'status': 'success', 'message': 'Transaction successful'};
//         } else {
//           return {'status': 'failed', 'message': responseBody['message']};
//         }
//       }

//       return {'status': 'failed', 'message': 'Transaction failed'};
//     } catch (e) {
//       throw Exception(e);
//     }
//   }

//   Future<Map<String, dynamic>> p2pTransfer(
//     double amount,
//     int beneficiaryId,
//     String currency,
//   ) async {
//     try {
//       final token = TokenStorage().readToken();
//       http.Response response = await http.post(
//         Uri.parse(
//           "https://xendly-api.herokuapp.com/api/wallets/transfer/p2p",
//         ),
//         body: jsonEncode({
//           "amount": amount,
//           "beneficiary_id": beneficiaryId,
//           "currency": currency
//         }),
//         headers: {
//           'Content-Type': 'application/json; charset=UTF-8',
//           'Accept': 'application/json',
//           'Authorization': "Bearer $token",
//         },
//       );
//       final Map<String, dynamic>? responseBody = jsonDecode(response.body);
//       print(responseBody);
//       if (responseBody != null) {
//         if (response.statusCode == 200) {
//           return {'status': 'success', 'message': responseBody['message']};
//         } else {
//           if (responseBody['message'] is List) {
//             return {'status': 'failed', 'message': responseBody['message'][0]};
//           } else {
//             return {'status': 'failed', 'message': responseBody['message']};
//           }
//         }
//       }

//       return {'status': 'failed', 'message': 'Transaction failed'};
//     } catch (e) {
//       throw Exception(e);
//     }
//   }

//   Future<Map<String, dynamic>> withdrawToBank(
//     double amount,
//     dynamic beneficiaryID,
//   ) async {
//     print(beneficiaryID);
//     try {
//       final token = TokenStorage().readToken();
//       http.Response response = await http.post(
//         Uri.parse(
//           "https://xendly-api.herokuapp.com/api/wallets/withdrawal/ngn",
//         ),
//         body: jsonEncode({
//           "amount": amount,
//           "beneficiary_id": beneficiaryID,
//         }),
//         headers: {
//           'Content-Type': 'application/json; charset=UTF-8',
//           'Accept': 'application/json',
//           'Authorization': "Bearer $token",
//         },
//       );
//       final Map<String, dynamic>? responseBody = jsonDecode(response.body);
//       if (responseBody != null) {
//         if (response.statusCode == 200) {
//           return {
//             'status': 'success',
//             'message': 'Your withdrawal is being processed'
//           };
//         } else {
//           return {'status': 'failed', 'message': responseBody['message']};
//         }
//       }

//       return {'status': 'failed', 'message': 'Transaction failed'};
//     } catch (e) {
//       throw Exception(e);
//     }
//   }

//   // === REGISTER A USER === //
//   Future<Map<String, dynamic>> sendCash(Map<String, dynamic> data) async {
//     final token = TokenStorage().readToken();
//     try {
//       final response = await http.post(
//         Uri.parse(
//           "https://xendly-api.herokuapp.com/api/wallets/transfer/p2p",
//         ),
//         headers: {
//           'Content-Type': 'application/json; charset=UTF-8',
//           'Accept': 'application/json',
//           'Authorization': "Bearer $token",
//         },
//         body: jsonEncode(
//           <String, dynamic>{
//             "amount": data['amount'],
//             "beneficiary_id": data['beneficiaryId'],
//             "currency": data['currency'],
//           },
//         ),
//       );

//       final responseData = json.decode(response.body);
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         return {
//           "status": "Success",
//           "statusCode": response.statusCode,
//           "data": responseData,
//           "message": "Registration Successful",
//         };
//       } else if (response.statusCode == 422) {
//         return <String, dynamic>{
//           "status": "Failed",
//           "statusCode": response.statusCode,
//           "data": responseData,
//           "message": responseData['message'],
//         };
//       } else {
//         return <String, dynamic>{
//           "status": "Failed",
//           "statusCode": response.statusCode,
//           "data": responseData,
//           "message": "Registration Failed",
//         };
//       }
//     } catch (error) {
//       return {
//         "status": "Failed",
//         'data': error.toString(),
//         "message": "An Unknown Error Occurred - $error",
//       };
//     }
//   }
// }
