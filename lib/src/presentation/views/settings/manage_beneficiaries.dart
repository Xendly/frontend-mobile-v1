import 'package:flutter/material.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/iconsax_icons.dart';
import 'package:xendly_mobile/src/data/models/misc_model.dart';
import 'package:xendly_mobile/src/presentation/widgets/list_items/list_item_one.dart';
import 'package:get/get.dart';
import 'package:xendly_mobile/src/domain/usecases/beneficiaries/get_beneficiaries_usecase.dart';
import 'package:xendly_mobile/src/presentation/view_model/beneficiaries/get_beneficiaries_controller.dart';
import 'package:xendly_mobile/src/presentation/widgets/title_bar.dart';

class ManageBeneficiaries extends StatefulWidget {
  const ManageBeneficiaries({Key? key}) : super(key: key);
  @override
  State<ManageBeneficiaries> createState() => _ManageBeneficiariesState();
}

class _ManageBeneficiariesState extends State<ManageBeneficiaries> {
  final GetBeneficiariesController controller = Get.put(
    GetBeneficiariesController(
      Get.find<GetBeneficiariesUsecase>(),
    ),
  );

  List _beneficiaries = [];
  bool _isLoading = true;

  void fetchBeneficiaries() async {
    try {
      final result = controller.data;
      setState(() {
        _beneficiaries = result;
        _isLoading = false;
      });
    } catch (err) {
      setState(() => _isLoading = false);
      debugPrint("error caught on rates - ${err.toString()}");
    }
  }

  Widget showBeneficiaries() {
    if (_isLoading == true) {
      return const CircularProgressIndicator();
    } else if (_beneficiaries.isEmpty) {
      return const Text("No Beneficiaries");
    } else {
      return Column(
        children: [
          for (var i = 0; i <= 10; i++)
            const ListItemOne(
              title: "Shittu Hakeem",
              subtitle: "+234 902 324 9586",
              iconOne: Iconsax.add,
              iconTwo: Iconsax.trash,
            ),
        ],
      );
    }
  }

  @override
  void initState() {
    super.initState();
    fetchBeneficiaries();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: XMColors.light,
      extendBody: true,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            vertical: 24,
            horizontal: 18,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TitleBar(
                title: "Manage Beneficiaries",
              ),
              const SizedBox(height: 46),
              showBeneficiaries(),
            ],
          ),
        ),
      ),
    );
  }
}
