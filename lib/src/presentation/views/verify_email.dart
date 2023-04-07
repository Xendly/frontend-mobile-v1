import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:xendly_mobile/src/core/utilities/helpers/validator_helper.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/domain/usecases/auth/verify_email_usecase.dart';
import 'package:xendly_mobile/src/domain/usecases/auth/resend_otp_usecase.dart';
import 'package:xendly_mobile/src/presentation/view_model/auth/verify_email_controller.dart';
import 'package:xendly_mobile/src/presentation/view_model/auth/resend_otp_controller.dart';
import 'package:xendly_mobile/src/presentation/widgets/buttons/solid_button.dart';
import 'package:xendly_mobile/src/presentation/widgets/titles/title_one.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/iconsax_icons.dart';
import 'package:xendly_mobile/src/presentation/widgets/notifications/snackbar.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({Key? key}) : super(key: key);
  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  GlobalKey<FormState> formKey =
      GlobalKey<FormState>(debugLabel: "verifyEmail");
  TextEditingController? pinController = TextEditingController();

  final VerifyEmailController verifyEmailController = Get.put(
    VerifyEmailController(
      Get.find<VerifyEmailUseCase>(),
    ),
  );

  final ResendOtpController resendOtpController = Get.put(
    ResendOtpController(
      Get.find<ResendOtpUsecase>(),
    ),
  );

  @override
  void initState() {
    super.initState();
    pinController;
  }

  void _submit() async {
    final isValid = formKey.currentState!.validate();
    if (isValid) {
      formKey.currentState!.save();
      try {
        printInfo(info: "Everything is ok...just send!");
        verifyEmailController.verifyEmail(data);
      } catch (error) {
        Get.snackbar("Error", "Unknown Error Occured, Try Again!");
      }
    }
  }

  void resendOtp() async {
    try {
      await resendOtpController.resendOtp(email);
      xnSnack(
        "OTP Resent",
        "Please check your email",
        XMColors.success1,
        Iconsax.tick_circle,
      );
    } catch (error) {
      xnSnack(
        "An error occurred",
        error.toString(),
        XMColors.error0,
        Iconsax.close_circle,
      );
    }
  }

  String? email;

  Map<String, dynamic> data = {
    "token": "",
    "email": "",
  };

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
                title: "Confirm email",
                subtitle: "The code is sent to email",
              ),
              Form(
                key: formKey,
                child: PinCodeTextField(
                  length: 6,
                  onChanged: (value) {},
                  appContext: context,
                  textStyle: textTheme.headline6?.copyWith(
                    color: XMColors.shade1,
                  ),
                  cursorColor: XMColors.primary,
                  cursorHeight: 17,
                  controller: pinController,
                  onSaved: (value) {
                    data["email"] = email;
                    data["token"] = value;
                  },
                  validator: (value) => validateToken(value!),
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(8),
                    fieldWidth: 56,
                    fieldHeight: 56,
                    activeColor: XMColors.shade4,
                    selectedColor: XMColors.primary,
                    inactiveColor: XMColors.shade4,
                    activeFillColor: XMColors.shade6,
                    selectedFillColor: XMColors.shade6,
                  ),
                  enablePinAutofill: true,
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Text(
                    "Didn't get the code? ",
                    style: textTheme.bodyText1?.copyWith(
                      color: XMColors.shade2,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => resendOtp(),
                    child: Obx(() {
                      return resendOtpController.isLoading.value
                          ? Text(
                              "Please wait...",
                              style: textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          : Text(
                              "Resend",
                              style: textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            );
                    }),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              XnSolidButton(
                content: Obx(() {
                  return verifyEmailController.isLoading.value
                      ? const CupertinoActivityIndicator(
                          color: XMColors.shade6,
                        )
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
