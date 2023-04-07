import 'package:flutter/material.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';

alertDialog(BuildContext context, IconData icon, String title, String subtitle,
    Function()? close,
    [Color? iconColor]) {
  final textTheme = Theme.of(context).textTheme;
  final screenSize = MediaQuery.of(context).size;

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        insetPadding: const EdgeInsets.all(0),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: XMColors.shade6,
          ),
          width: screenSize.width * 0.8,
          height: 254,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: iconColor,
                size: 58,
              ),
              const SizedBox(height: 24),
              Text(
                title,
                style: textTheme.titleMedium,
              ),
              const SizedBox(height: 6),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium?.copyWith(
                  color: XMColors.shade3,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
