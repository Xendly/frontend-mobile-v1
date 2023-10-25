import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xendly_mobile/src/core/utilities/helpers/validator_helper.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/domain/usecases/auth/forgot_password_usecase.dart';
import 'package:xendly_mobile/src/presentation/view_model/auth/forgot_password_view_model.dart';
import 'package:xendly_mobile/src/presentation/widgets/inputs/xn_text_field.dart';
import 'package:xendly_mobile/src/presentation/widgets/titles/title_one.dart';

import '../../config/routes.dart' as routes;
import '../../core/constants/widget_constants.dart';
import '../../theme/app_theme.dart';
import '../widgets/notifications/snackbar.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);
  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final formKey = GlobalKey<FormState>(debugLabel: "forgot_password");
  TextEditingController? emailController = TextEditingController();

  final _controller = Get.put(
    ForgotPasswordViewModel(Get.find<ForgotPasswordUseCase>()),
  );

  Map<String, dynamic> data = {
    "email": "",
  };

  @override
  void initState() {
    super.initState();
    emailController;
  }

  void _submit() async {
    final isValid = formKey.currentState!;
    if (isValid.validate()) {
      formKey.currentState!.save();
      try {
        await _controller.forgotPassword(data);
        Get.toNamed(routes.resetPassword, parameters: {
          "email": data['email'],
        });
      } catch (e) {
        xnSnack(
          "An error occurred",
          e.toString(),
          XMColors.error1,
          Icons.close,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: XMColors.light,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 22,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // page title
              const TitleOne(
                title: "Forgot Password",
                subtitle: "Recover your password",
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
                    const SizedBox(height: 26),
                    FilledButton(
                      onPressed: () => _submit(),
                      style: AppButtonTheme.filledButtonStyle,
                      child: Obx(() => _controller.isLoading.value
                          ? const CupertinoActivityIndicator(
                              color: AppColors.white,
                            )
                          : const Text("Continue")),
                    ),
                    const SizedBox(height: 20),
                    WidgetConstants.backToLogin(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
