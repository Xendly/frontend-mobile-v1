import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/domain/usecases/user/get_profile_usecase.dart';
import 'package:xendly_mobile/src/presentation/view_model/user/get_profile_controller.dart';

import '../widgets/buttons/solid_button.dart';
import '../widgets/inputs/xn_text_field.dart';
import '../widgets/title_bar.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final GetProfileController controller = Get.put(
    GetProfileController(Get.find<GetProfileUsecase>()),
  );

  @override
  void initState() {
    super.initState();
    controller.getProfile();
  }

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
              vertical: 24,
              horizontal: 18,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TitleBar(
                  title: "Manage Profile",
                ),
                const SizedBox(height: 44),
                Obx(() {
                  return controller.isLoading.value
                      ? Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: XMColors.shade6,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  width: 100,
                                  height: 100,
                                ),
                              ),
                              const SizedBox(height: 44),
                              ListView.separated(
                                itemCount: 5,
                                shrinkWrap: true,
                                separatorBuilder: (_, __) => const Padding(
                                  padding: EdgeInsets.only(bottom: 24),
                                ),
                                itemBuilder: (_, __) => const XnTextField(
                                  label: "",
                                  readOnly: true,
                                  filled: true,
                                  enabled: false,
                                  fillColor: XMColors.shade6,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Column(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: XMColors.dark,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                width: 100,
                                height: 100,
                                child: Center(
                                  child: Text(
                                    controller.data['first_name'][0],
                                    textAlign: TextAlign.center,
                                    style: textTheme.headlineMedium?.copyWith(
                                      color: XMColors.shade6,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 44),
                            XnTextField(
                              label:
                                  "${controller.data['first_name']} ${controller.data['last_name']}",
                              readOnly: true,
                              filled: true,
                              enabled: false,
                              fillColor: XMColors.shade4,
                            ),
                            const SizedBox(height: 24),
                            XnTextField(
                              label: controller.data['email'],
                              readOnly: true,
                              filled: true,
                              enabled: false,
                              fillColor: XMColors.shade4,
                            ),
                            const SizedBox(height: 24),
                            XnTextField(
                              label: "+234 ${controller.data['phone']}",
                              readOnly: true,
                              filled: true,
                              enabled: false,
                              fillColor: XMColors.shade4,
                            ),
                            const SizedBox(height: 24),
                            const XnTextField(
                              label: "Username",
                            ),
                            const SizedBox(height: 24),
                            XnTextField(
                              label: controller.data['dob'] ?? "Date of Birth",
                            ),
                            const SizedBox(height: 26),
                            XnSolidButton(
                              content: Text(
                                "Update Profile",
                                style: textTheme.bodyLarge?.copyWith(
                                  color: XMColors.shade6,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              backgroundColor: XMColors.primary,
                              action: () {},
                            ),
                          ],
                        );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
