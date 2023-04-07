import 'package:flutter/material.dart';

// === Solid Button 1 === //
class SolidButtonOne extends StatelessWidget {
  final String title;
  final Color btnColor, titleColor;
  final double width, height;
  final Function()? action;
  const SolidButtonOne({
    Key? key,
    required this.title,
    required this.btnColor,
    required this.titleColor,
    required this.width,
    required this.height,
    this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: action ?? () {},
      child: ElevatedButton(
        onPressed: action,
        child: Text(
          title,
          style: textTheme.bodyText2?.copyWith(
            color: titleColor,
          ),
        ),
      ),
    );
  }
}
