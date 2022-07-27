import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xendly_mobile/view/shared/colors.dart';
import 'package:xendly_mobile/view/shared/widgets/list_item.dart';
import 'package:xendly_mobile/view/shared/widgets/page_title.dart';

class HelpAndSupport extends StatefulWidget {
  const HelpAndSupport({Key? key}) : super(key: key);

  @override
  State<HelpAndSupport> createState() => _HelpAndSupportState();
}

class _HelpAndSupportState extends State<HelpAndSupport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 24,
              horizontal: 18,
            ),
            child: Column(
              children: [
                PageTitleIcons(
                  prefixIcon: "assets/icons/bold/icl-arrow-left-2.svg",
                  title: "Help and Support",
                  prefixIconColor: XMColors.dark,
                  prefixIconAction: () => Get.back(),
                ),
                const SizedBox(height: 38),
                // content
              ],
            ),
          ),
        ),
      ),
    );
  }
}
