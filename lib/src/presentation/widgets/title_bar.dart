import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/iconsax_icons.dart';

class TitleBar extends StatelessWidget {
  final String? title;
  final IconData? suffixIcon;
  final Color? suffixColor;
  final Function()? suffixAction;

  const TitleBar({
    Key? key,
    this.title,
    this.suffixIcon,
    this.suffixColor,
    this.suffixAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(
            Icons.arrow_back,
            color: XMColors.shade0,
          ),
        ),
        Text(
          title ?? "",
          style: textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        GestureDetector(
          onTap: suffixAction ?? () {},
          child: Icon(
            suffixIcon ?? Iconsax.notification,
            color: suffixColor ?? XMColors.none,
          ),
        ),
      ],
    );
  }
}
