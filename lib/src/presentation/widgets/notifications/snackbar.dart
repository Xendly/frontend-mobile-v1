import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';

xnSnack(String title, String subtitle, Color bgColor, IconData icon) {
  return Get.snackbar(
    title,
    subtitle,
    backgroundColor: bgColor,
    colorText: XMColors.shade6,
    duration: const Duration(seconds: 4),
    borderRadius: 0,
    icon: Icon(
      icon,
      color: XMColors.shade6,
    ),
    overlayBlur: 1,
  );
}
