import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/config/utilities.dart';
import 'package:xendly_mobile/src/presentation/widgets/widgets.dart';
import 'package:xendly_mobile/src/presentation/widgets/widgets.dart';
import 'package:xendly_mobile/src/presentation/widgets/bottomSheet.dart';
import 'package:xendly_mobile/src/presentation/widgets/buttons/rounded.dart';
import 'package:xendly_mobile/src/presentation/widgets/dropdown_input.dart';
import 'package:xendly_mobile/src/presentation/widgets/page_title.dart';
import 'package:xendly_mobile/src/presentation/widgets/safe_area.dart';
import 'package:xendly_mobile/src/presentation/widgets/solid_button.dart';
import 'package:xendly_mobile/src/presentation/widgets/tabPage_title.dart';
import 'package:xendly_mobile/src/presentation/widgets/text_input.dart';
import 'package:xendly_mobile/src/presentation/widgets/title_bar.dart';
import 'package:xendly_mobile/src/presentation/widgets/wallets_item.dart';
import 'package:xendly_mobile/src/data/models/beneficiary_model.dart';
import 'package:xendly_mobile/src/data/models/country_model.dart';
import 'package:xendly_mobile/src/data/models/transaction_model_old.dart';
import 'package:xendly_mobile/src/data/models/user_model_old.dart';
import 'package:xendly_mobile/src/data/models/wallet_model_old.dart';
import 'package:xendly_mobile/src/data/services/beneficiary_auth.dart';
import 'package:xendly_mobile/src/data/services/public_auth.dart';
import 'package:xendly_mobile/src/data/services/transaction_service.dart';
import 'package:xendly_mobile/src/data/services/user_auth.dart';
import 'package:xendly_mobile/src/data/services/wallet_auth.dart';
import '../../config/routes.dart' as routes;

class FilesAndDocuments extends StatefulWidget {
  const FilesAndDocuments({Key? key}) : super(key: key);

  @override
  State<FilesAndDocuments> createState() => _FilesAndDocumentsState();
}

class _FilesAndDocumentsState extends State<FilesAndDocuments> {
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
                  title: "Files and Documents",
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
