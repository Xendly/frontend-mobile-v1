import 'package:flutter/material.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/iconsax_icons.dart';

class NewTitleBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? suffix;

  const NewTitleBar({
    Key? key,
    this.title,
    this.suffix,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return PreferredSize(
      preferredSize: preferredSize,
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 32,
          ),
          color: XMColors.shade6,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title ?? "",
                style: textTheme.titleMedium,
              ),
              GestureDetector(
                onTap: () {},
                child: suffix ?? const SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(220);
}
