import 'package:flutter/material.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';

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
        const SizedBox(height: 22),
        Text(
          title ?? "Title",
          style: textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle ?? "Subtitle",
          style: textTheme.bodyMedium?.copyWith(
            color: XMColors.shade2,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 34),
      ],
    );
  }
}
