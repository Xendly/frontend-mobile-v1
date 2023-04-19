import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:xendly_mobile/src/core/utilities/helpers/transactions_helper.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/iconsax_icons.dart';
import 'package:xendly_mobile/src/domain/usecases/beneficiaries/delete_beneficiary.dart';
import 'package:xendly_mobile/src/presentation/view_model/beneficiaries/delete_beneficiary_controller.dart';
import 'package:xendly_mobile/src/presentation/widgets/inputs/xn_text_field.dart';
import 'package:xendly_mobile/src/presentation/widgets/notifications/snackbar.dart';

import '../../../config/routes.dart' as routes;
import '../../../core/utilities/widgets/beneficiary_item.dart';
import '../../../core/utilities/widgets/input_field.dart';
import '../../../core/utilities/widgets/wallets_list.dart';
import '../../../domain/usecases/beneficiaries/get_beneficiaries_usecase.dart';
import '../../../domain/usecases/user/get_user_data_usecase.dart';
import '../../../domain/usecases/wallets/get_user_wallets_usecase.dart';
import '../../../presentation/view_model/beneficiaries/get_beneficiaries_controller.dart';
import '../../../presentation/view_model/user/get_user_data_controller.dart';
import '../../../presentation/view_model/wallets/get_user_wallets_controller.dart';
import '../../../presentation/widgets/dialogs/alert_dialog.dart';
import '../../../presentation/widgets/title_bar.dart';

class TransferDetails extends StatefulWidget {
  const TransferDetails({Key? key}) : super(key: key);
  @override
  State<TransferDetails> createState() => _TransferDetailsState();
}

class _TransferDetailsState extends State<TransferDetails> {
  Timer? searchOnStoppedTyping;
  TextEditingController amountController = TextEditingController();
  TextEditingController narrationController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  final NumberFormat _formatter = NumberFormat.currency(
    decimalDigits: 2,
    symbol: "",
  );

  bool saveBeneficiary = false;

  final fullname = "Get recipient name".obs;
  final username = "".obs;
  final benId = "".obs;
  final usingBen = false.obs;

  final ValueNotifier<String?> currencyNotifier = ValueNotifier("");
  final ValueNotifier<String?> beneficiaryNotifier = ValueNotifier("");

  final getUserWalletsController = Get.put(
    GetUserWalletsController(
      Get.find<GetUserWalletsUseCase>(),
    ),
  );

  final GetBeneficiariesController beneficiaries = Get.put(
    GetBeneficiariesController(
      Get.find<GetBeneficiariesUsecase>(),
    ),
  );

  void _submit() {
    if (amountController.text.isEmpty) {
      alertDialog(
        context,
        Iconsax.info_circle,
        "Invalid Amount",
        "No amount is provided",
        () {},
        XMColors.error0,
      );
    } else if (fullname.value == "" || fullname.value.isEmpty) {
      alertDialog(
        context,
        Iconsax.info_circle,
        "Invalid Name",
        "Name is mandatory",
        () {},
        XMColors.error0,
      );
    } else if (usernameController.text.isEmpty) {
      alertDialog(
        context,
        Iconsax.info_circle,
        "Invalid Username",
        "Username is mandatory",
        () {},
        XMColors.error0,
      );
    } else if (double.parse(amountController.value.text) >
        selectedWalletAmount.toDouble()) {
      alertDialog(
        context,
        Iconsax.info_circle,
        "Insufficient Balance",
        "Amount provided is greater than balance",
        () {},
        XMColors.error0,
      );
    } else {
      Get.toNamed(
        routes.confirmTransfer,
        parameters: {
          "username": usernameController.text,
          "full_name": fullname.value,
          "beneficiary": benId.value,
          "amount": amountController.text,
          "narration": narrationController.text.isEmpty
              ? "Sent from ${usernameController.text}"
              : narrationController.text,
          "save_beneficiary": saveBeneficiary.toString(),
          "currency": selectedWallet,
        },
      );
    }
  }

  final formatCurrency = NumberFormat.currency();
  String selectedWallet = "Tap to select a wallet";
  List userWallets = [];
  num selectedWalletAmount = 0.00;

  void getWallets() async {
    await getUserWalletsController.getUserWallets();
    setState(() => userWallets = getUserWalletsController.data);
  }

  final GetUserDataController userInfoController = Get.put(
    GetUserDataController(Get.find<GetUserDataUsecase>()),
  );

  void _getRecipientInfo() async {
    if (GetUtils.isNullOrBlank(usernameController.text)!) {
      alertDialog(
        context,
        Iconsax.info_circle,
        "Invalid Username",
        "Please provide a valid amount",
        () {},
        XMColors.error0,
      );
    } else {
      try {
        final controller = userInfoController;
        await controller.getUserData(
          usernameController.text.toLowerCase(),
        );
        fullname.value = userInfoController.fullName.value;
        benId.value = userInfoController.beneficiaryId.value;
      } catch (err) {
        debugPrint(err.toString());
      }
    }
  }

  _onChangeHandler(value) {
    const duration = Duration(
        seconds: 1); // set the duration that you want call search() after that.
    if (searchOnStoppedTyping != null) {
      setState(() => searchOnStoppedTyping?.cancel()); // clear timer
    }
    setState(() =>
        searchOnStoppedTyping = Timer(duration, () => _getRecipientInfo()));
  }

  @override
  void initState() {
    super.initState();
    getWallets();
    beneficiaries.getBeneficiaries();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: XMColors.shade6,
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 26,
          ),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TitleBar(
                  title: "Transfer Details",
                ),
                const SizedBox(height: 24.0),
                /* GestureDetector(
                  onTap: () => selectBeneficiary(),
                  child: Card(
                    elevation: 0, // set elevation to 0 to remove shadow
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10), // set border radius
                      side: const BorderSide(
                        color: XMColors.primary0, // set border color
                        width: 2, // set border width
                      ),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(
                          18), // add padding to card content
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: XMColors.primary0,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            padding: const EdgeInsets.all(14),
                            child: const Icon(
                              Icons.star,
                              size: 20,
                              color: XMColors.shade6,
                            ),
                          ),
                          const SizedBox(width: 18),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Pick a Beneficiary',
                                style: textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(
                                  height: 4), // add some vertical spacing
                              Text(
                                "Transfer to already saved users",
                                style: textTheme.bodyMedium?.copyWith(
                                  color: XMColors.shade2,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),*/
                // const SizedBox(height: 24),
                GestureDetector(
                  onTap: () => showWallets(),
                  child: ValueListenableBuilder(
                    valueListenable: currencyNotifier,
                    builder: (context, value, _) {
                      return XnTextField(
                        label:
                            "$selectedWallet (${_formatter.format(selectedWalletAmount.toDouble())})",
                        keyboardType: TextInputType.number,
                        enabled: false,
                        readOnly: true,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),
                Obx(() {
                  return InputField(
                    onChanged: _onChangeHandler,
                    label: usingBen.value == true
                        ? Text(
                            username.value,
                            style: textTheme.bodyLarge?.copyWith(
                              color: XMColors.shade1,
                            ),
                          )
                        : Text(
                            "Enter recipient username",
                            style: textTheme.bodyLarge?.copyWith(
                              color: XMColors.shade1,
                            ),
                          ),
                    controller: usernameController,
                    keyboardType: TextInputType.text,
                    enabled: usingBen.value == true ? false : true,
                    readOnly: usingBen.value == true ? true : false,
                    filled: usingBen.value == true ? true : false,
                  );
                }),
                // GestureDetector(
                //   onTap: () => selectBeneficiary(),
                //   child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton.icon(
                      onPressed: () => selectBeneficiary(),
                      icon: const Icon(
                        Icons.star,
                        size: 20,
                        // color: XMColors.shade6,
                      ),
                      label: const Text('Pick a Beneficiary'),
                    )
                    // Text(
                    //   "Tap to show the recipient name",
                    //   style: textTheme.bodyMedium?.copyWith(
                    //     color: XMColors.shade3,
                    //   ),
                    // ),
                  ],
                ),
                // ),
                const SizedBox(height: 4.0),
                Obx(() {
                  if (userInfoController.isLoading.value ||
                      fullname.value.toLowerCase().contains('recipient name') ||
                      fullname.value.isEmpty) {
                    return const SizedBox(height: 0.0);
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InputField(
                        label: Text(
                          fullname.value,
                          style: textTheme.bodyLarge?.copyWith(
                            color: XMColors.shade1,
                          ),
                        ),
                        // label: Obx(
                        //   () {
                        //     return usingBen.value == true
                        //         ? Text(
                        //             fullname.value,
                        //             style: textTheme.bodyLarge?.copyWith(
                        //               color: XMColors.shade1,
                        //             ),
                        //           )
                        //         : userInfoController.isLoading.value
                        //             ? Text(
                        //                 "Retrieving recipient name...",
                        //                 style: textTheme.bodyLarge?.copyWith(
                        //                   color: XMColors.shade1,
                        //                 ),
                        //               )
                        //             : Text(
                        //                 fullname.value,
                        //                 style: textTheme.bodyLarge?.copyWith(
                        //                   color: XMColors.shade1,
                        //                 ),
                        //               );
                        //   },
                        // ),
                        enabled: false,
                        readOnly: true,
                        filled: true,
                      ),
                      const SizedBox(height: 24.0),
                    ],
                  );
                }),

                // const SizedBox(height: 10),
                // Row(
                //   children: [
                //     Container(
                //       margin: const EdgeInsets.only(top: 2),
                //       child: const Icon(
                //         Icons.info_outline,
                //         color: XMColors.shade3,
                //         size: 20,
                //       ),
                //     ),
                //     const SizedBox(width: 6),
                //     Text(
                //       "Tap to show the recipient name",
                //       style: textTheme.bodyMedium?.copyWith(
                //         color: XMColors.shade3,
                //       ),
                //     ),
                //   ],
                // ),
                // const SizedBox(height: 16.0),
                XnTextField(
                  label: "Amount to send",
                  controller: amountController,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 24.0),
                XnTextField(
                  label: "Narration (Optional)",
                  controller: narrationController,
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Save as a Beneficiary",
                      style: textTheme.bodyLarge,
                    ),
                    Switch(
                      onChanged: (value) {
                        setState(() => saveBeneficiary = value);
                      },
                      value: saveBeneficiary,
                      activeColor: XMColors.success1,
                      activeTrackColor: XMColors.success1,
                      inactiveThumbColor: XMColors.shade3,
                      inactiveTrackColor: XMColors.shade1,
                    )
                  ],
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => _submit(),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.only(bottom: 2),
                    fixedSize: const Size(0, 64),
                  ),
                  child: Text(
                    "Continue",
                    style:
                        textTheme.bodyLarge?.copyWith(color: XMColors.shade6),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showWallets() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        final walletOut = getUserWalletsController.data;
        return WalletsList(
          itemCount: walletOut.length,
          itemBuilder: (_, index) {
            final wallet = walletOut[index];
            return Obx(
              () {
                return getUserWalletsController.isLoading.value
                    ? const CupertinoActivityIndicator()
                    : ListTile(
                        onTap: () => setState(() {
                          selectedWallet = wallet['currency'].toString();
                          selectedWalletAmount = wallet['balance'];
                          Get.back();
                        }),
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(
                            wallet["currency"] == "NGN"
                                ? "assets/images/ngn.png"
                                : "assets/images/usd.png",
                          ),
                          backgroundColor: XMColors.shade3,
                        ),
                        title: Text(
                          wallet["currency"] == "NGN"
                              ? "Nigerian Naira"
                              : "United States Dollar",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            wallet["currency"],
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: XMColors.shade3,
                                    ),
                          ),
                        ),
                        trailing: Text(
                          wallet["currency"] == "NGN"
                              ? NumberFormat.currency(
                                  locale: "en_NG",
                                  symbol: "\u20A6",
                                ).format(
                                  double.parse(wallet["balance"].toString()),
                                )
                              : NumberFormat.currency(
                                  locale: "en_US",
                                  symbol: "\u0024",
                                ).format(
                                  double.parse(wallet["balance"].toString()),
                                ),
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: XMColors.shade0,
                                  ),
                        ),
                      );
              },
            );
          },
        );
      },
    );
  }

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

  selectBeneficiary() {
    final textTheme = Theme.of(context).textTheme;

    showDialog(
      context: context,
      builder: (context) {
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Pick a Beneficiary",
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: const Icon(
                          Icons.close,
                          size: 26,
                          color: XMColors.shade0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
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
                                    final beneficiary =
                                        beneficiaries.data[index];

                                    final loading = false.obs;

                                    return Obx(
                                      () => GestureDetector(
                                        onTap: () {
                                          fullname.value =
                                              beneficiary['display_name'];
                                          username.value =
                                              beneficiary['beneficiary']
                                                  ['username'];
                                          usernameController.text =
                                              beneficiary['beneficiary']
                                                  ['username'];
                                          benId.value =
                                              beneficiary['beneficiary_id'];
                                          usingBen.value = true;

                                          Get.back();
                                        },
                                        child: BeneficiaryItem(
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
                                              beneficiaries.data
                                                  .removeAt(index);
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
      },
    );
  }
}
