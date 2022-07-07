import 'package:flutter/material.dart';
import 'package:xendly_mobile/view/shared/colors.dart';
import 'package:xendly_mobile/view/shared/widgets.dart';
import 'package:xendly_mobile/view/shared/widgets/recipient_card.dart';
import 'package:xendly_mobile/view/shared/routes.dart' as routes;

class RecipientsTab extends StatefulWidget {
  const RecipientsTab({Key? key}) : super(key: key);
  @override
  State<RecipientsTab> createState() => _RecipientsTabState();
}

class _RecipientsTabState extends State<RecipientsTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 18,
            right: 18,
            top: 32,
            bottom: 22,
          ),
          child: bodyText(
            "Frequents",
            XMColors.gray,
            FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 210,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 14),
            scrollDirection: Axis.horizontal,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    routes.transferFunds,
                  );
                },
                child: const RecipientCard(),
              ),
              const SizedBox(width: 18),
              const RecipientCard(),
              const SizedBox(width: 18),
              const RecipientCard(),
              const SizedBox(width: 18),
              const RecipientCard(),
              const SizedBox(width: 18),
              const RecipientCard(),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(
            left: 18,
            right: 18,
            top: 32,
            bottom: 22,
          ),
          child: bodyText(
            "All Contacts",
            XMColors.gray,
            FontWeight.w600,
          ),
        ),
        listItem(),
        listItem(),
        listItem(),
        listItem(),
        listItem(),
      ],
    );
  }
}
