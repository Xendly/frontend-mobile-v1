import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:xendly_mobile/src/core/constants/api_paths.dart';
import 'package:xendly_mobile/src/core/errors/exception.dart';
import "package:http/http.dart" as http;
import 'package:xendly_mobile/src/data/data_sources/wallet_data_source/data_source.dart';
import 'package:xendly_mobile/src/data/models/wallet_model.dart';

class WalletDataSourceImpl implements WalletDataSource {
  final http.Client client;
  WalletDataSourceImpl(this.client);

  var storage = const FlutterSecureStorage();

  // >>> Get User Wallets <<< //
  @override
  Future<WalletModel> getUserWallets() async {
    String? token = await storage.read(key: "token");
    String? deviceId = await storage.read(key: "device_id");

    final response = await client.get(
      Uri.parse(ApiUrls.getUserWallets()),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'x-session-device-id': deviceId!,
      },
    );

    if (response.statusCode != 200) {
      throw ServerException(
        WalletModel.fromJson(
          json.decode(response.body),
        ),
      );
    } else {
      return WalletModel.fromJson(
        json.decode(response.body),
      );
    }
  }

  // peer to peer transfer
  Future<WalletModel> p2pTransfer(Map<String, dynamic> data) async {
    String? token = await storage.read(key: "token");
    String? pullDeviceId = await storage.read(key: "device_id");

    print(
      "stuff being sent > endpoint - ${data['amount'].toString()}, ${data['beneficiary'].toString()}, ${data['remark'].toString()}, ${data['currency'].toString()}, ${data['save_beneficiary'].toString()}",
    );

    final response = await client.post(
      Uri.parse(ApiUrls.p2pTransfer()),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'x-session-device-id': '$pullDeviceId',
      },
      body: jsonEncode(
        <String, dynamic>{
          "amount": data["amount"],
          "beneficiary": data['beneficiary'],
          "remark": data['remark'],
          "currency": data['currency'],
          "save_beneficiary": data['save_beneficiary'],
        },
      ),
    );

    if (response.statusCode != 200) {
      throw ServerException(
        WalletModel.fromJson(json.decode(response.body)),
      );
    } else {
      return WalletModel.fromJson(json.decode(response.body));
    }
  }
  
  // currency exchange between wallets
  Future<WalletModel> exchange(Map<String, dynamic> data) async {
    String? token = await storage.read(key: "token");
    String? pullDeviceId = await storage.read(key: "device_id");

    final response = await client.post(
      Uri.parse(ApiUrls.exchange()),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'x-session-device-id': pullDeviceId!,
      },
      body: jsonEncode(
        <String, dynamic>{
          "amount": data['amount'],
          "from_currency": data['from_currency'],
          "to_currency": data['to_currency'],
        },
      ),
    );

    if (response.statusCode != 200) {
      throw ServerException(
        WalletModel.fromJson(json.decode(response.body)),
      );
    } else {
      return WalletModel.fromJson(json.decode(response.body));
    }
  }

  // bank transfer for withdrawal
  @override
  Future<WalletModel> bankTransfer(Map<String, dynamic> data) async {
    String? token = await storage.read(key: "token");
    String? pullDeviceId = await storage.read(key: "device_id");

    final response = await client.post(
      Uri.parse(ApiUrls.bankTransfer),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'x-session-device-id': '$pullDeviceId',
      },
      body: jsonEncode(
        <String, dynamic>{
          "amount": data['amount'],
          "account_name": data['account_name'],
          "account_number": data['account_number'],
          "bank_code": data['bank_code'],
          "bank_name": data['bank_name'],
          "narration": null
        },
      ),
    );

    if (response.statusCode != 200) {
      throw ServerException(
        WalletModel.fromJson(json.decode(response.body)),
      );
    } else {
      return WalletModel.fromJson(json.decode(response.body));
    }
  }
}
