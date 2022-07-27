import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xendly_mobile/view/shared/colors.dart';
import 'package:xendly_mobile/view/shared/widgets/list_item.dart';
import 'package:xendly_mobile/view/shared/widgets/page_title.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
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
                  title: "Notifications",
                  prefixIconColor: XMColors.dark,
                  prefixIconAction: () => Get.back(),
                ),
                const SizedBox(height: 38),
                ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                  horizontalTitleGap: 16,
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(75),
                    child: Image.network(
                      "https://image6.photobiz.com/8812/8_20200708115037_10749543_large.jpg",
                      width: 54,
                      height: 54,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(
                    "You just recieved 5,000 AUD",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      "Cash Transfer - 4h ago ",
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: XMColors.gray,
                          ),
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                  horizontalTitleGap: 16,
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(75),
                    child: Image.network(
                      "https://image6.photobiz.com/8812/8_20200708115037_10749543_large.jpg",
                      width: 54,
                      height: 54,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(
                    "You converted 100 USD to NGN",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      "Cash Exchange - 6h ago ",
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: XMColors.gray,
                          ),
                    ),
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
