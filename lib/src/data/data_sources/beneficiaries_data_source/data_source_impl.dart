import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import "package:http/http.dart" as http;
import 'package:xendly_mobile/src/core/constants/api_paths.dart';
import 'package:xendly_mobile/src/core/errors/exception.dart';
import 'package:xendly_mobile/src/data/data_sources/beneficiaries_data_source/data_source.dart';
import 'package:xendly_mobile/src/data/models/misc_model.dart';

class BeneficiariesDataSourceImpl implements BeneficiariesDataSource {
  final http.Client client;
  BeneficiariesDataSourceImpl(this.client);

  var storage = const FlutterSecureStorage();

  // get beneficiaries
  @override
  Future<MiscModel> getBeneficiaries() async {
    String? token = await storage.read(key: "token");
    String? deviceId = await storage.read(key: "device_id");

    final response = await client.get(
      Uri.parse(ApiUrls.getBeneficiaries()),
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

  // get beneficiaries
  @override
  Future<MiscModel> deleteBeneficiary(int id) async {
    String? token = await storage.read(key: "token");
    String? deviceId = await storage.read(key: "device_id");

    final response = await client.delete(
      Uri.parse(ApiUrls.deleteBeneficiary(id)),
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

  // bank beneficiaries
  @override
  Future<MiscModel> createBankBeneficiary(Map<String, dynamic> data) async {
    String? token = await storage.read(key: "token");
    String? deviceId = await storage.read(key: "device_id");

    final response = await client.post(
      Uri.parse(ApiUrls.createBankBeneficiary()),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'x-session-device-id': deviceId!,
      },
      body: jsonEncode(
        <String, dynamic>{
          "account_name": data['account_name'],
          "account_number": data['account_number'],
          "bank_name": data['bank_name'],
          "bank_code": data['bank_code'],
          "currency": data['currency'],
        },
      ),
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
