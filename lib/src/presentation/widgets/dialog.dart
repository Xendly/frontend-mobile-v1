import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final Widget? child;
  const CustomDialog({
    Key? key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 50,
          horizontal: 26,
        ),
        child: child,
      ),
    );
  }
}
