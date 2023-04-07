import 'dart:convert';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import "package:http/http.dart" as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:xendly_mobile/src/core/constants/api_paths.dart';
import 'package:xendly_mobile/src/core/errors/exception.dart';
import 'package:xendly_mobile/src/data/data_sources/auth_data_sources/data_source.dart';
import 'package:xendly_mobile/src/data/models/auth_model.dart';

final headers = {
  'Content-Type': 'application/json; charset=UTF-8',
  'Accept': 'application/json',
};

encodeData(Map<String, dynamic> data) {
  return jsonEncode(data);
}

class AuthDataSourceImpl implements AuthDataSource {
  final http.Client client;
  AuthDataSourceImpl(this.client);

  var storage = const FlutterSecureStorage();

  // get the name of the device
  String? deviceName;
  Future<void> getDeviceName() async {
    if (GetPlatform.isAndroid) {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceName = androidInfo.model;
    } else {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceName = iosInfo.model;
    }
  }

  String? deviceId;
  Future<void> getDeviceId() async {
    var uuid = const Uuid();
    deviceId = uuid.v4();
    debugPrint("device id from outer - ${deviceId.toString()}");
  }

  SharedPreferences? prefs;
  Future<void> initSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
    debugPrint("shared prefs init from func!");
  }

  @override
  Future<AuthModel> signUp(Map<String, dynamic> data) async {
    final response = await client.post(
      Uri.parse(ApiUrls.register()),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: jsonEncode(
        <String, dynamic>{
          "first_name": data['first_name'],
          "last_name": data['last_name'],
          "email": data['email'],
          "phone": "+234${data['phone']}",
          "country": "Nigeria",
          "username": data['username'],
          "password": data['password'],
        },
      ),
    );

    if (response.statusCode != 200) {
      throw ServerException(
        AuthModel.fromJson(
          json.decode(response.body),
        ),
      );
    } else {
      // store email verification status
      await storage.write(key: "is_verified", value: "false");

      return AuthModel.fromJson(
        json.decode(response.body),
      );
    }
  }

  // >>> verify the account email <<< //
  @override
  Future<AuthModel> verifyEmail(Map<String, dynamic> data) async {
    final response = await client.post(
      Uri.parse(ApiUrls.verifyEmail()),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: jsonEncode(
        <String, dynamic>{
          "token": data["token"],
          "email": data["email"],
        },
      ),
    );

    if (response.statusCode != 200) {
      throw ServerException(
        AuthModel.fromJson(
          json.decode(response.body),
        ),
      );
    } else {
      await storage.write(key: "is_verified", value: "true");
      return AuthModel.fromJson(
        json.decode(response.body),
      );
    }
  }

  // create the pin code for transactions and login
  @override
  Future<AuthModel> createPin(Map<String, dynamic> data) async {
    String? token, deviceId;

    // retrieve device_id from shared prefs
    deviceId = prefs!.getString("device_id");

    // retrieve token from shared prefs
    token = prefs!.getString("token");

    final response = await client.post(
      Uri.parse(ApiUrls.createPin()),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'x-session-device-id': deviceId!,
      },
      body: jsonEncode(
        <String, dynamic>{
          "pin": data['pin'],
        },
      ),
    );

    if (response.statusCode != 200) {
      print(response.body.toString());
      throw ServerException(
        AuthModel.fromJson(
          json.decode(response.body),
        ),
      );
    } else {
      final responseData = json.decode(response.body);

      await storage.write(key: "device_id", value: deviceId);
      await storage.write(key: "token", value: token);

      await storage.write(key: "has_pincode", value: "true");

      // clear everything stored in shared_prefs
      await prefs!.clear();
      print("shared prefs cleared! - $deviceId, $token");

      return AuthModel.fromJson(responseData);
    }
  }

  // anytime a user logs in
  @override
  Future<AuthModel> userLogin(Map<String, dynamic> data) async {
    await getDeviceId();
    await initSharedPrefs();
    await getDeviceName();

    final response = await client.post(
      Uri.parse(ApiUrls.login()),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: jsonEncode(
        <String, dynamic>{
          "email": data['email'],
          "password": data['password'],
          "device_name": deviceName,
          "device_id": deviceId,
        },
      ),
    );

    if (response.statusCode != 200) {
      throw ServerException(
        AuthModel.fromJson(
          json.decode(response.body),
        ),
      );
    } else {
      final responseData = json.decode(response.body);
      final verifyOtp = responseData['verify_otp'];

      if (verifyOtp == false) {
        final tokenFromRes = responseData['token']['token'];
        await prefs!.setString('token', tokenFromRes);
      }

      await storage.write(key: "is_verified", value: "false");
      await prefs!.setString('device_id', deviceId.toString());

      return AuthModel.fromJson(responseData);
    }
  }

  // authorize user login if it's from a new device of if user logs out
  @override
  Future<AuthModel> loginAuth(Map<String, dynamic> data) async {
    // fetch the device name
    await getDeviceName();

    // retrieve device_id from shared prefs
    final String? deviceId = prefs!.getString("device_id");
    debugPrint("device_id retrieved from prefs - $deviceId");

    final response = await client.post(
      Uri.parse(ApiUrls.loginAuth()),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: jsonEncode(
        <String, dynamic>{
          "email": data['email'],
          "otp": data['otp'],
          "device_name": deviceName,
          "device_id": deviceId,
        },
      ),
    );

    if (response.statusCode != 200) {
      debugPrint("error from login auth - ${response.body.toString()}");
      throw ServerException(
        AuthModel.fromJson(
          json.decode(response.body),
        ),
      );
    } else {
      final responseData = json.decode(response.body);
      if (responseData['data']['has_pincode'] == true) {
        // store the response data
        storage.write(
          key: "user_data",
          value: jsonEncode(responseData["data"]),
        );
        await storage.write(key: "device_id", value: deviceId);
        await storage.write(
          key: "token",
          value: responseData["token"]["token"],
        );
        print(
          "token stored in sec_storage - ${responseData["token"]["token"]}",
        );
        storage.write(
          key: "has_pincode",
          value: responseData["data"]["has_pincode"].toString(),
        );
        await storage.write(key: "is_verified", value: "true");
        prefs!.clear();
      } else {
        await storage.write(
          key: "has_pincode",
          value: responseData["data"]["has_pincode"].toString(),
        );
        print(
          "pincode stored in sec_storage - ${responseData["data"]["has_pincode"].toString()}",
        );

        await prefs!.setString("user_data", jsonEncode(responseData["data"]));
        print(
          "user_data stored in shared prefs - ${responseData["data"].toString()}",
        );

        // store token in shared prefs
        await prefs!.setString("token", responseData["token"]['token']);
        print(
          "token stored in shared_prefs - ${responseData["token"]["token"]}",
        );
      }

      return AuthModel.fromJson(
        json.decode(response.body),
      );
    }
  }

  @override
  Future<AuthModel> forgotPassword(Map<String, dynamic> data) async {
    final response = await client.post(
      Uri.parse(ApiUrls.forgotPassword()),
      headers: headers,
      body: encodeData({
        "email": data['email'],
      }),
    );

    if (response.statusCode != 200) {
      throw ServerException(
        AuthModel.fromJson(
          json.decode(response.body),
        ),
      );
    } else {
      return AuthModel.fromJson(
        json.decode(response.body),
      );
    }
  }

  @override
  Future<AuthModel> resetPassword(Map<String, dynamic> data) async {
    final response = await client.post(
      Uri.parse(ApiUrls.resetPassword),
      headers: headers,
      body: encodeData({
        "email": data['email'],
        "token": data['token'],
        "password": data['password'],
      }),
    );

    if (response.statusCode != 200) {
      throw ServerException(
        AuthModel.fromJson(
          json.decode(response.body),
        ),
      );
    } else {
      return AuthModel.fromJson(
        json.decode(response.body),
      );
    }
  }

  // resend verification code
  @override
  Future<AuthModel> resendOtp(String? email) async {
    final response = await client.post(
      Uri.parse(ApiUrls.resendOtp()),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: jsonEncode(
        <String, dynamic>{
          "email": email,
        },
      ),
    );

    if (response.statusCode != 200) {
      throw ServerException(
        AuthModel.fromJson(
          json.decode(response.body),
        ),
      );
    } else {
      return AuthModel.fromJson(
        json.decode(response.body),
      );
    }
  }

  // >>> Verify transaction pin <<< //
  @override
  Future<AuthModel> verifyPin(Map<String, dynamic> data) async {
    String? token = await storage.read(key: "token");
    String? pullDeviceId = await storage.read(key: "device_id");

    print("response from pin - ${pullDeviceId}, Token - ${token}");

    final response = await client.post(
      Uri.parse(ApiUrls.verifyPin()),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'x-session-device-id': '$pullDeviceId',
      },
      body: jsonEncode(
        <String, dynamic>{
          "pin": data['pin'],
        },
      ),
    );

    if (response.statusCode != 200) {
      throw ServerException(
        AuthModel.fromJson(
          json.decode(response.body),
        ),
      );
    } else {
      print("response from impl - ${response.body.toString()}");
      return AuthModel.fromJson(
        json.decode(response.body),
      );
    }
  }

  // >>> logout a user <<< //
  @override
  Future<AuthModel> logout() async {
    String? token = await storage.read(key: "token");
    String? deviceId = await storage.read(key: "device_id");

    print("logout data - ${token}, ${deviceId}");

    final response = await client.post(
      Uri.parse(ApiUrls.logout()),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'x-session-device-id': deviceId!,
      },
    );

    if (response.statusCode != 200) {
      // clear the secure storage
      await storage.deleteAll();
      print("secure storage cleared!");

      throw ServerException(
        AuthModel.fromJson(
          json.decode(response.body),
        ),
      );
    } else {
      // clear the secure storage
      await storage.deleteAll();
      print("secure storage cleared!");

      return AuthModel.fromJson(
        json.decode(response.body),
      );
    }
  }
}
