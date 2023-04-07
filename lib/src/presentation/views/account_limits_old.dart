import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/config/routes.dart';
import 'package:xendly_mobile/src/data/models/account_summary.dart';
import 'package:xendly_mobile/src/data/services/accounts_service.dart';
import 'package:xendly_mobile/src/presentation/widgets/buttons/rounded.dart';
import 'package:xendly_mobile/src/presentation/widgets/title_bar.dart';

class AccountLimits extends StatefulWidget {
  const AccountLimits({Key? key}) : super(key: key);
  @override
  State<AccountLimits> createState() => _AccountLimitsState();
}

class _AccountLimitsState extends State<AccountLimits> {
  final accountsService = AccountsService();
  late Future<AccountSummaryModel> _accountLimits;

  @override
  void initState() {
    super.initState();
    _accountLimits = accountsService.getAccountLimits();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // getAccountLimits() async {
  //   try {
  //     final result = _accountLimits;
  //     printInfo(info: "Account Limits Result >>> $result");
  //     setState(() {
  //       _accountLimits = result;
  //       _isLoading = false;

  //     });
  //   } catch (err) {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //     printInfo(info: "an error occured >>> $err");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: XMColors.light,
      extendBody: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 24,
              horizontal: 18,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TitleBar(
                  title: "Account Limitations",
                ),
                const SizedBox(height: 32),
                FutureBuilder<AccountSummaryModel>(
                  future: _accountLimits,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Daily Total",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: XMColors.primary_20,
                                    ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                "${snapshot.data?.dailyTotal}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: XMColors.dark,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 26),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Weekly Total",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: XMColors.primary_20,
                                    ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                "${snapshot.data?.weeklyTotal}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: XMColors.dark,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 26),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Monthly Total",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: XMColors.primary_20,
                                    ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                "${snapshot.data?.monthlyTotal}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: XMColors.dark,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      );
                    } else {
                      return const Center(
                        child: SizedBox(
                          height: 40.0,
                          width: 40.0,
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation(XMColors.primary),
                          ),
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(height: 30),
                RoundedButton(
                  text: "Save Changes",
                  action: () => log(
                    "Save Changes",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
