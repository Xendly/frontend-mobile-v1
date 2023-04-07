import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';

class ListItem extends StatelessWidget {
  final Function()? action;
  final String? title, icon;
  final Icon? lineicon;
  final Color? iconColor, titleColor;

  const ListItem({
    Key? key,
    this.title,
    this.action,
    this.iconColor,
    this.titleColor,
    this.icon,
    this.lineicon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: action,
      contentPadding: const EdgeInsets.fromLTRB(0, 1, 0, 0),
      minLeadingWidth: 24,
      minVerticalPadding: 19,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      leading: lineicon ??
          SvgPicture.asset(
            icon ?? "assets/icons/icl-lock.svg",
            width: 22,
            height: 22,
            color: iconColor ?? XMColors.dark,
          ),
      title: Text(
        title ?? "Personal Security",
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontWeight: FontWeight.w500,
              color: titleColor ?? XMColors.dark,
            ),
      ),
      trailing: SvgPicture.asset(
        "assets/icons/arrow-right-4.svg",
        width: 24,
        height: 24,
        color: iconColor ?? XMColors.dark,
      ),
    );
  }
}
