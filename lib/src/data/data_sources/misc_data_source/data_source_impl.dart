import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:xendly_mobile/src/core/constants/api_paths.dart';
import 'package:xendly_mobile/src/core/errors/exception.dart';
import "package:http/http.dart" as http;
import 'package:xendly_mobile/src/data/data_sources/misc_data_source/data_source.dart';
import 'package:xendly_mobile/src/data/models/misc_model.dart';

class MiscDataSourceImpl implements MiscDataSource {
  final http.Client client;
  MiscDataSourceImpl(this.client);

  var storage = const FlutterSecureStorage();

  // get conversion rates
  @override
  Future<MiscModel> getRate(String from, String to) async {
    String? token = await storage.read(key: "token");
    String? deviceId = await storage.read(key: "device_id");

    final response = await client.get(
      Uri.parse(ApiUrls.rate(from, to)),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'x-session-device-id': deviceId!,
      },
    );

    if (response.statusCode != 200) {
      throw ServerException(
        MiscModel.fromJson(
          json.decode(response.body),
        ),
      );
    } else {
      return MiscModel.fromJson(
        json.decode(response.body),
      );
    }
  }

  // resolve bank account i.e get the details
  @override
  Future<MiscModel> resolveAccount(Map<String, dynamic> data) async {
    String? token = await storage.read(key: "token");
    String? deviceId = await storage.read(key: "device_id");

    final response = await client.post(
      Uri.parse(ApiUrls.resolveAccount()),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'x-session-device-id': deviceId!,
      },
      body: jsonEncode(<String, dynamic>{
        "account_number": data['account_number'],
        "bank_code": data['bank_code'],
      }),
    );

    if (response.statusCode != 200) {
      throw ServerException(
        MiscModel.fromJson(
          json.decode(response.body),
        ),
      );
    } else {
      return MiscModel.fromJson(
        json.decode(response.body),
      );
    }
  }

  // resolve bank account i.e get the details
  @override
  Future<MiscModel> getAcctInfo(Map<String, dynamic> data) async {
    String? token = await storage.read(key: "token");
    String? deviceId = await storage.read(key: "device_id");

    final response = await client.post(
      Uri.parse(ApiUrls.getAcctInfo),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'x-session-device-id': deviceId!,
      },
      body: jsonEncode(<String, dynamic>{
        "account_number": data['account_number'],
        "bank_code": data['bank_code'],
      }),
    );

    if (response.statusCode != 200) {
      throw ServerException(
        MiscModel.fromJson(
          json.decode(response.body),
        ),
      );
    } else {
      return MiscModel.fromJson(
        json.decode(response.body),
      );
    }
  }

  // get banks
  @override
  Future<MiscModel> getBanks() async {
    String? token = await storage.read(key: "token");
    String? deviceId = await storage.read(key: "device_id");

    final response = await client.get(
      Uri.parse(ApiUrls.getBanks()),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'x-session-device-id': deviceId!,
      },
    );

    if (response.statusCode != 200) {
      throw ServerException(
        MiscModel.fromJson(
          json.decode(response.body),
        ),
      );
    } else {
      return MiscModel.fromJson(
        json.decode(response.body),
      );
    }
  }

  // get list of banks
  @override
  Future<MiscModel> getBanksList() async {
    String? token = await storage.read(key: "token");
    String? deviceId = await storage.read(key: "device_id");

    final response = await client.get(
      Uri.parse(ApiUrls.getBanksList),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'x-session-device-id': deviceId!,
      },
    );

    if (response.statusCode != 200) {
      throw ServerException(
        MiscModel.fromJson(
          json.decode(response.body),
        ),
      );
    } else {
      return MiscModel.fromJson(
        json.decode(response.body),
      );
    }
  }
}
