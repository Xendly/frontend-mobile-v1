import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:xendly_mobile/src/core/utilities/helpers/validator_helper.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/domain/usecases/auth/create_pin_usecase.dart';
import 'package:xendly_mobile/src/presentation/view_model/auth/create_pin_controller.dart';
import 'package:xendly_mobile/src/presentation/widgets/buttons/solid_button.dart';
import 'package:xendly_mobile/src/presentation/widgets/titles/title_one.dart';

class CreatePIN extends StatefulWidget {
  const CreatePIN({Key? key}) : super(key: key);
  @override
  State<CreatePIN> createState() => _CreatePINState();
}

class _CreatePINState extends State<CreatePIN> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>(debugLabel: "create_pin");
  TextEditingController? pinController = TextEditingController();

  final CreatePinController createPinController = Get.put(
    CreatePinController(
      Get.find<CreatePinUsecase>(),
    ),
  );

  @override
  void initState() {
    super.initState();
    pinController;
  }

  void _submit() async {
    final isValid = formKey.currentState!.validate();
    if (isValid) {
      formKey.currentState!.save();
      try {
        printInfo(info: "Everything is ok...just send!");
        createPinController.createPin(data);
      } catch (error) {
        Get.snackbar("Error", "Unknown Error Occured, Try Again!");
      }
    }
  }

  Map<String, dynamic> data = {
    "pin": "",
  };

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      extendBody: true,
      backgroundColor: XMColors.light,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const TitleOne(
                title: "Create PIN Code",
                subtitle: "For quick login and transactions",
              ),
              Form(
                key: formKey,
                child: PinCodeTextField(
                  length: 4,
                  onChanged: (value) {},
                  appContext: context,
                  textStyle: textTheme.headline6?.copyWith(
                    color: XMColors.shade1,
                  ),
                  cursorColor: XMColors.primary,
                  cursorHeight: 17,
                  controller: pinController,
                  onSaved: (value) => data["pin"] = value,
                  validator: (value) => validatePin(value!),
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(8),
                    fieldWidth: 80,
                    fieldHeight: 56,
                    activeColor: XMColors.shade4,
                    selectedColor: XMColors.primary,
                    inactiveColor: XMColors.shade4,
                    activeFillColor: XMColors.shade6,
                    selectedFillColor: XMColors.shade6,
                  ),
                  enablePinAutofill: true,
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(height: 22),
              XnSolidButton(
                content: Obx(() {
                  return createPinController.isLoading.value
                      ? const CupertinoActivityIndicator(
                          color: XMColors.shade6,
                        )
                      : Text(
                          "Continue",
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
      ),
    );
  }
}
