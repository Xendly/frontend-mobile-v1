import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:xendly_mobile/view/shared/colors.dart';
import '../view/pages/onboarding.dart';
import '../view/shared/routes.dart' as route;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await GetStorage.init();
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
        // fontFamily: "TTFirsNeue",
        fontFamily: "Gilroy",
        visualDensity: VisualDensity.comfortable,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: XMColors.primary_20,
            elevation: 0,
            minimumSize: const Size(
              double.infinity,
              62,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                14,
              ),
            ),
          ),
        ),
        textTheme: const TextTheme(
          headline1: TextStyle(
            fontSize: 51.96,
            fontWeight: FontWeight.w500,
            color: XMColors.dark,
            height: 1.4,
          ),
          headline2: TextStyle(
            fontSize: 46.18,
            // fontWeight: FontWeight.w500,
            color: XMColors.dark,
            height: 1.4,
          ),
          headline3: TextStyle(
            fontSize: 32.44,
            fontWeight: FontWeight.w600,
            color: XMColors.dark,
            height: 1.4,
          ),
          headline4: TextStyle(
            fontSize: 28.83,
            fontWeight: FontWeight.w600,
            color: XMColors.dark,
            height: 1.4,
          ),
          headline5: TextStyle(
            fontSize: 25.63,
            fontWeight: FontWeight.w600,
            color: XMColors.dark,
            height: 1.4,
          ),
          headline6: TextStyle(
            fontSize: 22.78,
            fontWeight: FontWeight.w600,
            color: XMColors.dark,
            height: 1.4,
          ),
          subtitle1: TextStyle(
            fontSize: 20.25,
            fontWeight: FontWeight.w700,
            color: XMColors.dark,
          ),
          subtitle2: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: XMColors.dark,
          ),
          bodyText1: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: XMColors.dark,
          ),
          bodyText2: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: XMColors.dark,
          ),
        ),
      ),
      // home: const Onboarding(),
      // getPages: route.getPages,
      onGenerateRoute: route.controller,
      initialRoute: route.initialRoute(),
    );
  }
}
