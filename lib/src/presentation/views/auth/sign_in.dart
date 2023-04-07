import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xendly_mobile/src/domain/usecases/auth/login_usecase.dart';
import 'package:xendly_mobile/src/presentation/view_model/auth/login_view_model.dart';
import 'package:xendly_mobile/src/presentation/widgets/buttons/solid_button.dart';
import 'package:xendly_mobile/src/presentation/widgets/inputs/xn_text_field.dart';
import 'package:xendly_mobile/src/presentation/widgets/titles/title_one.dart';

import '../../../config/routes.dart' as routes;
import '../../../core/utilities/helpers/validator_helper.dart';
import '../../../core/utilities/interfaces/colors.dart';
import '../../../core/utilities/interfaces/iconsax_icons.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>(debugLabel: "login");
  TextEditingController? emailController = TextEditingController();
  TextEditingController? passwordController = TextEditingController();

  final LoginViewModel loginController = Get.put(
    LoginViewModel(
      Get.find<LoginUseCase>(),
    ),
  );

  bool _obscurePassword = true;
  void togglePassword() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  Map<String, dynamic> data = {
    "email": "",
    "password": "",
  };

  @override
  void initState() {
    super.initState();
    emailController;
    passwordController;

    // // handling push notification
    // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    //     FlutterLocalNotificationsPlugin();
    //
    // FirebaseMessaging.onMessage.listen(
    //   (RemoteMessage message) {
    //     RemoteNotification? notification = message.notification;
    //     AndroidNotification? android = message.notification?.android;
    //     if (notification != null && android != null) {
    //       flutterLocalNotificationsPlugin.show(
    //         notification.hashCode,
    //         notification.title,
    //         notification.body,
    //         NotificationDetails(
    //           android: AndroidNotificationDetails(
    //             channel.id,
    //             channel.name,
    //             channel.description,
    //             color: Colors.blue,
    //             icon: "@mipmap/ic_launcher",
    //           ),
    //         ),
    //       );
    //     }
    //   },
    // );
    //
    // FirebaseMessaging.onMessageOpenedApp.listen(
    //   (RemoteMessage message) {
    //     RemoteNotification? notification = message.notification;
    //     AndroidNotification? android = message.notification?.android;
    //     // if (notification != null && android != null) {
    //     //   showDialog(
    //     //     context: context,
    //     //     builder: (_) {
    //     //       return AlertDialog(
    //     //         title: Text(notification.title!),
    //     //         content: SingleChildScrollView(
    //     //           child: Column(
    //     //             crossAxisAlignment: CrossAxisAlignment.start,
    //     //             children: [
    //     //               Text(notification.body!),
    //     //             ],
    //     //           ),
    //     //         ),
    //     //       );
    //     //     },
    //     //   );
    //     // }
    //
    //     if (notification != null && android != null) {
    //       flutterLocalNotificationsPlugin.show(
    //         notification.hashCode,
    //         notification.title,
    //         notification.body,
    //         NotificationDetails(
    //           android: AndroidNotificationDetails(
    //             channel.id,
    //             channel.name,
    //             channel.description,
    //             color: Colors.blue,
    //             icon: "@mipmap/ic_launcher",
    //           ),
    //         ),
    //       );
    //     }
    //   },
    // );
  }

  void _submit() async {
    final isValid = formKey.currentState!.validate();
    if (isValid) {
      formKey.currentState!.save();
      try {
        loginController.userLogin(data);
      } catch (error) {
        Get.snackbar("An error occurred", error.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: XMColors.light,
      extendBody: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 22,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TitleOne(
                  title: "Welcome Back",
                  subtitle: "Log into your account",
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      XnTextField(
                        label: "Email",
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        onSaved: (value) => data["email"] = value!,
                        validator: (value) => validateEmail(value!),
                      ),
                      const SizedBox(height: 24),
                      XnTextField(
                        label: "Password",
                        keyboardType: TextInputType.visiblePassword,
                        controller: passwordController,
                        onSaved: (value) => data["password"] = value!,
                        validator: (value) => validatePassword(value!),
                        iconTap: togglePassword,
                        obscureContent: _obscurePassword ? true : false,
                        icon:
                            _obscurePassword ? Iconsax.eye : Iconsax.eye_slash,
                        iconColor: XMColors.shade2,
                      ),
                      const SizedBox(height: 26),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () => {
                            Navigator.pushNamed(
                              context,
                              routes.forgotPassword,
                            ),
                          },
                          child: Text(
                            "Forgot Password?",
                            style: textTheme.bodyText1?.copyWith(
                              color: XMColors.shade0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 26),
                      XnSolidButton(
                        content: Obx(() {
                          return loginController.isLoading.value
                              ? const CupertinoActivityIndicator(
                                  color: XMColors.shade6,
                                )
                              : Text(
                                  "Login",
                                  style: textTheme.bodyText1?.copyWith(
                                    color: XMColors.shade6,
                                    fontWeight: FontWeight.w500,
                                  ),
                                );
                        }),
                        backgroundColor: XMColors.primary,
                        action: () => _submit(),
                      ),
                      const SizedBox(height: 26),
                      Align(
                        alignment: Alignment.center,
                        child: Text.rich(
                          TextSpan(
                            text: "Don't have an account? ",
                            style: textTheme.bodyText1?.copyWith(
                              color: XMColors.shade1,
                              fontWeight: FontWeight.w500,
                            ),
                            children: [
                              TextSpan(
                                text: "Create one",
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Navigator.pushNamed(
                                        context,
                                        routes.signUp,
                                      ),
                                style: textTheme.bodyText1?.copyWith(
                                  color: XMColors.shade0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
