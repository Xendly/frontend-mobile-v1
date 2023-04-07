import 'package:flutter/material.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';

class ListTileTwo extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final Function()? action;
  final IconData? iconOne, iconTwo;

  const ListTileTwo({
    Key? key,
    this.title,
    this.subtitle,
    this.action,
    this.iconOne,
    this.iconTwo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      onTap: action,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: XMColors.shade4.withOpacity(0.4),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Icon(
          iconOne,
          color: XMColors.primary0,
          size: 26,
        ),
      ),
      title: Text(
        title ?? "",
        style: textTheme.bodyText1!.copyWith(
          fontWeight: FontWeight.w600,
          color: XMColors.shade0,
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Text(
          subtitle ?? "",
          style: textTheme.bodyText2!.copyWith(
            fontWeight: FontWeight.w500,
            color: XMColors.shade4,
          ),
        ),
      ),
      trailing: Icon(
        iconTwo,
        color: XMColors.shade4,
      ),
    );
  }
}
