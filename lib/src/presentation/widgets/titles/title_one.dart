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
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Iconsax.arrow_left,
            size: 26,
          ),
        ),
        const SizedBox(height: 76),
        Text(
          title ?? "Title",
          style: textTheme.headline3?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle ?? "Subtitle",
          style: textTheme.bodyText1?.copyWith(
            color: XMColors.shade2,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 38),
      ],
    );
  }
}
