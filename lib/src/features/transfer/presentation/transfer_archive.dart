import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:xendly_mobile/src/core/utilities/helpers/currency_formatter.dart';
import 'package:xendly_mobile/src/core/utilities/helpers/validator_helper.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/iconsax_icons.dart';
import 'package:xendly_mobile/src/domain/usecases/beneficiaries/get_beneficiaries_usecase.dart';
import 'package:xendly_mobile/src/domain/usecases/misc/get_rate_usecase.dart';
import 'package:xendly_mobile/src/domain/usecases/user/get_user_data_usecase.dart';
import 'package:xendly_mobile/src/domain/usecases/wallets/get_user_wallets_usecase.dart';
import 'package:xendly_mobile/src/domain/usecases/wallets/p2p_transfer_usecase.dart';
import 'package:xendly_mobile/src/presentation/view_model/beneficiaries/get_beneficiaries_controller.dart';
import 'package:xendly_mobile/src/presentation/view_model/misc/get_rate_controller.dart';
import 'package:xendly_mobile/src/presentation/view_model/user/get_user_data_controller.dart';
import 'package:xendly_mobile/src/presentation/view_model/wallets/get_user_wallets_controller.dart';
import 'package:xendly_mobile/src/presentation/view_model/wallets/p2p_transfer_controller.dart';
import 'package:xendly_mobile/src/presentation/widgets/buttons/solid_button.dart';
import 'package:xendly_mobile/src/presentation/widgets/inputs/xn_text_field.dart';
import 'package:xendly_mobile/src/presentation/widgets/list_items/list_item_one.dart';

import 'package:xendly_mobile/src/presentation/widgets/dialogs/alert_dialog.dart';
import 'package:xendly_mobile/src/presentation/widgets/dual_texts.dart';
import 'package:xendly_mobile/src/presentation/widgets/new_title_bar.dart';
import 'package:xendly_mobile/src/presentation/widgets/notifications/snackbar.dart';

class SendMoney extends StatefulWidget {
  const SendMoney({Key? key}) : super(key: key);
  @override
  State<SendMoney> createState() => _SendMoneyState();
}

class _SendMoneyState extends State<SendMoney> {
  // handling conversion rates
  final RateController rateController = Get.put(
    RateController(Get.find<RateUsecase>()),
  );

  dynamic rateData;
  dynamic rate = 0;

  void fetchRates(String from, String to) async {
    try {
      await rateController.getRate(from, to);
      setState(() {
        rateData = rateController.data;
        rate = rateData['rate'];
      });
    } catch (err) {
      debugPrint("error caught on rates - ${err.toString()}");
    }
  }

  final GetUserWalletsController getUserWalletsController = Get.put(
    GetUserWalletsController(
      Get.find<GetUserWalletsUseCase>(),
    ),
  );

  final GetUserDataController getUserDataController = Get.put(
    GetUserDataController(
      Get.find<GetUserDataUsecase>(),
    ),
  );

  final P2PTransferController p2pTransferController = Get.put(
    P2PTransferController(
      Get.find<P2PTransferUsecase>(),
    ),
  );

  // getx controller for fetching beneficiaries
  final GetBeneficiariesController beneficiaries = Get.put(
    GetBeneficiariesController(
      Get.find<GetBeneficiariesUsecase>(),
    ),
  );

  List beneficiariesList = [];
  bool isLoading = true;

  void fetchBeneficiaries() async {
    try {
      await beneficiaries.getBeneficiaries();
      final result = beneficiaries.data;
      setState(() {
        beneficiariesList = result;
        isLoading = false;
      });
    } catch (err) {
      setState(() => isLoading = false);
      debugPrint("error caught on rates - ${err.toString()}");
    }
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>(debugLabel: "send_money");
  GlobalKey<FormState> checkUsernameKey =
  GlobalKey<FormState>(debugLabel: "check_username");
  final TextEditingController amountController = TextEditingController();
  var f = NumberFormat("###,###", "en_US");

  final formatCurrency = NumberFormat.currency();
  String? selectedWallet;
  List userWallets = [];
  void fetchUserWallets() async {
    await getUserWalletsController.getUserWallets();
    setState(() => userWallets = getUserWalletsController.data);
  }

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController remarkController = TextEditingController();

  List userData = [];

  void fetchUserData() async {
    if (usernameController.text.isNotEmpty) {
      checkUsernameKey.currentState!.save();

      await getUserDataController.getUserData(
        usernameController.text.toLowerCase(),
      );
      beneficiaryId = getUserDataController.beneficiaryId.value;
      data['beneficiary'] = beneficiaryId;
      data['save_beneficiary'] = saveBeneficiary;

      try {
        if (getUserDataController.message.value !=
            "Account was not found in our records") {
          confirmTransaction();
        }
      } catch (err) {
        xnSnack(
          "Invalid!",
          err.toString(),
          XMColors.error1,
          Iconsax.info_circle,
        );
      }
    } else {
      xnSnack(
        "Invalid!",
        "Please provide a recipient's username",
        XMColors.error1,
        Iconsax.info_circle,
      );
    }
  }

  void initiateTransfer() async {
    try {
      await p2pTransferController.p2pTransfer(data);
      // p2pTransferController.retStatus == false
      //     ? transactionResponse("Failed", XMColors.error1)
      //     : transactionResponse("Successful", XMColors.success1);
    } catch (err) {
      Get.snackbar(
        "Error confirm",
        err.toString(),
      );
    }
  }

  String? beneficiaryId;
  bool? saveBeneficiary;

  Map<String, dynamic> data = {
    "amount": "",
    "beneficiary": "",
    "remark": "",
    "currency": "",
    "save_beneficiary": "",
  };

  void _submit() async {
    if (GetUtils.isNullOrBlank(amountController.text)!) {
      alertDialog(
        context,
        Iconsax.info_circle,
        "Invalid Amount",
        "Please provide a valid amount",
            () => Navigator.pop(context),
        XMColors.error0,
      );
    } else {
      final isValid = formKey.currentState!.validate();
      if (isValid) {
        formKey.currentState!.save();
        try {
          provideUsername();
        } catch (error) {
          Get.snackbar("Error", "Unknown Error Occured, Try Again!");
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    amountController;
    usernameController;
    remarkController;
    fetchUserWallets();
    fetchBeneficiaries();
    selectedWallet = "NGN";
  }

  @override
  void dispose() {
    super.dispose();
    amountController.dispose();
    usernameController.dispose();
    remarkController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    selectedWallet == "NGN"
        ? fetchRates("NGN", "USD")
        : fetchRates("USD", "NGN");

    const divider = Divider(
      thickness: 1,
      height: 38,
      color: XMColors.gray_70,
    );

    const border = BorderSide(
      color: XMColors.none,
      width: 0,
    );

    return Scaffold(
      backgroundColor: XMColors.shade6,
      extendBody: true,
      appBar: const NewTitleBar(
        title: "Transfer",
        suffix: Icon(
          Icons.swap_vertical_circle_rounded,
          size: 26,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 26,
        ),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(12),
                  FilteringTextInputFormatter.digitsOnly,
                  CurrencyInputFormatter(),
                ],
                controller: amountController,
                onSaved: (value) {
                  data["amount"] = value?.replaceAll(',', '');
                  data["currency"] = selectedWallet!;
                },
                style: textTheme.headlineLarge!.copyWith(
                  color: XMColors.shade0,
                  fontWeight: FontWeight.w600,
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(0),
                  isDense: true,
                  hintText: "0 $selectedWallet",
                  hintStyle: textTheme.headlineLarge?.copyWith(
                    color: XMColors.shade3,
                    fontWeight: FontWeight.w600,
                  ),
                  focusedBorder: const OutlineInputBorder(borderSide: border),
                  enabledBorder: const OutlineInputBorder(borderSide: border),
                  border: const OutlineInputBorder(borderSide: border),
                ),
              ),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () => showUserWallets(),
                child: Chip(
                  backgroundColor: XMColors.shade4,
                  label: Padding(
                    padding: const EdgeInsets.only(left: 2),
                    child: Wrap(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 1),
                          child: Text(
                            selectedWallet!,
                            style: textTheme.bodyMedium?.copyWith(
                              color: XMColors.shade0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Padding(
                          padding: EdgeInsets.only(top: 1),
                          child: Icon(
                            Iconsax.arrow_down_1,
                            color: XMColors.shade0,
                            size: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 82),
              const DualTexts(
                title: "Transfer Speed",
                value: "Instant",
              ),
              divider,
              Text(
                "Please not that the exchange rate is subject based on current market condition and trends.",
                textAlign: TextAlign.center,
                style: textTheme.bodyText1?.copyWith(
                  color: XMColors.shade3,
                ),
              ),
              const SizedBox(height: 30),
              XnSolidButton(
                content: Text(
                  "Continue",
                  style: textTheme.bodyLarge?.copyWith(
                    color: XMColors.shade6,
                  ),
                ),
                backgroundColor: XMColors.primary,
                action: () => showOptions(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // modal for transfers
  showOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(18, 22, 12, 22),
              color: XMColors.shade6,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Container(
                    height: 6,
                    width: 86,
                    decoration: BoxDecoration(
                      color: XMColors.shade4,
                      borderRadius: BorderRadius.circular(26),
                    ),
                  ),
                  const SizedBox(height: 18),
                  ListItemOne(
                    title: "Manual Transfer",
                    subtitle: "Send to any Xendly account",
                    iconOne: Iconsax.add,
                    iconTwo: Icons.arrow_forward_ios,
                    action: () {
                      Get.back();
                      _submit();
                    },
                  ),
                  ListItemOne(
                    title: "Beneficiary Transfer",
                    subtitle: "Instant transfer to someone",
                    iconOne: Iconsax.add,
                    iconTwo: Icons.arrow_forward_ios,
                    action: () {
                      Get.back();
                      selectBeneficiary();
                    },
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  showUserWallets() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(4, 32, 4, 22),
              color: XMColors.shade6,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Text(
                    "Virtual Wallets",
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 18),
                  for (var wallet in userWallets)
                    ListTile(
                      onTap: () {
                        setState(() =>
                        selectedWallet = wallet["currency"].toString());
                        Navigator.pop(context);
                      },
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
                            : "United States Dollars",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          wallet["currency"],
                          style:
                          Theme.of(context).textTheme.bodyText2!.copyWith(
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
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: XMColors.shade0,
                        ),
                      ),
                    ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  // >>> Show modal for funding <<< //
  showSendMoneyMethods() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(4, 22, 4, 22),
              color: XMColors.shade6,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Container(
                    height: 6,
                    width: 86,
                    decoration: BoxDecoration(
                      color: XMColors.shade4,
                      borderRadius: BorderRadius.circular(26),
                    ),
                  ),
                  const SizedBox(height: 18),
                  ListItemOne(
                    title: "Mono, Grey, Mpesa, Revolut",
                    subtitle: "Initiate a top up for your account",
                    iconOne: Iconsax.add,
                    iconTwo: Iconsax.arrow_right_3,
                    action: () {
                      Get.back();
                      showVirtualAccounts();
                    },
                  ),
                  ListItemOne(
                    title: "Mastercard, Visa, Verve",
                    subtitle: "Initiate a top up for your account",
                    iconOne: Iconsax.add,
                    iconTwo: Iconsax.arrow_right_3,
                    action: () {
                      Get.back();
                    },
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  // widget to show the list
  Widget showBeneficiaries() {
    if (isLoading == true) {
      return const CircularProgressIndicator();
    } else if (beneficiariesList.isEmpty) {
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

  // show a list of all the beneficiaries
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
                        "Select a Beneficiary",
                        style: textTheme.headline6?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: const Icon(
                          Icons.close,
                          size: 24,
                          color: XMColors.shade0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 46),
                  showBeneficiaries(),
                ],
              ),
            ),
          ),
        );

        // return Scaffold(
        //   body: Container(
        //     height: screenSize.height,
        //     width: screenSize.width,
        //     color: XMColors.shade6,
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         Padding(
        //           padding: const EdgeInsets.fromLTRB(22, 24, 22, 20),
        //           child: Column(
        //             children: [
        //               Row(
        //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                 children: [
        //                   Text(
        //                     "Select a Beneficiary",
        //                     style: textTheme.headline6?.copyWith(
        //                       fontWeight: FontWeight.w600,
        //                     ),
        //                   ),
        //                   GestureDetector(
        //                     onTap: () => Get.back(),
        //                     child: const Icon(
        //                       Icons.close,
        //                       size: 24,
        //                       color: XMColors.shade0,
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ],
        //           ),
        //         ),
        //         Expanded(
        //           child: ListView.builder(
        //             physics: const BouncingScrollPhysics(),
        //             itemCount: 12,
        //             itemBuilder: (context, index) {
        //               return Padding(
        //                 padding: const EdgeInsets.symmetric(horizontal: 6),
        //                 child: ListItemOne(
        //                   title: "Shittu Hakeem",
        //                   subtitle: "+234 902 324 9586",
        //                   iconOne: Iconsax.add,
        //                   iconTwo: Iconsax.trash,
        //                   action: () {
        //                     Get.back();
        //                     confirmTransaction();
        //                   },
        //                 ),
        //               );
        //             },
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // );
      },
    );
  }

  // provide recipient's username //
  provideUsername() {
    final screenSize = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    saveBeneficiary = false;

    debugPrint("beneficiary stat - ${saveBeneficiary.toString()}");

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, StateSetter setState) {
          return Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Form(
              key: checkUsernameKey,
              child: Wrap(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 22,
                    ),
                    color: XMColors.shade6,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 6,
                          width: 86,
                          decoration: BoxDecoration(
                            color: XMColors.shade4,
                            borderRadius: BorderRadius.circular(26),
                          ),
                        ),
                        const SizedBox(height: 32),
                        XnTextField(
                          label: "Recipient's username",
                          keyboardType: TextInputType.name,
                          controller: usernameController,
                          validator: (value) => validateUsername(value!),
                          icon: Iconsax.user,
                          iconColor: XMColors.shade2,
                        ),
                        const SizedBox(height: 24),
                        XnTextField(
                          label: "Description",
                          keyboardType: TextInputType.text,
                          controller: remarkController,
                          onSaved: (value) {
                            setState(() => data["remark"] = value!);
                            debugPrint("remark content - ${data['remark']}");
                          },
                          icon: Iconsax.note,
                          iconColor: XMColors.shade2,
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Save as Beneficiary",
                              style: textTheme.bodyText1,
                            ),
                            Switch(
                              onChanged: (value) {
                                setState(() => saveBeneficiary = value);
                              },
                              value: saveBeneficiary ?? false,
                              activeColor: XMColors.primary0,
                              activeTrackColor: XMColors.primary1,
                              inactiveThumbColor: XMColors.shade3,
                              inactiveTrackColor: XMColors.shade1,
                            )
                          ],
                        ),
                        const SizedBox(height: 24),
                        XnSolidButton(
                          content: Obx(
                                () {
                              return getUserDataController.isLoading.value
                                  ? const CupertinoActivityIndicator()
                                  : Text(
                                "Continue",
                                style: textTheme.bodyText1?.copyWith(
                                  color: XMColors.shade6,
                                  fontWeight: FontWeight.w500,
                                ),
                              );
                            },
                          ),
                          backgroundColor: XMColors.primary,
                          action: () {
                            Get.back();
                            fetchUserData();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  // >>> manage beneficiaries <<< //
  confirmTransaction() {
    final screenSize = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 22,
              ),
              color: XMColors.shade6,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 6,
                    width: 86,
                    decoration: BoxDecoration(
                      color: XMColors.shade4,
                      borderRadius: BorderRadius.circular(26),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    "You are sending",
                    style: textTheme.bodyText1?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    // "\$10.00",
                    "$selectedWallet${amountController.text}",
                    style: textTheme.headline3?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "to Opadotun Olushola",
                    style: textTheme.bodyText2?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: XMColors.shade4,
                    ),
                  ),
                  // const SizedBox(height: 12),
                  // const Divider(),
                  // const SizedBox(height: 12),
                  // Text(
                  //   "They'll receive",
                  //   style: textTheme.bodyText1?.copyWith(
                  //     fontWeight: FontWeight.w600,
                  //   ),
                  // ),
                  // const SizedBox(height: 8),
                  // Text(
                  //   "\$9.50",
                  //   style: textTheme.headline3?.copyWith(
                  //     fontWeight: FontWeight.w700,
                  //   ),
                  // ),
                  const SizedBox(height: 20),
                  XnSolidButton(
                    content: Text(
                      "Confirm Transfer",
                      style: textTheme.bodyText1?.copyWith(
                        color: XMColors.shade6,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    backgroundColor: XMColors.primary,
                    action: () {
                      Get.back();
                      initiateTransfer();
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  // >>> transaction successful <<< //
  transactionResponse(
      String title,
      Color color,
      ) {
    final screenSize = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 22,
              ),
              color: XMColors.shade6,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 6,
                    width: 86,
                    decoration: BoxDecoration(
                      color: XMColors.shade4,
                      borderRadius: BorderRadius.circular(26),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    title,
                    style: textTheme.bodyText1?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    selectedWallet == "NGN"
                        ? "NGN${amountController.text}"
                        : "USD${amountController.text}",
                    style: textTheme.headline3?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Jan 15th, 2023 07:54 PM",
                    style: textTheme.bodyText2?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: XMColors.shade4,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Divider(),
                  const SizedBox(height: 12),
                  Text(
                    "Transaction Ref",
                    style: textTheme.bodyText2?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "090267230114093745638720884768129104",
                    style: textTheme.bodyText2?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: XMColors.shade4,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Divider(),
                  const SizedBox(height: 12),
                  Text(
                    "Status",
                    style: textTheme.bodyText2?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Chip(
                  //   label: Text(
                  //     "Completed",
                  //     style: textTheme.bodyText2?.copyWith(
                  //       fontWeight: FontWeight.w600,
                  //       color: XMColors.shade6,
                  //     ),
                  //   ),
                  //   backgroundColor: XMColors.success1,
                  // ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  // >>> select a virtual account <<< //
  showVirtualAccounts() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(4, 32, 4, 22),
              color: XMColors.shade6,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Text(
                    "Virtual Accounts",
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 18),
                  ListItemOne(
                    title: "Steve McConnell",
                    subtitle: "2385639071, Mono",
                    iconOne: Iconsax.add,
                    iconTwo: Iconsax.arrow_right_3,
                    action: () {
                      Get.back();
                    },
                  ),
                  ListItemOne(
                    title: "Steve McConnell",
                    subtitle: "4607851352, Grey",
                    iconOne: Iconsax.add,
                    iconTwo: Iconsax.arrow_right_3,
                    action: () {
                      Get.back();
                    },
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
