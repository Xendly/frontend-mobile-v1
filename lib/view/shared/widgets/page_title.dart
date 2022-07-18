import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xendly_mobile/view/shared/colors.dart';

class PageTitleIcons extends StatelessWidget {
  final String? title;
  final String? prefixIcon;
  final String? suffixIcon;
  final Color? prefixIconColor;
  final Color? suffixIconColor;
  final Function()? prefixIconAction;
  final Color? suffixIconAction;

  const PageTitleIcons({
    Key? key,
    this.title,
    this.prefixIcon,
    this.suffixIcon,
    this.prefixIconColor,
    this.suffixIconColor,
    this.prefixIconAction,
    this.suffixIconAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: prefixIconAction ?? () {},
          child: SvgPicture.asset(
            prefixIcon ?? "assets/icons/bold/icl-arrow-left-2.svg",
            width: 24,
            height: 24,
            color: prefixIconColor ?? XMColors.none,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 2.5),
          child: Text(
            title ?? "Title",
            style: Theme.of(context).textTheme.subtitle2!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        GestureDetector(
          onTap: prefixIconAction ?? () {},
          child: SvgPicture.asset(
            "assets/icons/bold/icl-arrow-right-2.svg",
            width: 24,
            height: 24,
            color: suffixIconColor ?? XMColors.none,
          ),
        ),
      ],
    );
  }
}
