import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/iconsax_icons.dart';
import 'package:xendly_mobile/src/presentation/widgets/inputs/xn_text_field.dart';

import '../../../config/routes.dart' as routes;
import '../../../core/utilities/widgets/wallets_list.dart';
import '../../../domain/usecases/beneficiaries/get_beneficiaries_usecase.dart';
import '../../../domain/usecases/user/get_user_data_usecase.dart';
import '../../../domain/usecases/wallets/get_user_wallets_usecase.dart';
import '../../../presentation/view_model/beneficiaries/get_beneficiaries_controller.dart';
import '../../../presentation/view_model/user/get_user_data_controller.dart';
import '../../../presentation/view_model/wallets/get_user_wallets_controller.dart';
import '../../../presentation/widgets/dialogs/alert_dialog.dart';
import '../../../presentation/widgets/list_items/list_item_one.dart';
import '../../../presentation/widgets/title_bar.dart';

class TransferDetails extends StatefulWidget {
  const TransferDetails({Key? key}) : super(key: key);
  @override
  State<TransferDetails> createState() => _TransferDetailsState();
}

class _TransferDetailsState extends State<TransferDetails> {
  TextEditingController amountController = TextEditingController();
  TextEditingController narrationController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  String? beneficiaryId, fullName;
  bool saveBeneficiary = false;
  final ValueNotifier<String?> currencyNotifier = ValueNotifier("");

  final GetUserWalletsController getUserWalletsController = Get.put(
    GetUserWalletsController(
      Get.find<GetUserWalletsUseCase>(),
    ),
  );

  final GetBeneficiariesController beneficiaries = Get.put(
    GetBeneficiariesController(
      Get.find<GetBeneficiariesUsecase>(),
    ),
  );

  final formatCurrency = NumberFormat.currency();
  String? selectedWallet;
  List userWallets = [];

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
        setState(() {
          beneficiaryId = controller.beneficiaryId.value;
          fullName = controller.fullName.value;
        });
      } catch (err) {
        print(err.toString());
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getWallets();
    beneficiaries.getBeneficiaries();
    selectedWallet = "NGN";
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
              children: [
                const TitleBar(
                  title: "Transfer Details",
                ),
                const SizedBox(height: 46),
                GestureDetector(
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
                ),
                const SizedBox(height: 24),
                GestureDetector(
                  onTap: () => showWallets(),
                  child: ValueListenableBuilder(
                    valueListenable: currencyNotifier,
                    builder: (context, value, _) {
                      return XnTextField(
                        label: selectedWallet ?? "Balance to send from",
                        keyboardType: TextInputType.number,
                        enabled: false,
                        readOnly: true,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),
                XnTextField(
                  label: "Username of recipient",
                  controller: usernameController,
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 24),
                GestureDetector(
                  onTap: () => _getRecipientInfo(),
                  child: XnTextField(
                    label: fullName ?? "Get recipient's name",
                    enabled: false,
                    readOnly: true,
                    filled: true,
                  ),
                ),
                const SizedBox(height: 24),
                XnTextField(
                  label: "Amount to send",
                  controller: amountController,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 24),
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
                      value: saveBeneficiary ?? false,
                      activeColor: XMColors.success1,
                      activeTrackColor: XMColors.success1,
                      inactiveThumbColor: XMColors.shade3,
                      inactiveTrackColor: XMColors.shade1,
                    )
                  ],
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => Get.toNamed(
                    routes.confirmTransfer,
                    parameters: {
                      "username": usernameController.text,
                      "full_name": fullName!,
                      "beneficiary": beneficiaryId!,
                      "amount": amountController.text,
                      "narration": narrationController.text,
                      "save_beneficiary": saveBeneficiary.toString(),
                      "currency": selectedWallet!,
                    },
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.only(bottom: 2),
                    fixedSize: const Size(0, 64),
                  ),
                  child: Obx(() {
                    return userInfoController.isLoading.value
                        ? Text(
                            "Retrieving Recipient Info...",
                            style: textTheme.bodyLarge
                                ?.copyWith(color: XMColors.shade6),
                          )
                        : Text(
                            "Continue",
                            style: textTheme.bodyLarge
                                ?.copyWith(color: XMColors.shade6),
                          );
                  }),
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
                          : beneficiaries.data == []
                              ? const Text("No Beneficiaries")
                              : ListView.separated(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  separatorBuilder: (_, __) =>
                                      const SizedBox(height: 10),
                                  itemCount: beneficiaries.data.length,
                                  itemBuilder: (_, index) {
                                    final beneficiary =
                                        beneficiaries.data[index];
                                    return ListItemOne(
                                      title: beneficiary['display_name'],
                                      subtitle: beneficiary['beneficiary']
                                              ['phone']
                                          .toString(),
                                      iconOne: Icons.person_2_outlined,
                                      iconTwo: Iconsax.trash,
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
