import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:xendly_mobile/src/core/utilities/helpers/currency_formatter.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';

class ExchangeField extends StatelessWidget {
  final Widget? currency;
  final String? hintText;
  final TextEditingController? controller;
  final Function(String?)? onSaved;
  final Function(String)? onChanged;
  final Function()? changeCurrency;
  final bool? enabled;
  final Widget? arrowIcon;
  final Color? color;

  const ExchangeField({
    Key? key,
    required this.currency,
    this.hintText,
    this.controller,
    this.changeCurrency,
    this.arrowIcon,
    this.onSaved,
    this.onChanged,
    this.enabled,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    const secBorder = BorderSide(
      width: 1.8,
      color: XMColors.shade4,
    );

    final fieldRadius = BorderRadius.circular(8);

    final f = NumberFormat.decimalPattern();

    return Row(
      children: [
        GestureDetector(
          onTap: changeCurrency,
          child: Container(
            height: 57,
            decoration: BoxDecoration(
              color: XMColors.primary0,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.fromLTRB(18, 0, 10, 0),
            child: Row(
              children: [
                currency ?? SizedBox(),
                const SizedBox(width: 4),
                const Icon(
                  Icons.arrow_drop_down_sharp,
                  size: 26,
                  color: XMColors.shade6,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: TextFormField(
            textAlign: TextAlign.start,
            keyboardType: TextInputType.number,
            inputFormatters: [
              LengthLimitingTextInputFormatter(14),
              FilteringTextInputFormatter.digitsOnly,
              CurrencyInputFormatter(),
            ],
            controller: controller,
            onSaved: onSaved,
            onChanged: onChanged,
            enabled: enabled,
            style: textTheme.bodyLarge!.copyWith(
              color: XMColors.shade0,
              fontWeight: FontWeight.w700,
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                vertical: 18,
                horizontal: 16,
              ),
              isDense: true,
              hintText: hintText ?? "0.00",
              hintStyle: textTheme.bodyLarge!.copyWith(
                color: color,
                fontWeight: FontWeight.w700,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: secBorder,
                borderRadius: fieldRadius,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: secBorder,
                borderRadius: fieldRadius,
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: secBorder,
                borderRadius: fieldRadius,
              ),
              border: OutlineInputBorder(
                borderSide: secBorder,
                borderRadius: fieldRadius,
              ),
            ),
          ),
        ),
      ],
    );

    // return Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     Text(
    //       title,
    //       style: textTheme.bodyLarge?.copyWith(
    //         color: XMColors.shade2,
    //         fontWeight: FontWeight.w500,
    //       ),
    //     ),
    //     const SizedBox(height: 8),
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         Expanded(
    //           flex: 3,
    //           child: TextFormField(
    //             textAlign: TextAlign.start,
    //             keyboardType: TextInputType.number,
    //             inputFormatters: [
    //               LengthLimitingTextInputFormatter(7),
    //               FilteringTextInputFormatter.digitsOnly,
    //             ],
    //             controller: controller,
    //             onSaved: onSaved,
    //             onChanged: onChanged,
    //             enabled: enabled,
    //             style: textTheme.headline2!.copyWith(
    //               color: XMColors.shade0,
    //               fontWeight: FontWeight.w700,
    //             ),
    //             decoration: InputDecoration(
    //               contentPadding: const EdgeInsets.all(0),
    //               isDense: true,
    //               hintText: hintText ?? "0",
    //               hintStyle: textTheme.headline2!.copyWith(
    //                 color: color,
    //                 fontWeight: FontWeight.w700,
    //               ),
    //               focusedBorder: const OutlineInputBorder(
    //                 borderSide: BorderSide(
    //                   color: XMColors.none,
    //                   width: 0,
    //                 ),
    //               ),
    //               enabledBorder: const OutlineInputBorder(
    //                 borderSide: BorderSide(
    //                   color: XMColors.none,
    //                   width: 0,
    //                 ),
    //               ),
    //               disabledBorder: const OutlineInputBorder(
    //                 borderSide: BorderSide(
    //                   color: XMColors.none,
    //                   width: 0,
    //                 ),
    //               ),
    //               border: const OutlineInputBorder(
    //                 borderSide: BorderSide(
    //                   color: XMColors.none,
    //                   width: 0,
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ),
    //         Flexible(
    //           child: GestureDetector(
    //             onTap: changeCurrency,
    //             child: Row(
    //               children: [
    //                 Text(
    //                   currency,
    //                   style: textTheme.headline2!.copyWith(
    //                     color: XMColors.shade0,
    //                     fontWeight: FontWeight.w700,
    //                   ),
    //                 ),
    //                 arrowIcon ?? const SizedBox(),
    //               ],
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //     const SizedBox(height: 6),
    //     Text(
    //       subtitle,
    //       style: textTheme.bodyLarge?.copyWith(
    //         color: XMColors.shade2,
    //         fontWeight: FontWeight.w500,
    //       ),
    //     ),
    //   ],
    // );
  }
}
