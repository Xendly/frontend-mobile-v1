import 'package:flutter/material.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';

class ListItemFour extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final Function()? action;
  final IconData? icon;

  const ListItemFour({
    Key? key,
    this.title,
    this.subtitle,
    this.action,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ListTile(
      onTap: action,
      contentPadding: const EdgeInsets.all(0),
      title: Text(
        title ?? "",
        style: textTheme.bodyMedium!.copyWith(
          fontWeight: FontWeight.w600,
          color: XMColors.shade3,
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Text(
          subtitle ?? "",
          style: textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.w500,
            color: XMColors.shade0,
          ),
        ),
      ),
      // trailing: Container(
      //   padding: const EdgeInsets.all(10),
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(100),
      //     color: XMColors.primary2.withOpacity(0.3),
      //   ),
      //   child: Icon(
      //     icon,
      //     color: XMColors.primary2,
      //     size: 20,
      //   ),
      // ),
      trailing: Icon(
        icon,
        color: XMColors.primary2,
        size: 24,
      ),
    );
  }
}
