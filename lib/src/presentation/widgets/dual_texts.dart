import 'package:flutter/material.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';

class DualTexts extends StatelessWidget {
  final String? title;
  final String? value;

  const DualTexts({
    Key? key,
    this.title,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              title!,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: XMColors.gray,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
        Text(
          value!,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: XMColors.dark,
                fontWeight: FontWeight.w500,
              ),
        ),
      ],
    );
  }
}
