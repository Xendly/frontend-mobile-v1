import 'package:flutter/material.dart';
import 'package:xendly_mobile/src/presentation/widgets/widgets.dart';

class SolidButton extends StatelessWidget {
  final Function()? action;
  final String? text;
  final Color? buttonColor, textColor;
  final bool isLoading;

  const SolidButton({
    Key? key,
    this.action,
    this.text,
    this.buttonColor,
    this.textColor,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: action,
      child: _getChild(),
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
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

  Widget _getChild() {
    if (isLoading) {
      return const SizedBox(
        height: 26.0,
        width: 26.0,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Colors.white),
          strokeWidth: 2.0,
        ),
      );
    }
    return strongBody(
      text,
      textColor,
      FontWeight.w600,
    );
  }
}
