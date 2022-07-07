import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:xendly_mobile/view/pages/onboarding.dart';
import 'package:xendly_mobile/view/shared/routes.dart' as route;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    const XendlyMobile(),
  );
}

class XendlyMobile extends StatelessWidget {
  const XendlyMobile({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Xendly Mobile',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "TTFirsNeue",
        visualDensity: VisualDensity.comfortable,
      ),
      home: const Onboarding(),
      onGenerateRoute: route.controller,
      initialRoute: route.onboarding,
    );
  }
}
