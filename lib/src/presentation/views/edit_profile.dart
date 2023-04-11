import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/domain/usecases/user/get_profile_usecase.dart';
import 'package:xendly_mobile/src/domain/usecases/user/update_phone_usecase.dart';
import 'package:xendly_mobile/src/presentation/view_model/user/get_profile_controller.dart';
import 'package:xendly_mobile/src/presentation/view_model/user/update_phone_controller.dart';
import 'package:xendly_mobile/src/presentation/view_model/user/update_username_controller.dart';

import '../../domain/usecases/user/update_username_usecase.dart';
import '../widgets/inputs/xn_text_field.dart';
import '../widgets/title_bar.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final controller = Get.put(
    GetProfileController(
      Get.find<GetProfileUsecase>(),
    ),
  );

  final updatePhoneController = Get.put(
    UpdatePhoneController(Get.find<UpdatePhoneUsecase>()),
  );

  final updateUsernameController = Get.put(
    UpdateUsernameController(Get.find<UpdateUsernameUsecase>()),
  );

  late TextEditingController phoneController;
  late TextEditingController usernameController;

  void _updateUsername() async {
    try {
      await updateUsernameController.updateUsername(usernameController.text);
    } catch (e) {
      print(e.toString());
    }
  }

  void _updatePhone() async {
    try {
      await updatePhoneController.updatePhone(
        "+234${phoneController.text.substring(1)}",
      );
    } catch (e) {
      print(e.toString());
    }
  }

  void _submit() async {
    try {
      await updatePhoneController.updatePhone("+234${phoneController.text}");
      await updateUsernameController.updateUsername(usernameController.text);
    } catch (e) {
      print(e.toString());
    }
  }

  void _getProfile() async {
    await controller.getProfile();
    phoneController.text = controller.data['phone'];
    usernameController.text = controller.data['username'];
  }

  @override
  void initState() {
    super.initState();
    _getProfile();
    phoneController = TextEditingController();
    usernameController = TextEditingController();
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
                GetBuilder<GetProfileController>(
                    init: controller,
                    builder: (_) {
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
                                        borderRadius:
                                            BorderRadius.circular(100),
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
                                        style:
                                            textTheme.headlineMedium?.copyWith(
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
                                Row(
                                  children: [
                                    Flexible(
                                      child: XnTextField(
                                        label: controller.data['phone'],
                                        controller: phoneController,
                                      ),
                                    ),
                                    const SizedBox(width: 14),
                                    Container(
                                      height: 64,
                                      width: 64,
                                      decoration: BoxDecoration(
                                        color: XMColors.primary0,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: GestureDetector(
                                          onTap: () => _updatePhone(),
                                          child: Obx(() {
                                            return updatePhoneController
                                                    .isLoading.value
                                                ? const CupertinoActivityIndicator(
                                                    color: XMColors.shade6,
                                                  )
                                                : const Icon(
                                                    Icons.arrow_forward,
                                                    color: XMColors.shade6,
                                                    size: 22,
                                                  );
                                          })),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 24),
                                Row(
                                  children: [
                                    Flexible(
                                      child: XnTextField(
                                        label: controller.data['username'],
                                        controller: usernameController,
                                        onChanged: (value) {},
                                      ),
                                    ),
                                    const SizedBox(width: 14),
                                    Container(
                                      height: 64,
                                      width: 64,
                                      decoration: BoxDecoration(
                                        color: XMColors.primary0,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: GestureDetector(
                                          onTap: () => _updateUsername(),
                                          child: Obx(() {
                                            return updateUsernameController
                                                    .isLoading.value
                                                ? const CupertinoActivityIndicator(
                                                    color: XMColors.shade6,
                                                  )
                                                : const Icon(
                                                    Icons.arrow_forward,
                                                    color: XMColors.shade6,
                                                    size: 22,
                                                  );
                                          })),
                                    ),

                                    // ElevatedButton(
                                    //   onPressed: () => _submit(),
                                    //   style: ElevatedButton.styleFrom(
                                    //     padding:
                                    //         const EdgeInsets.only(bottom: 2),
                                    //     fixedSize: const Size(0, 64),
                                    //   ),
                                    //   child: Obx(() {
                                    //     return updatePhoneController
                                    //             .isLoading.value
                                    //         ? Text(
                                    //             "Please wait...",
                                    //             style: textTheme.bodyLarge
                                    //                 ?.copyWith(
                                    //                     color: XMColors.shade6),
                                    //           )
                                    //         : Text(
                                    //             "Update Profile",
                                    //             style: textTheme.bodyLarge
                                    //                 ?.copyWith(
                                    //                     color: XMColors.shade6),
                                    //           );
                                    //   }),
                                    // ),
                                  ],
                                ),
                                const SizedBox(height: 26),
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
