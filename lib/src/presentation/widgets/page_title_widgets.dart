import 'package:flutter/material.dart';

class PageTitleWidgets extends StatelessWidget {
  final String? title;
  final Widget prefix;
  final Widget suffix;
  final Color? titleColor;

  const PageTitleWidgets({
    Key? key,
    this.title,
    required this.prefix,
    required this.suffix,
    this.titleColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        prefix,
        Padding(
          padding: const EdgeInsets.only(top: 2.5),
          child: Text(
            title ?? "Title",
            style: Theme.of(context).textTheme.subtitle2!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: titleColor,
                ),
          ),
        ),
        suffix,
      ],
    );
  }
}
