import 'package:flutter/material.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/presentation/widgets/title_bar.dart';

class ManageAccountLimits extends StatefulWidget {
  const ManageAccountLimits({Key? key}) : super(key: key);
  @override
  State<ManageAccountLimits> createState() => _ManageAccountLimitsState();
}

class _ManageAccountLimitsState extends State<ManageAccountLimits> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: XMColors.light,
      extendBody: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 24,
            horizontal: 18,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
               TitleBar(
                title: "Manage Account Limits",
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
