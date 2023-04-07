import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:xendly_mobile/src/core/utilities/helpers/validator_helper.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/config/routes.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/iconsax_icons.dart';
import 'package:xendly_mobile/src/data/models/account_summary.dart';
import 'package:xendly_mobile/src/data/services/accounts_service.dart';
import 'package:xendly_mobile/src/domain/usecases/user/update_pin_usecase.dart';
import 'package:xendly_mobile/src/presentation/view_model/user/update_pin_controller.dart';
import 'package:xendly_mobile/src/presentation/widgets/buttons/rounded.dart';
import 'package:xendly_mobile/src/presentation/widgets/buttons/solid_button.dart';
import 'package:xendly_mobile/src/presentation/widgets/inputs/xn_text_field.dart';
import 'package:xendly_mobile/src/presentation/widgets/title_bar.dart';

class ChangePin extends StatefulWidget {
  const ChangePin({Key? key}) : super(key: key);
  @override
  State<ChangePin> createState() => _ChangePinState();
}

class _ChangePinState extends State<ChangePin> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>(debugLabel: "change_pin");
  TextEditingController? oldPinController = TextEditingController();
  TextEditingController? newPinController = TextEditingController();

  final UpdatePinController controller = Get.put(
    UpdatePinController(
      Get.find<UpdatePinUsecase>(),
    ),
  );

  void _submit() async {
    final isValid = formKey.currentState!.validate();
    if (isValid) {
      formKey.currentState!.save();
      try {
        printInfo(info: "Everything is ok...just send!");
        controller.updatePin(data);
      } catch (error) {
        Get.snackbar("Error", "Unknown Error Occured, Try Again!");
      }
    }
  }

  Map<String, dynamic> data = {
    "old_pin": "",
    "new_pin": "",
  };

  @override
  void initState() {
    super.initState();
    oldPinController;
    newPinController;
  }

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
                title: "Change 4 Digit PIN",
              ),
              const SizedBox(height: 46),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    XnTextField(
                      label: "Old Pin",
                      keyboardType: TextInputType.number,
                      controller: oldPinController,
                      onSaved: (value) => data["old_pin"] = value!,
                      validator: (value) => validatePin(value!),
                    ),
                    const SizedBox(height: 24),
                    XnTextField(
                      label: "New Pin",
                      keyboardType: TextInputType.number,
                      controller: newPinController,
                      onSaved: (value) => data["new_pin"] = value!,
                      validator: (value) => validatePin(value!),
                    ),
                    const SizedBox(height: 26),
                    XnSolidButton(
                      content: Obx(() {
                        return controller.isLoading.value
                            ? const CupertinoActivityIndicator()
                            : Text(
                                "Change PIN",
                                style: textTheme.bodyText1?.copyWith(
                                  color: XMColors.shade6,
                                  fontWeight: FontWeight.w500,
                                ),
                              );
                      }),
                      backgroundColor: XMColors.primary,
                      action: () => _submit(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
