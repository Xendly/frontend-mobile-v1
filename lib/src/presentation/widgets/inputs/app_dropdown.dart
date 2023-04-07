import 'package:flutter/material.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/iconsax_icons.dart';

class AppDropdown extends StatelessWidget {
  final Function()? iconTap;
  final Function(String?)? onChanged;
  final TextInputType? keyboardType;
  final Function(String?)? onSaved;
  final bool? obscureContent;
  final String? Function(String?)? validator;
  final String? label;
  final IconData? icon;
  final Color? iconColor;
  final List<DropdownMenuItem<String>>? items;

  const AppDropdown({
    Key? key,
    this.iconTap,
    this.obscureContent,
    this.onChanged,
    this.keyboardType,
    this.onSaved,
    this.validator,
    this.icon,
    this.label,
    this.iconColor,
    this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return DropdownButtonFormField(
      onChanged: onChanged,
      items: items,
      onSaved: onSaved,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: textTheme.bodyText2?.copyWith(
        color: XMColors.shade1,
      ),
      iconSize: 0.0,
      decoration: InputDecoration(
        label: Padding(
          padding: const EdgeInsets.only(
            left: 18,
            top: 1,
          ),
          child: Text(
            label ?? "Your Name",
            style: textTheme.bodyText2?.copyWith(
              color: XMColors.shade1,
            ),
          ),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        hintStyle: textTheme.bodyText2?.copyWith(color: XMColors.shade1),
        prefix: const Padding(padding: EdgeInsets.only(left: 16)),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 20,
        ),
        isDense: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: XMColors.shade4,
            width: 1.2,
            strokeAlign: BorderSide.strokeAlignCenter,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: XMColors.primary0,
            width: 1.2,
            strokeAlign: BorderSide.strokeAlignCenter,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: XMColors.error0,
            width: 1.2,
            strokeAlign: BorderSide.strokeAlignCenter,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: XMColors.error0,
            width: 1.2,
            strokeAlign: BorderSide.strokeAlignCenter,
          ),
        ),
        suffixIcon: GestureDetector(
          onTap: iconTap ?? () {},
          child: Icon(
            icon ?? Iconsax.more,
            color: iconColor ?? Colors.transparent,
          ),
        ),
        errorStyle: textTheme.bodyText2?.copyWith(
          color: XMColors.error0,
        ),
      ),
    );
  }
}
