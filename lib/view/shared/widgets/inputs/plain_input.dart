import 'package:flutter/material.dart';
import 'package:xendly_mobile/view/shared/colors.dart';

class PlainInput extends StatelessWidget {
  final TextInputType? inputType;
  final String? hintText;
  final Widget? suffixIcon, prefixIcon;
  final TextStyle? textStyle, hintStyle;
  const PlainInput({
    Key? key,
    this.inputType,
    this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    this.textStyle,
    this.hintStyle,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: TextFormField(
        autofocus: false,
        style: textStyle,
        keyboardType: inputType,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: hintStyle,
          prefixIconConstraints: const BoxConstraints(
            minWidth: 22,
            minHeight: 22,
          ),
          prefixIcon: prefixIcon,
          suffixIconConstraints: const BoxConstraints(
            minWidth: 22,
            minHeight: 22,
          ),
          suffixIcon: suffixIcon,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: XMColors.primary,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: XMColors.lightGray,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              color: XMColors.lightGray,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 18,
            horizontal: 22,
          ),
        ),
      ),
    );
  }
}
