import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:xendly_mobile/src/config/config.dart';
import 'package:xendly_mobile/src/config/routes.dart' as routes;
import 'package:xendly_mobile/src/config/routes/routes_pages.dart';
import 'package:xendly_mobile/src/config/theme.dart';
import 'package:xendly_mobile/src/core/utilities/services/notification_service.dart';
import 'package:xendly_mobile/src/core/utilities/services/push_notification_service.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // request permissions
  await Permission.camera.request();
  await Permission.microphone.request();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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

  runApp(
    XendlyMobile(
      deviceId: deviceId ?? "",
      token: token ?? "",
      hasPincode: hasPincode ?? "",
    ),
  );
}

class XendlyMobile extends StatelessWidget {
  final String deviceId, token;
  final String hasPincode;

  const XendlyMobile({
    Key? key,
    required this.deviceId,
    required this.token,
    required this.hasPincode,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Xendly',
      debugShowCheckedModeBanner: false,
      theme: themeData,
      getPages: getPages,
      initialRoute: deviceId.isEmpty || token.isEmpty
          ? routes.signIn
          : hasPincode == "false"
              ? routes.createPIN
              : routes.enterPIN,
    );
  }
}
