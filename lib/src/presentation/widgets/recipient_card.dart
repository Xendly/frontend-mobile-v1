import 'package:flutter/material.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/presentation/widgets/widgets.dart';

class RecipientCard extends StatelessWidget {
  const RecipientCard({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 26,
        right: 26,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: XMColors.primary,
          width: 1.3,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircleAvatar(
            backgroundColor: XMColors.primary,
            backgroundImage: NetworkImage(
              "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80",
            ),
            radius: 34,
          ),
          const SizedBox(
            height: 20,
          ),
          bodyText(
            "Jardaani\nJovonovich",
            XMColors.primary,
            FontWeight.w600,
            TextAlign.center,
            1.4,
          ),
        ],
      ),
    );
  }
}
