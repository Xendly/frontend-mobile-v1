import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:xendly_mobile/src/core/utilities/helpers/validator_helper.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/domain/usecases/auth/login_auth_usecase.dart';
import 'package:xendly_mobile/src/domain/usecases/auth/verify_email_usecase.dart';
import 'package:xendly_mobile/src/presentation/view_model/auth/login_auth_controller.dart';
import 'package:xendly_mobile/src/presentation/view_model/auth/verify_email_controller.dart';
import 'package:xendly_mobile/src/presentation/widgets/buttons/solid_button.dart';
import 'package:xendly_mobile/src/presentation/widgets/titles/title_one.dart';
import '../../../config/routes.dart' as routes;

class LoginOtp extends StatefulWidget {
  const LoginOtp({Key? key}) : super(key: key);
  @override
  State<LoginOtp> createState() => _LoginOtpState();
}

class _LoginOtpState extends State<LoginOtp> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>(debugLabel: "loginOtp");
  TextEditingController? otpController = TextEditingController();

  final LoginAuthController loginAuthController = Get.put(
    LoginAuthController(
      Get.find<LoginAuthUseCase>(),
    ),
  );

  String? email;

  Map<String, dynamic> data = {
    "email": "",
    "otp": "",
  };

  void _submit() async {
    final isValid = formKey.currentState!.validate();
    if (isValid) {
      formKey.currentState!.save();
      try {
        printInfo(info: "Everything is ok...just send!");
        loginAuthController.loginAuth(data);
      } catch (error) {
        Get.snackbar("Error", "Unknown Error Occured, Try Again!");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    otpController;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    try {
      email = Get.parameters['email'].toString();
      debugPrint("Params from prev - ${email.toString()}");
    } catch (err) {
      debugPrint(
        "an error occurred - ${err.toString()}",
      );
    }

    return Scaffold(
      backgroundColor: XMColors.light,
      extendBody: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const TitleOne(
                title: "Verify your account",
                subtitle: "Please check your email for the verification code",
              ),
              Form(
                key: formKey,
                child: PinCodeTextField(
                  length: 6,
                  obscureText: true,
                  blinkWhenObscuring: true,
                  onChanged: (value) {},
                  appContext: context,
                  textStyle: textTheme.titleMedium?.copyWith(
                    color: XMColors.shade1,
                  ),
                  cursorColor: XMColors.primary,
                  cursorHeight: 17,
                  controller: otpController,
                  onSaved: (value) {
                    data["email"] = email;
                    data["otp"] = value;
                  },
                  errorTextSpace: 24.0,
                  validator: (value) => validateToken(value!),
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(8),
                    fieldWidth: 48.0,
                    fieldHeight: 50.0,
                    activeColor: XMColors.shade4,
                    selectedColor: XMColors.primary,
                    inactiveColor: XMColors.shade4,
                    activeFillColor: XMColors.shade6,
                    selectedFillColor: XMColors.shade6,
                    fieldOuterPadding: const EdgeInsets.all(2.0),
                  ),
                  enablePinAutofill: true,
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(height: 24),
              XnSolidButton(
                content: Obx(() {
                  return loginAuthController.isLoading.value
                      ? const CupertinoActivityIndicator()
                      : Text(
                          "Continue",
                          style: textTheme.bodyText1?.copyWith(
                            color: XMColors.shade6,
                            fontWeight: FontWeight.w500,
                          ),
                        );
                }),
                backgroundColor: XMColors.primary,
                action: () => _submit(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
