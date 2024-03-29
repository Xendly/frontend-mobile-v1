import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/presentation/widgets/widgets.dart';

// I added a T type, which can take any value at compile time, String, int, or even classes. That makes it more dynamic.
// check how I used it inside sign_up.dart
// ignore: must_be_immutable
class DropdownInput<T> extends StatelessWidget {
  String label;
  T? selectedValue;
  String hintText;
  List<DropdownMenuItem<T>>? items;
  Function(T?)? action;
  late Widget? suffixIcon, prefixIcon;
  late BorderRadius borderRadius;
  late Function(T?)? onSaved;
  late String? Function(T?)? validator;
  DropdownInput({
    Key? key,
    required this.label,
    required this.hintText,
    this.items,
    required this.borderRadius,
    this.action,
    this.suffixIcon,
    this.prefixIcon,
    this.onSaved,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        strongBody(label),
        const SizedBox(height: 8),
        DropdownButtonFormField(
          onSaved: onSaved,
          validator: validator,
          value: selectedValue,
          autofocus: false,
          style: const TextStyle(
            color: XMColors.primary,
            fontSize: 16,
          ),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(bottom: 20, top: 20),
            prefix: const Padding(
              padding: EdgeInsets.only(left: 20),
            ),
            errorStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: XMColors.red,
            ),
            suffix: const Padding(
              padding: EdgeInsets.only(right: 18),
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
          ),
          hint: Text(
            hintText,
            style: const TextStyle(
              color: XMColors.gray,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              fontFamily: "TTFirsNeue",
            ),
          ),
          items: items,
          onChanged: action,
          icon: Padding(
            padding: const EdgeInsets.only(
              left: 30,
            ),
            child: SvgPicture.asset(
              "assets/icons/arrow-down-1.svg",
              height: 20,
              width: 17,
              color: XMColors.dark,
            ),
          ),
          iconEnabledColor: XMColors.primary,
          isExpanded: true,
          isDense: true,
        ),
      ],
    );
  }
}
