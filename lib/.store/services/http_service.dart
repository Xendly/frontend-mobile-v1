import 'package:xendly_mobile/repository/auth_repo.dart';
import 'package:xendly_mobile/shared/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:get/get.dart';

enum HttpType {
  post,
  put,
  patch,
}

typedef HttpResponseType = Future<http.Response> Function(Uri,
    {Object? body, Encoding? encoding, Map<String, String>? headers});

class HttpService {
  final String _baseUrl = AppData.apiUrl;
  final Map<HttpType, HttpResponseType> httpReponseType = {
    HttpType.post: http.post,
    HttpType.put: http.put,
    HttpType.patch: http.patch,
  };

  Future<Map<String, dynamic>> get(
    String url, {
    Map<String, String>? headers,
    bool useAuth = false,
  }) async {
    try {
      Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
      requestHeaders.addAll(headers ?? {});
      if (useAuth) {
        debugPrint(
            "User token from http service: ${Get.find<AuthRepo>().userToken}");
        requestHeaders.addAll({
          'authorization': 'Bearer ${Get.find<AuthRepo>().userToken}',
        });
      }
      debugPrint("$requestHeaders");
      final response =
          await http.get(Uri.parse("$_baseUrl$url"), headers: requestHeaders);
      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      rethrow;
    }
  }

  // === SEND SERVICE === //
  Future<Map<String, dynamic>> send(
    String url,
    HttpType type, {
    Map<String, String>? headers,
    final dynamic body,
    bool useAuth = false,
  }) async {
    try {
      // === Headers === //
      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json',
      };
      requestHeaders.addAll(headers ?? {});
      if (useAuth) {
        debugPrint(
          "User token from http service: ${Get.find<AuthRepo>().userToken}",
        );
        requestHeaders.addAll({
          'authorization': 'Bearer ${Get.find<AuthRepo>().userToken}',
        });
      }

      debugPrint("$requestHeaders");

      // === Main === //
      final response = await httpReponseType[type]!(
        Uri.parse("$_baseUrl$url"),
        body: jsonEncode(body),
        headers: requestHeaders,
      );
      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      debugPrint("$e");
      rethrow;
    }
  }

  // === SEND FORM DATA === //
  Future<Map<String, dynamic>> sendFormData(
    String url,
    List<File> files, {
    Map<String, String>? headers,
    final Map<String, String>? body,
    bool useAuth = false,
  }) async {
    try {
      var postUri = Uri.parse("$_baseUrl$url");
      var request = http.MultipartRequest("POST", postUri);
      Map<String, String> requestHeaders = {};
      request.fields.addAll(body ?? {});
      for (var file in files) {
        final index = files.indexOf(file);
        request.files.add(
          await http.MultipartFile.fromPath("images[$index]", file.path),
        );
      }
      if (useAuth) {
        requestHeaders.addAll({
          'authorization': 'Bearer ${Get.find<AuthRepo>().userToken}',
        });
      }
      debugPrint("$requestHeaders");
      request.headers.addAll(requestHeaders);
      final response = await http.Response.fromStream(await request.send());
      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      debugPrint("$e");
      rethrow;
    }
  }
}
