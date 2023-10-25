import 'package:flutter/material.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/iconsax_icons.dart';

class XnTextField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool? obscureContent, enabled, filled, readOnly;
  final String? Function(String?)? validator;
  final String? label;
  final IconData? icon;
  final Color? iconColor, fillColor;
  final Function(String?)? onSaved, onChanged;
  final Function()? iconTap, onTap;

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
      style: textTheme.bodyMedium?.copyWith(
        color: XMColors.shade1,
      ),
      enabled: enabled,
      decoration: InputDecoration(
        label: Padding(
          padding: const EdgeInsets.only(left: 18, bottom: 1),
          child: Text(
            label!,
            style: textTheme.bodyMedium?.copyWith(
              color: XMColors.shade1,
            ),
          ),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        hintStyle: textTheme.bodyMedium?.copyWith(color: XMColors.shade1),
        prefix: const Padding(padding: EdgeInsets.only(left: 18)),
        contentPadding: const EdgeInsets.symmetric(vertical: 20),
        isDense: true,
        filled: filled ?? true,
        fillColor: fillColor ?? XMColors.shade5,
        enabledBorder: fieldBorder(XMColors.shade4),
        focusedBorder: fieldBorder(XMColors.primary0),
        errorBorder: fieldBorder(XMColors.error0),
        focusedErrorBorder: fieldBorder(XMColors.error0),
        disabledBorder: fieldBorder(XMColors.shade4),
        suffixIcon: GestureDetector(
          onTap: iconTap ?? () {},
          child: Icon(
            icon ?? Iconsax.more,
            color: iconColor ?? Colors.transparent,
            size: 22,
          ),
        ),
        errorStyle: textTheme.bodyMedium?.copyWith(
          color: XMColors.error0,
        ),
      ),
    );
  }

  // border customization
  OutlineInputBorder fieldBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: color,
        width: 1.24,
        strokeAlign: BorderSide.strokeAlignCenter,
      ),
    );
  }
}
