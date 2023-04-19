import 'package:flutter/material.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/iconsax_icons.dart';

class TitleOne extends StatelessWidget {
  final String? title, subtitle;
  const TitleOne({
    Key? key,
    this.title,
    this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (Navigator.canPop(context))
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Iconsax.arrow_left,
              size: 26,
            ),
          )
        else
          const SizedBox(
            height: 24.0,
          ),
        const SizedBox(height: 16.0),
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              'assets/images/xendly_logo.png',
              width: 64.0,
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        Text(
          title ?? "Title",
          style: textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          subtitle ?? "Subtitle",
          style: textTheme.bodyLarge?.copyWith(
            color: XMColors.shade2,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 32.0),
      ],
    );
  }
}
