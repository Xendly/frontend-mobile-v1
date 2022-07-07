import 'package:flutter/material.dart';
import 'package:xendly_mobile/view/shared/colors.dart';

class CustomCheckbox extends StatefulWidget {
  const CustomCheckbox({Key? key}) : super(key: key);
  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  bool? value = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 20,
          height: 25,
          child: Checkbox(
            value: value,
            onChanged: (bool? value) {
              setState(() {
                this.value = value;
              });
            },
            activeColor: XMColors.accent,
            checkColor: XMColors.light,
            side: const BorderSide(
              color: XMColors.lightGray,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
        const SizedBox(width: 18),
        Flexible(
          child: RichText(
            text: const TextSpan(
              text: "By clicking on Create Account, you agree to our ",
              style: TextStyle(
                fontFamily: "TTFirsNeue",
                color: XMColors.gray,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                height: 1.45,
              ),
              children: [
                TextSpan(
                  text: "Terms and Conditions ",
                  style: TextStyle(
                    fontFamily: "TTFirsNeue",
                    color: XMColors.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    height: 1.45,
                  ),
                ),
                TextSpan(
                  text: "as well as our ",
                  style: TextStyle(
                    fontFamily: "TTFirsNeue",
                    color: XMColors.gray,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    height: 1.45,
                  ),
                ),
                TextSpan(
                  text: "Privacy Policy",
                  style: TextStyle(
                    fontFamily: "TTFirsNeue",
                    color: XMColors.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
