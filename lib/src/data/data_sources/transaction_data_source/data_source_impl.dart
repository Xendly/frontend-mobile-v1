import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:xendly_mobile/src/core/constants/api_paths.dart';
import 'package:xendly_mobile/src/core/errors/exception.dart';
import "package:http/http.dart" as http;
import 'package:xendly_mobile/src/data/data_sources/transaction_data_source/data_source.dart';
import 'package:xendly_mobile/src/data/models/transaction_model.dart';

class TransactionDataSourceImpl implements TransactionDataSource {
  final http.Client client;
  TransactionDataSourceImpl(this.client);

  var storage = const FlutterSecureStorage();

  // >>> Create Payment Link <<< //
  @override
  Future<TransactionModel> createPaymentLink(Map<String, dynamic> data) async {
    String? token = await storage.read(key: "token");
    String? deviceId = await storage.read(key: "device_id");

    final response = await client.post(
      Uri.parse(ApiUrls.createPaymentLink()),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'x-session-device-id': deviceId!,
      },
      body: jsonEncode(
        <String, dynamic>{
          "currency": data['currency'],
          "amount": data['amount'],
        },
      ),
    );

    if (response.statusCode != 200) {
      throw ServerException(
        TransactionModel.fromJson(
          json.decode(response.body),
        ),
      );
    } else {
      return TransactionModel.fromJson(
        json.decode(response.body),
      );
    }
  }

  // get transactions summary
  @override
  Future<TransactionModel> getTransactions() async {
    String? token = await storage.read(key: "token");
    String? deviceId = await storage.read(key: "device_id");

    final response = await client.get(
      Uri.parse(ApiUrls.transactions()),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'x-session-device-id': deviceId!,
      },
    );

    if (response.statusCode != 200) {
      throw ServerException(
        TransactionModel.fromJson(
          json.decode(response.body),
        ),
      );
    } else {
      return TransactionModel.fromJson(
        json.decode(response.body),
      );
    }
  }

  // get currency transactions summary
  @override
  Future<TransactionModel> getCurrencyTransactions(String currency) async {
    String? token = await storage.read(key: "token");
    String? deviceId = await storage.read(key: "device_id");

    final response = await client.get(
      Uri.parse(ApiUrls.currencyTransactions(currency)),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'x-session-device-id': deviceId!,
      },
    );

    if (response.statusCode != 200) {
      throw ServerException(
        TransactionModel.fromJson(
          json.decode(response.body),
        ),
      );
    } else {
      return TransactionModel.fromJson(
        json.decode(response.body),
      );
    }
  }
}
