import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xendly_mobile/view/shared/colors.dart';
import 'package:xendly_mobile/view/shared/widgets.dart';

// ignore: must_be_immutable
class PlainDropDownInput extends StatelessWidget {
  String? selectedValue;
  String hintText;
  List<DropdownMenuItem<String>>? items;
  Function(String?)? action;
  PlainDropDownInput({
    Key? key,
    required this.hintText,
    this.items,
    this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        dropDownContainer(
          context,
          DropdownButton(
            value: selectedValue,
            hint: Text(
              hintText,
              style: const TextStyle(
                color: XMColors.gray,
                fontSize: 16,
                fontWeight: FontWeight.w700,
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
                height: 16,
                width: 16,
                color: XMColors.primary,
              ),
            ),
            iconEnabledColor: XMColors.primary,
            style: const TextStyle(
              color: XMColors.primary,
              fontSize: 16,
            ),
            underline: Container(padding: const EdgeInsets.all(0)),
            isExpanded: true,
            isDense: true,
          ),
          10,
          10,
        ),
      ],
    );
  }
}
