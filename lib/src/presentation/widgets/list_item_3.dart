import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';

class ListItemThree extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final Function()? action;
  final String icon;

  const ListItemThree({
    Key? key,
    this.title,
    this.subtitle,
    this.action,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: XMColors.gray_70,
              borderRadius: BorderRadius.circular(50),
            ),
            child: SvgPicture.asset(
              icon,
              width: 24,
              height: 24,
              color: XMColors.dark,
            ),
          ),
          const SizedBox(width: 18),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title!,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: XMColors.dark,
                    ),
              ),
              const SizedBox(height: 6),
              Text(
                subtitle!,
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: XMColors.gray_50,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
