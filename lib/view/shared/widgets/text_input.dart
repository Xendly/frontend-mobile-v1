import 'package:flutter/material.dart';
import 'package:xendly_mobile/view/shared/colors.dart';
import 'package:xendly_mobile/view/shared/widgets.dart';

// ignore: must_be_immutable
class TextInput extends StatelessWidget {
  late TextInputType? inputType;
  late String? label, hintText;
  late String? initialValue = "US";
  late Widget? suffixIcon, prefixIcon;
  late BorderRadius borderRadius;
  late TextEditingController? controller;
  late Function(String?)? onSaved;
  late String? Function(String?)? validator;
  late Function()? onTap;
  late bool readOnly = false;
  TextInput({
    Key? key,
    this.inputType,
    this.label,
    this.hintText,
    this.initialValue,
    this.suffixIcon,
    this.prefixIcon,
    this.controller,
    this.onSaved,
    this.validator,
    this.onTap,
    required this.readOnly,
    required this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        strongBody(label),
        const SizedBox(height: 8),
        TextFormField(
          initialValue: initialValue,
          onTap: onTap,
          readOnly: readOnly,
          onSaved: onSaved,
          validator: validator,
          controller: controller,
          autofocus: false,
          style: const TextStyle(
            color: XMColors.primary,
            fontSize: 16,
          ),
          keyboardType: inputType,
          decoration: InputDecoration(
            prefix: const Padding(
              padding: EdgeInsets.only(
                left: 20.0,
              ),
            ),
            errorStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: XMColors.red,
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: XMColors.red,
                width: 1.3,
              ),
              borderRadius: borderRadius,
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: XMColors.red,
                width: 1.3,
              ),
              borderRadius: borderRadius,
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
              borderRadius: borderRadius,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: XMColors.lightGray,
                width: 1.3,
              ),
              borderRadius: borderRadius,
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                color: XMColors.lightGray,
                width: 1.3,
              ),
              borderRadius: borderRadius,
            ),
          ),
        ),
      ],
    );
  }
}
