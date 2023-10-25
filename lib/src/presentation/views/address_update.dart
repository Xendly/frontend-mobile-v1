import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nigerian_states_and_lga/nigerian_states_and_lga.dart';
import 'package:xendly_mobile/src/core/utilities/helpers/validator_helper.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/iconsax_icons.dart';
import 'package:xendly_mobile/src/domain/usecases/user/update_address_usecase.dart';
import 'package:xendly_mobile/src/presentation/view_model/user/update_address_controller.dart';
import 'package:xendly_mobile/src/presentation/widgets/buttons/solid_button.dart';
import 'package:xendly_mobile/src/presentation/widgets/inputs/app_dropdown.dart';
import 'package:xendly_mobile/src/presentation/widgets/inputs/xn_text_field.dart';
import 'package:xendly_mobile/src/presentation/widgets/title_bar.dart';

import '../../core/utilities/helpers/youverify_sdk.dart';
import '../../domain/usecases/user/get_profile_usecase.dart';
import '../view_model/user/get_profile_controller.dart';

class UpdateAddress extends StatefulWidget {
  const UpdateAddress({Key? key}) : super(key: key);
  @override
  State<UpdateAddress> createState() => _UpdateAddressState();
}

class _UpdateAddressState extends State<UpdateAddress> {
  GlobalKey<FormState> formKey =
      GlobalKey<FormState>(debugLabel: "update_address");

  TextEditingController cityController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController postalController = TextEditingController();

  final UpdateAddressController controller = Get.put(
    UpdateAddressController(
      Get.find<UpdateAddressUsecase>(),
    ),
  );

  Map<String, dynamic> data = {
    "state": "",
    "city": "",
    "address": "",
    "postal_code": "",
  };

  // address update and youverify verification
  final userInfo = Get.put(
    GetProfileController(
      Get.find<GetProfileUsecase>(),
    ),
  );

  void accountVerification(String email) async {
    final result = await youVerifyVForm(
      context,
      YouverifyVformData(
        publicUrl: 'https://xendly.up.railway.app',
        email: email,
      ),
    );
    if (!mounted) return;
    if (result == 'closed' && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Your verification process was cancelled'),
        ),
      );
    }
    if (result == 'success' && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Your information has been submitted and is being processed',
          ),
        ),
      );
    }
    debugPrint('main screen: $result');
  }

  void _submit(String email) async {
    final validate = formKey.currentState!;
    if (validate.validate()) {
      formKey.currentState!.save();
      try {
        await controller.updateAddress(data);
        // call method after address is updated
        accountVerification(email);
      } catch (error) {
        debugPrint("An error occurred - ${error.toString()}");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    userInfo.getProfile();
    cityController;
    addressController;
    postalController;
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
                  title: "Update Address",
                ),
                const SizedBox(height: 28),
                Text(
                  "Please update your address before proceeding with your account verification, this will only take a minute",
                  style: textTheme.bodyLarge?.copyWith(
                    height: 1.5,
                    color: XMColors.shade3,
                  ),
                ),
                const SizedBox(height: 18),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      AppDropdown(
                        label: "State",
                        onChanged: (value) {
                          setState(() {
                            selectedState = value!;
                            data["state"] = selectedState;
                          });
                        },
                        items: NigerianStatesAndLGA.allStates
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        validator: (value) => validateDropdown(value ?? ""),
                        onSaved: (value) => selectedState = value ?? "",
                        icon: Iconsax.arrow_down_1,
                        iconColor: XMColors.shade2,
                      ),
                      const SizedBox(height: 24),
                      XnTextField(
                        label: "City",
                        keyboardType: TextInputType.text,
                        controller: cityController,
                        onSaved: (value) => data["city"] = value!,
                        validator: (value) => validateCity(value!),
                      ),
                      const SizedBox(height: 24),
                      XnTextField(
                        label: "Address",
                        keyboardType: TextInputType.streetAddress,
                        controller: addressController,
                        onSaved: (value) => data["address"] = value!,
                        validator: (value) => validateAddress(value!),
                      ),
                      const SizedBox(height: 24),
                      XnTextField(
                        label: "Postal Code",
                        keyboardType: TextInputType.number,
                        controller: postalController,
                        onSaved: (value) => data["postal_code"] = value!,
                        validator: (value) => validatePostalCode(value!),
                      ),
                      const SizedBox(height: 26),
                      XnSolidButton(
                        content: Obx(() {
                          return controller.isLoading.value
                              ? const CupertinoActivityIndicator(
                                  color: XMColors.shade6,
                                )
                              : Text(
                                  "Update Address",
                                  style: textTheme.bodyText1?.copyWith(
                                    color: XMColors.shade6,
                                    fontWeight: FontWeight.w500,
                                  ),
                                );
                        }),
                        backgroundColor: XMColors.primary,
                        action: () => _submit(userInfo.data['email']),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? selectedState;
}
