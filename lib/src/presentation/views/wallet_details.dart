import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/iconsax_icons.dart';
import 'package:xendly_mobile/src/presentation/widgets/list_item_image.dart';
import 'package:xendly_mobile/src/presentation/widgets/list_items/list_item_four.dart';
import 'package:xendly_mobile/src/presentation/widgets/new_title_bar.dart';
import 'package:xendly_mobile/src/presentation/widgets/title_bar.dart';
import '../../config/routes.dart' as routes;

class WalletDetails extends StatelessWidget {
  const WalletDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: XMColors.light,
      extendBody: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TitleBar(
                  title: "Account Details",
                  suffixIcon: Iconsax.arrow_swap_horizontal,
                  suffixColor: XMColors.none,
                ),
                const SizedBox(height: 48),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(
                          "https://upload.wikimedia.org/wikipedia/en/thumb/a/a4/Flag_of_the_United_States.svg/2560px-Flag_of_the_United_States.svg.png",
                          width: 66,
                          height: 66,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        "\$84,362.00",
                        style: textTheme.headline3?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "United States Dollar",
                        style: textTheme.bodyText1?.copyWith(
                          color: XMColors.shade3,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 48),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          "Statement",
                          style: textTheme.bodyText1?.copyWith(
                            color: XMColors.shade6,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Get.toNamed(
                          routes.walletDetails,
                          // parameters: selectedWallet == "NGN"
                          //     ? {
                          //         "from_currency": selectedWallet!,
                          //         "to_currency": "USD",
                          //       }
                          //     : {
                          //         "from_currency": "USD",
                          //         "to_currency": "NGN",
                          //       },
                        ),
                        child: Text(
                          "Share Details",
                          style: textTheme.bodyText1?.copyWith(
                            color: XMColors.primary0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 48),
                Text(
                  "Dollar Account Details",
                  textAlign: TextAlign.start,
                  style: textTheme.headline6?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                const ListItemFour(
                  title: "Account Holder",
                  subtitle: "Ibrahim Ibrahim",
                  icon: Iconsax.copy,
                ),
                const ListItemFour(
                  title: "Account Number",
                  subtitle: "4EV221406142",
                  icon: Iconsax.copy,
                ),
                const ListItemFour(
                  title: "Swift Code",
                  subtitle: "SIVGYW86XXX",
                  icon: Iconsax.copy,
                ),
                const ListItemFour(
                  title: "Wire Routing",
                  subtitle: "355523487",
                  icon: Iconsax.copy,
                ),
                const ListItemFour(
                  title: "Account Type",
                  subtitle: "Checking",
                  icon: Iconsax.copy,
                ),
                const ListItemFour(
                  title: "Bank Name",
                  subtitle: "Barclays Bank",
                  icon: Iconsax.copy,
                ),
                const ListItemFour(
                  title: "Bank Address",
                  subtitle: "1 Churchill Place, London E14 5HP",
                  icon: Iconsax.copy,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
