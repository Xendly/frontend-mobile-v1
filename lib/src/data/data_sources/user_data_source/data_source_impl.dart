import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import "package:http/http.dart" as http;
import 'package:xendly_mobile/src/core/constants/api_paths.dart';
import 'package:xendly_mobile/src/core/errors/exception.dart';
import 'package:xendly_mobile/src/data/data_sources/user_data_source/data_source.dart';
import 'package:xendly_mobile/src/data/models/user_model.dart';
import 'package:xendly_mobile/src/data/models/wallet_model.dart';

class UserDataSourceImpl implements UserDataSource {
  final http.Client client;
  UserDataSourceImpl(this.client);

  var storage = const FlutterSecureStorage();

  // get user data
  @override
  Future<UserModel> getUserData(String username) async {
    String? token = await storage.read(key: "token");
    String? deviceId = await storage.read(key: "device_id");

    final response = await client.get(
      Uri.parse(ApiUrls.getUserData(username)),
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
      return UserModel.fromJson(
        json.decode(response.body),
      );
    }
  }

  // get profile
  @override
  Future<UserModel> getProfile() async {
    String? token = await storage.read(key: "token");
    String? deviceId = await storage.read(key: "device_id");

    final response = await client.get(
      Uri.parse(ApiUrls.getProfile()),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'x-session-device-id': deviceId!,
      },
    );

    if (response.statusCode != 200) {
      debugPrint(response.body.toString());
      throw ServerException(
        WalletModel.fromJson(
          json.decode(response.body),
        ),
      );
    } else {
      debugPrint(response.body.toString());
      return UserModel.fromJson(
        json.decode(response.body),
      );
    }
  }

  // get profile
  @override
  Future<UserModel> updatePin(Map<String, dynamic> data) async {
    String? token = await storage.read(key: "token");
    String? deviceId = await storage.read(key: "device_id");

    final response = await client.post(
      Uri.parse(ApiUrls.updatePin()),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'x-session-device-id': deviceId!,
      },
      body: jsonEncode(
        <String, dynamic>{
          "old_pin": data['old_pin'],
          "pin": data['new_pin'],
        },
      ),
    );

    if (response.statusCode != 200) {
      throw ServerException(
        WalletModel.fromJson(
          json.decode(response.body),
        ),
      );
    } else {
      return UserModel.fromJson(
        json.decode(response.body),
      );
    }
  }

  // verify the bvn details of the user
  @override
  Future<UserModel> bvnVerification(Map<String, dynamic> data) async {
    String? token = await storage.read(key: "token");
    String? deviceId = await storage.read(key: "device_id");

    final response = await client.post(
      Uri.parse(ApiUrls.bvnVerification),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'x-session-device-id': deviceId!,
      },
      body: jsonEncode(<String, dynamic>{
        "dob": data['dob'],
        "first_name": data['first_name'],
        "last_name": data['last_name'],
        "bvn": data['bvn'],
      }),
    );

    if (response.statusCode != 200) {
      throw ServerException(
        WalletModel.fromJson(
          json.decode(response.body),
        ),
      );
    } else {
      return UserModel.fromJson(
        json.decode(response.body),
      );
    }
  }

  // update the address details of the user
  @override
  Future<UserModel> updateAddress(Map<String, dynamic> data) async {
    String? token = await storage.read(key: "token");
    String? deviceId = await storage.read(key: "device_id");

    final response = await client.patch(
      Uri.parse(ApiUrls.addressUpdate),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'x-session-device-id': deviceId!,
      },
      body: jsonEncode(<String, dynamic>{
        "state": data['state'],
        "city": data['city'],
        "address": data['address'],
        "postal_code": data['postal_code'],
      }),
    );

    if (response.statusCode != 200) {
      throw ServerException(
        WalletModel.fromJson(
          json.decode(response.body),
        ),
      );
    } else {
      return UserModel.fromJson(
        json.decode(response.body),
      );
    }
  }

  @override
  Future<UserModel> virtualAccount(Map<String, dynamic> data) async {
    String? token = await storage.read(key: "token");
    String? deviceId = await storage.read(key: "device_id");

    print(data.toString());

    final response = await client.post(
      Uri.parse(
        ApiUrls.virtualAccount(),
      ),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'x-session-device-id': deviceId!,
      },
      body: jsonEncode(<String, dynamic>{
        "bvn": data['bvn'],
      }),
    );

    if (response.statusCode != 200) {
      debugPrint(response.body.toString());
      throw ServerException(
        UserModel.fromJson(
          json.decode(response.body),
        ),
      );
    } else {
      debugPrint(response.body.toString());
      return UserModel.fromJson(
        json.decode(response.body),
      );
    }
  }
}
