import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/presentation/widgets/widgets.dart';

// ignore: must_be_immutable
class PasswordInput extends StatelessWidget {
  late String? label, hintText;
  late Widget? suffixIcon, prefixIcon;
  late bool obscureText = false;
  late TextEditingController? controller;
  late Function(String?)? onSaved;
  late String? Function(String?)? validator;
  PasswordInput({
    Key? key,
    this.label,
    this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    this.controller,
    this.onSaved,
    this.validator,
    required this.obscureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        strongBody(label),
        const SizedBox(height: 7),
        TextFormField(
          onSaved: onSaved,
          validator: validator,
          controller: controller,
          autofocus: false,
          style: const TextStyle(
            color: XMColors.primary,
            fontSize: 16,
          ),
          keyboardType: TextInputType.visiblePassword,
          obscureText: obscureText,
          decoration: InputDecoration(
            prefix: const Padding(
              padding: EdgeInsets.only(left: 20.0),
            ),
            errorStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: XMColors.red,
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: XMColors.red,
                width: 1.3,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: XMColors.red,
                width: 1.3,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            isDense: true,
            hintText: hintText,
            hintStyle: const TextStyle(
              color: XMColors.gray,
              fontSize: 16,
            ),
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
            contentPadding: const EdgeInsets.only(bottom: 20, top: 20),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: XMColors.primary,
                width: 1.3,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: XMColors.lightGray,
                width: 1.3,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                color: XMColors.lightGray,
                width: 1.3,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}
