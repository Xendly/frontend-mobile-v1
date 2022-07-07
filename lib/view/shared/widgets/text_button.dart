import 'package:flutter/material.dart';
import 'package:xendly_mobile/view/shared/colors.dart';
import 'package:xendly_mobile/view/shared/widgets.dart';

class TransButton extends StatelessWidget {
  late Function()? action;
  late String? text;
  late Color? buttonColor, textColor;
  TransButton({
    Key? key,
    this.action,
    this.text,
    this.buttonColor,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: action,
      child: Container(
        margin: const EdgeInsets.only(left: 11, top: 3),
        child: strongBody(
          text,
          textColor,
          FontWeight.w600,
        ),
      ),
      style: ElevatedButton.styleFrom(
        primary: buttonColor,
        elevation: 0,
        minimumSize: const Size(
          double.infinity,
          62,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            50,
          ),
        ),
      ),
    );
  }
}
