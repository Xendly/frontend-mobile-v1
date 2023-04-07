import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/config/routes.dart';
import 'package:xendly_mobile/src/data/models/account_summary.dart';
import 'package:xendly_mobile/src/data/services/accounts_service.dart';
import 'package:xendly_mobile/src/presentation/widgets/buttons/rounded.dart';
import 'package:xendly_mobile/src/presentation/widgets/list_item_3.dart';
import 'package:xendly_mobile/src/presentation/widgets/list_items/list_item_four.dart';
import 'package:xendly_mobile/src/presentation/widgets/title_bar.dart';

import 'package:xendly_mobile/src/presentation/widgets/list_items/list_item_five.dart';

import '../../config/routes.dart' as routes;

class AccountLimits extends StatefulWidget {
  const AccountLimits({Key? key}) : super(key: key);
  @override
  State<AccountLimits> createState() => _AccountLimitsState();
}

class _AccountLimitsState extends State<AccountLimits> {
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
            children: [
              const TitleBar(
                title: "Account Limits",
              ),
              const SizedBox(height: 46),
              Text(
                "DAILY LIMITS",
                style: textTheme.bodyMedium?.copyWith(
                  color: XMColors.shade3,
                  letterSpacing: 1.4,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Sending Per Transaction",
                    style: textTheme.bodyLarge,
                  ),
                  Text(
                    "₦1,000,000",
                    style: textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Receiving Per Transaction",
                    style: textTheme.bodyLarge,
                  ),
                  Text(
                    "Unlimited",
                    style: textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Daily Transfer Limit",
                    style: textTheme.bodyLarge,
                  ),
                  Text(
                    "₦10,000,000",
                    style: textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 46),
              Text(
                "OTHER LIMITS",
                style: textTheme.bodyMedium?.copyWith(
                  color: XMColors.shade3,
                  letterSpacing: 1.4,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Weekly Transfer Limit",
                    style: textTheme.bodyLarge,
                  ),
                  Text(
                    "₦70,000,000",
                    style: textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Monthly Transfer Limit",
                    style: textTheme.bodyLarge,
                  ),
                  Text(
                    "₦280,000,000",
                    style: textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 46),
              Text(
                "You can only send out a given amount of money per period. Your balance in excess will safely remain in your wallet.",
                style: textTheme.bodyLarge?.copyWith(
                  height: 1.5,
                  color: XMColors.shade3,
                ),
              ),
              // Container(
              //   padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(12),
              //     // border: Border.all(
              //     //   color: XMColors.shade4,
              //     //   width: 1.6,
              //     // ),
              //     color: XMColors.primary0,
              //   ),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Text(
              //             "Manage Account Limits",
              //             style: textTheme.bodyLarge?.copyWith(
              //               color: XMColors.shade3,
              //             ),
              //           ),
              //           const SizedBox(height: 8),
              //           Text(
              //             "For Today, 7 Days and 30 Days",
              //             style: textTheme.bodyLarge?.copyWith(
              //               color: XMColors.shade6,
              //             ),
              //           ),
              //         ],
              //       ),
              //       const Icon(
              //         Icons.keyboard_arrow_right,
              //         color: XMColors.shade6,
              //       ),
              //     ],
              //   ),
              // ),
              // const SizedBox(height: 46),
              // Text(
              //   "MANAGE DAILY LIMIT",
              //   style: textTheme.bodyMedium?.copyWith(
              //     color: XMColors.shade3,
              //     letterSpacing: 1.4,
              //     fontWeight: FontWeight.w600,
              //   ),
              // ),
              // const SizedBox(height: 24),
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Text(
              //       "Sending Money",
              //       style: textTheme.bodyLarge,
              //     ),
              //     // Slider(value: 10, onChanged: (10.0){}),
              //     // const SizedBox(height)
              //     Text(
              //       "₦70,000,000",
              //       style: textTheme.bodyLarge?.copyWith(
              //         fontWeight: FontWeight.w600,
              //       ),
              //     ),
              //   ],
              // ),
              // const SizedBox(height: 20),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       "Monthly Transfer Limit",
              //       style: textTheme.bodyLarge,
              //     ),
              //     Text(
              //       "₦280,000,000",
              //       style: textTheme.bodyLarge?.copyWith(
              //         fontWeight: FontWeight.w600,
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
