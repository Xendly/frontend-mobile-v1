import 'package:flutter/material.dart';
import 'package:xendly_mobile/view/shared/colors.dart';

class ListItemTwo extends StatelessWidget {
  final String? image, title, subtitle, amount;
  final Color? amountColor;
  const ListItemTwo({
    Key? key,
    this.image,
    this.title,
    this.subtitle,
    this.amount,
    this.amountColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: Image.network(
                image ??
                    "https://image6.photobiz.com/8812/8_20200708115037_10749543_large.jpg",
                width: 52,
                height: 54,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 3),
                Text(
                  title ?? "Title",
                  style: Theme.of(context).textTheme.subtitle2!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle ?? "Subtitle",
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: XMColors.gray,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ],
        ),
        Text(
          amount ?? "\$0.00",
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: amountColor ?? XMColors.gray,
                fontWeight: FontWeight.w700,
              ),
        ),
      ],
    );
  }
}
