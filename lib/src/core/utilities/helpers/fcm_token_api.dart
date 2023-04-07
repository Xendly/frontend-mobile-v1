import "dart:convert";

import "package:http/http.dart" as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import "package:xendly_mobile/src/core/constants/api_paths.dart";

@override
Future<void> handleFcmToken(String? fcmToken) async {
  var storage = const FlutterSecureStorage();

  String? token = await storage.read(key: "token");
  String? deviceId = await storage.read(key: "device_id");

  final response = await http.post(
    Uri.parse(ApiUrls.fcmToken),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'x-session-device-id': deviceId!,
    },
    body: jsonEncode(
      <String, dynamic>{
        'fcm_token': fcmToken,
      },
    ),
  );

  print(response.body.toString());
}
