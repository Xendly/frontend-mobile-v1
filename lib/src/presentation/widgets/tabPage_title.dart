import 'package:flutter/material.dart';

class TabPageTitle extends StatelessWidget {
  final Widget? title;
  final Widget? prefix;
  final Widget? suffix;

  const TabPageTitle({
    Key? key,
    this.title,
    this.prefix,
    this.suffix,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        prefix ?? Container(),
        title ?? Container(),
        suffix ?? Container(),
      ],
    );
  }
}
