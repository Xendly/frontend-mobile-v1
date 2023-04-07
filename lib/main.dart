import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:xendly_mobile/src/config/config.dart';
import 'package:xendly_mobile/src/config/routes.dart' as routes;
import 'package:xendly_mobile/src/config/theme.dart';
import 'package:xendly_mobile/src/core/utilities/services/notification_service.dart';
import 'package:xendly_mobile/src/core/utilities/services/push_notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  PushNotificationService.initialize();
  await NotificationService.initialize();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await setupServiceLocator();

  var storage = const FlutterSecureStorage();
  String? deviceId = await storage.read(key: "device_id");
  String? token = await storage.read(key: "token");
  String? hasPincode = await storage.read(key: "has_pincode");
  // String? isVerified = await storage.read(key: "is_verified");

  runApp(
    XendlyMobile(
      deviceId: deviceId ?? "",
      token: token ?? "",
      hasPincode: hasPincode ?? "",
      // isVerified: isVerified ?? "",
    ),
  );
}

class XendlyMobile extends StatelessWidget {
  final String deviceId, token;
  final String hasPincode;
  // , isVerified;

  const XendlyMobile({
    Key? key,
    required this.deviceId,
    required this.token,
    required this.hasPincode,
    // required this.isVerified,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Xendly',
      debugShowCheckedModeBanner: false,
      theme: themeData,
      getPages: routes.getPages,
      initialRoute: deviceId.isEmpty || token.isEmpty
          ? routes.signIn
          // : isVerified != "true"
          //     ? routes.verifyEmail
          : hasPincode == "false"
              ? routes.createPIN
              : routes.enterPIN,
    );
  }
}
