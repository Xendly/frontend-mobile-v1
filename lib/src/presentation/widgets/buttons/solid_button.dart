import 'package:flutter/material.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';

class XnSolidButton extends StatelessWidget {
  final Widget content;
  final Color backgroundColor;
  final Color? borderColor;
  final Function()? action;
  final bool? isLoading;

  const XnSolidButton({
    Key? key,
    required this.content,
    required this.backgroundColor,
    required this.action,
    this.borderColor,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: action,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        side: BorderSide(
          color: borderColor ?? XMColors.primary0,
        ),
      ),
      child: isLoading == true
          ? const SizedBox(
              height: 26.0,
              width: 26.0,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white),
                strokeWidth: 2.0,
              ),
            )
          : content,
    );
  }
}
