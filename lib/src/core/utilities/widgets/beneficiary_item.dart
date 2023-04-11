import 'package:flutter/material.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';

class BeneficiaryItem extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final Function()? action;
  final IconData? iconOne;
  final Widget? delete;
  final Color? iconColor;

  const BeneficiaryItem({
    Key? key,
    this.title,
    this.subtitle,
    this.action,
    this.iconOne,
    this.delete,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ListTile(
      onTap: action,
      contentPadding: const EdgeInsets.all(0),
      leading: Container(
        decoration: BoxDecoration(
          color: XMColors.primary0,
          borderRadius: BorderRadius.circular(50),
        ),
        padding: const EdgeInsets.all(14),
        child: Icon(
          iconOne,
          color: XMColors.shade6,
        ),
      ),
      title: Text(
        title ?? "",
        style: textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w700,
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Text(
          subtitle ?? "",
          style: textTheme.bodyMedium?.copyWith(
            color: XMColors.shade2,
          ),
        ),
      ),
      trailing: delete,
    );
  }
}
