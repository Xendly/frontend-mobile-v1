import 'package:flutter/material.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/iconsax_icons.dart';

class XnTextField extends StatelessWidget {
  final Function()? iconTap;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Function(String?)? onSaved, onChanged;
  final bool? obscureContent, enabled, filled;
  final String? Function(String?)? validator;
  final Function()? onTap;
  final bool? readOnly;
  final String? label;
  final IconData? icon;
  final Color? iconColor, fillColor;
  final String? prefixText;

  const XnTextField({
    Key? key,
    this.iconTap,
    this.obscureContent,
    this.controller,
    this.enabled,
    this.filled,
    this.keyboardType,
    this.onSaved,
    this.onChanged,
    this.validator,
    this.icon,
    this.fillColor,
    this.onTap,
    this.readOnly,
    this.label,
    this.iconColor,
    this.prefixText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return TextFormField(
      cursorColor: XMColors.shade0,
      obscureText: obscureContent ?? false,
      controller: controller,
      onSaved: onSaved,
      onChanged: onChanged,
      onTap: onTap,
      readOnly: readOnly ?? false,
      validator: validator,
      keyboardType: keyboardType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: textTheme.bodyLarge?.copyWith(
        color: XMColors.shade1,
      ),
      enabled: enabled,
      decoration: InputDecoration(
        label: Text(
          label ?? "Your Name",
          style: textTheme.bodyLarge?.copyWith(
            color: XMColors.shade1,
          ),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        hintStyle: textTheme.bodyLarge?.copyWith(color: XMColors.shade1),
        prefixText: prefixText ?? "",
        contentPadding: const EdgeInsets.fromLTRB(20, 22, 10, 22),
        // isDense: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: XMColors.shade4,
            width: 1.4,
            strokeAlign: BorderSide.strokeAlignCenter,
          ),
        ),
        filled: filled,
        fillColor: fillColor,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: XMColors.shade0,
            width: 1.4,
            strokeAlign: BorderSide.strokeAlignCenter,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: XMColors.error0,
            width: 1.4,
            strokeAlign: BorderSide.strokeAlignCenter,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: XMColors.error0,
            width: 1.4,
            strokeAlign: BorderSide.strokeAlignCenter,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: XMColors.shade4,
            width: 1.4,
            strokeAlign: BorderSide.strokeAlignCenter,
          ),
        ),
        suffixIcon: GestureDetector(
          onTap: iconTap ?? () {},
          child: Icon(
            icon ?? Iconsax.more,
            color: iconColor ?? Colors.transparent,
            size: 22,
          ),
        ),
        errorStyle: textTheme.bodyText1?.copyWith(
          color: XMColors.error0,
        ),
      ),
    );
  }
}
