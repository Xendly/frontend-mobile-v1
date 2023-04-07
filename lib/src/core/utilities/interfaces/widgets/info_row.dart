import 'package:flutter/material.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';

Row infoRow(String key, String value, Color valueColor, BuildContext context) {
  final textTheme = Theme.of(context).textTheme;

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        key,
        style: textTheme.bodyMedium?.copyWith(
          color: XMColors.shade2,
          fontWeight: FontWeight.w600,
        ),
      ),
      Text(
        value,
        style: textTheme.bodyMedium?.copyWith(
          color: valueColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    ],
  );
}
