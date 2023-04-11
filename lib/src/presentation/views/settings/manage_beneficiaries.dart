import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/iconsax_icons.dart';
import 'package:xendly_mobile/src/domain/usecases/beneficiaries/get_beneficiaries_usecase.dart';
import 'package:xendly_mobile/src/presentation/view_model/beneficiaries/get_beneficiaries_controller.dart';
import 'package:xendly_mobile/src/presentation/widgets/title_bar.dart';

import '../../../core/utilities/helpers/transactions_helper.dart';
import '../../../core/utilities/widgets/beneficiary_item.dart';
import '../../../domain/usecases/beneficiaries/delete_beneficiary.dart';
import '../../view_model/beneficiaries/delete_beneficiary_controller.dart';
import '../../widgets/notifications/snackbar.dart';

class ManageBeneficiaries extends StatefulWidget {
  const ManageBeneficiaries({Key? key}) : super(key: key);
  @override
  State<ManageBeneficiaries> createState() => _ManageBeneficiariesState();
}

class _ManageBeneficiariesState extends State<ManageBeneficiaries> {
  final beneficiaries = Get.put(
    GetBeneficiariesController(
      Get.find<GetBeneficiariesUsecase>(),
    ),
  );

  final deleteBeneficiaryController = Get.put(
    DeleteBeneficiaryController(
      Get.find<DeleteBeneficiaryUsecase>(),
    ),
  );

  _deleteBeneficiary(int id) async {
    try {
      await deleteBeneficiaryController.deleteBeneficiary(id);
    } catch (e) {
      xnSnack(
        "An error occurred",
        e.toString(),
        XMColors.error1,
        Icons.cancel_outlined,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    beneficiaries.getBeneficiaries();
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
              const SizedBox(height: 40),
              Obx(
                () {
                  return beneficiaries.isLoading.value
                      ? const Center(
                          child: CupertinoActivityIndicator(),
                        )
                      : beneficiaries.data.isEmpty
                          ? emptyData(
                              context,
                              "No Beneficiaries",
                              Icons.person_2_outlined,
                            )
                          : ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              separatorBuilder: (_, __) =>
                                  const SizedBox(height: 10),
                              itemCount: beneficiaries.data.length,
                              itemBuilder: (_, index) {
                                final beneficiary = beneficiaries.data[index];
                                final loading = false.obs;

                                return Obx(
                                  () => BeneficiaryItem(
                                    title: beneficiary['display_name'],
                                    subtitle: beneficiary['beneficiary']
                                            ['phone']
                                        .toString(),
                                    iconOne: Icons.person_2_outlined,
                                    delete: GestureDetector(
                                      onTap: () async {
                                        loading.value = true;
                                        await _deleteBeneficiary(
                                          int.parse(
                                            beneficiary['beneficiary_id'],
                                          ),
                                        );
                                        // use this to remove from list
                                        beneficiaries.data.removeAt(index);
                                        loading.value = false;
                                      },
                                      child: loading.value == true
                                          ? const CupertinoActivityIndicator(
                                              color: XMColors.error1,
                                            )
                                          : const Icon(
                                              Iconsax.trash,
                                              color: XMColors.error1,
                                            ),
                                    ),
                                  ),
                                );
                              },
                            );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
