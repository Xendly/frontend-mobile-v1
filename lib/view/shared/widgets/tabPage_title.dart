import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xendly_mobile/view/shared/colors.dart';

class TabPageTitle extends StatelessWidget {
  final Widget? title;
  final List<Widget>? suffix;

  const TabPageTitle({
    Key? key,
    this.title,
    this.suffix,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 2.5),
          child: title,
        ),
        Row(
          children: suffix!,
        ),
        // GestureDetector(
        //   onTap: prefixIconAction ?? () {},
        //   child: SvgPicture.asset(
        //     "assets/icons/bold/icl-arrow-right-2.svg",
        //     width: 24,
        //     height: 24,
        //     color: suffixIconColor ?? XMColors.none,
        //   ),
        // ),
      ],
    );
  }
}
