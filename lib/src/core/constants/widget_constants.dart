import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xendly_mobile/src/config/routes.dart';
import 'package:xendly_mobile/src/theme/app_theme.dart';

class WidgetConstants {
  static Align backToLogin(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () => Get.toNamed(Routes.signIn),
        child: Text(
          "Back to Login",
          style: AppTextTheme.textTheme.bodyMedium?.copyWith(
            color: AppColors.navy,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
