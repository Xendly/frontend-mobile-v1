import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';

class MicroListItem extends StatelessWidget {
  final String title;
  final action;

  const MicroListItem({
    Key? key,
    required this.title,
    this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
        color: XMColors.gray_90,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 22),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            SvgPicture.asset(
              "assets/icons/arrow-right-4.svg",
              width: 24,
              height: 24,
              color: XMColors.dark,
            ),
          ],
        ),
      ),
    );
  }
}
