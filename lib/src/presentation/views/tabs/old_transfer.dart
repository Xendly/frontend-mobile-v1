import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:xendly_mobile/src/core/utilities/interfaces/colors.dart';
import 'package:xendly_mobile/src/presentation/widgets/widgets.dart';
import 'package:xendly_mobile/src/presentation/widgets/bottomSheet.dart';
import 'package:xendly_mobile/src/presentation/widgets/dropdown_input.dart';
import 'package:xendly_mobile/src/presentation/widgets/solid_button.dart';
import 'package:xendly_mobile/src/presentation/widgets/tabPage_title.dart';
import 'package:xendly_mobile/src/presentation/widgets/text_input.dart';
import 'package:xendly_mobile/src/data/models/beneficiary_model.dart';
import 'package:xendly_mobile/src/data/models/country_model.dart';
import 'package:xendly_mobile/src/data/services/beneficiary_auth.dart';
import 'package:xendly_mobile/src/data/services/public_auth.dart';
import '../../../config/routes.dart' as routes;

class Transfer extends StatefulWidget {
  const Transfer({Key? key}) : super(key: key);
  @override
  State<Transfer> createState() => _TransferState();
}

class _TransferState extends State<Transfer> {
  final List<User> shoeOptions = const [
    User(
      name: 'Air Zoom Pegasus',
      phone: 130,
    ),
    User(
      name: 'Air Force 1 \'07',
      phone: 234123567890,
    ),
    User(
      name: 'Air VaporMax Plus',
      phone: 234123567890,
    ),
    User(
      name: 'KD 15',
      phone: 234123567890,
    ),
    User(
      name: 'Air Max 270',
      phone: 234123567890,
    ),
  ];

  bool _isSearchList = false;
  void _toggleSearch() {
    setState(
      () {
        if (_isSearchList) {
          _isSearchList = false;
        } else {
          _isSearchList = true;
        }
      },
    );
  }

  String searchString = "";
  bool _isLoading = true;

  late Future<List<CountryModel>> futureCountry;
  final _publicAuth = PublicAuth();
  CountryModel? countryCodeSelected;

  final _beneficiaryAuth = BeneficiaryAuth();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController? name = TextEditingController();
  TextEditingController? phoneNo = TextEditingController();
  TextEditingController? country = TextEditingController();

  BeneficiaryData? _bData;

  Map<String, dynamic> beneficiaryData = {
    "name": "",
    "phone": "",
    "country": "",
  };

  Map<String, dynamic> data = {
    "id": "",
  };

  // beneficiary
  late List<BeneficiaryData> _beneficiaries = [];

  @override
  void initState() {
    super.initState();
    name;
    phoneNo;
    country;
    if (_beneficiaries.isEmpty) {
      _loadBeneficiaries();
    }
    // _bData = Get.arguments as BeneficiaryData;
  }

  void _loadBeneficiaries() async {
    try {
      _beneficiaries = await BeneficiaryAuth().getBeneficiaries();
      setBusy(false);
    } catch (e) {
      setBusy(false);
    }
  }

  setBusy(bool value) {
    if (mounted) {
      setState(() {
        _isLoading = value;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  String? validateName(String value) {
    final regEx = RegExp(r'^[a-zA-Z- ]+$');
    if (GetUtils.isNullOrBlank(value)!) {
      return "Enter your First Name";
    } else if (!regEx.hasMatch(value)) {
      return "Provide a valid First Name";
    } else {
      return null;
    }
  }

  String? validateCountry(dynamic value) {
    if (GetUtils.isNullOrBlank(value)!) {
      return "Select your Country of Residence";
    } else {
      return null;
    }
  }

  String? validatePhone(String value) {
    if (GetUtils.isNullOrBlank(value)!) {
      return "Enter your Phone Number";
    } else if (!GetUtils.isNum(value)) {
      return "Provide a valid Phone Number";
    } else {
      return null;
    }
  }

  void addBeneficiary() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      printInfo(info: "some fields are invalid");
    } else {
      printInfo(info: "all fields are valid");
      formKey.currentState!.save();
      Navigator.pop(context);
      // showLoader(context);
      try {
        final result = await _beneficiaryAuth.addBeneficiary(beneficiaryData);
        if (result["status"] == 'Success' || result["statusCode"] == 201) {
          _loadBeneficiaries();
          Navigator.pop(context);
          printInfo(info: "${result["statusCode"]}");
          Get.snackbar(
            result["status"],
            result["message"],
            backgroundColor: Colors.green,
            colorText: XMColors.light,
            duration: const Duration(seconds: 5),
          );
          // Get.back();
        } else {
          Navigator.pop(context);
          printInfo(info: "${result["message"]}, ${result["statusCode"]}");
          if (result["message"] != null || result["status"] != "failed") {
            Get.closeAllSnackbars();
            printInfo(info: "${result["message"]}");
            Get.snackbar(
              result["status"].toString(),
              result["message"],
              backgroundColor: Colors.red,
              colorText: XMColors.light,
              duration: const Duration(seconds: 5),
            );
          } else {
            Get.closeAllSnackbars();
            Get.snackbar(
              result["status"].toString(),
              result["message"],
              backgroundColor: Colors.red,
              colorText: XMColors.light,
              duration: const Duration(seconds: 5),
            );
            Get.snackbar(
              result["status"],
              result["message"],
              backgroundColor: Colors.red,
              colorText: XMColors.light,
              duration: const Duration(seconds: 5),
            );
          }
        }
      } catch (error) {
        Navigator.pop(context);
        Get.snackbar("Error", "Unknown Error Occured, Try Again!");
        return printInfo(
          info: "Unknown Error Occured, Try Again!",
        );
      }
    }
  }

  void deleteBeneficiary(int beneficiaryID) async {
    // showLoader(context);
    try {
      // return;
      final result =
          await _beneficiaryAuth.deleteBeneficiary(beneficiaryID.toString());
      if (result["status"] == 'Success') {
        _loadBeneficiaries();
        printInfo(info: "${result["statusCode"]}");
        Get.snackbar(
          result["status"],
          result["message"],
          backgroundColor: Colors.green,
          colorText: XMColors.light,
          duration: const Duration(seconds: 5),
        );
        Get.back(closeOverlays: true);
      } else {
        Get.back(closeOverlays: true);
        printInfo(info: "${result["message"]}, ${result["statusCode"]}");
        if (result["message"] != null || result["status"] != "failed") {
          Get.closeAllSnackbars();
          printInfo(info: "${result["message"]}");
          Get.snackbar(
            result["status"].toString(),
            result["message"],
            backgroundColor: Colors.red,
            colorText: XMColors.light,
            duration: const Duration(seconds: 5),
          );
        } else {
          Get.closeAllSnackbars();
          Get.snackbar(
            result["status"].toString(),
            result["message"],
            backgroundColor: Colors.red,
            colorText: XMColors.light,
            duration: const Duration(seconds: 5),
          );
          Get.snackbar(
            result["status"],
            result["message"],
            backgroundColor: Colors.red,
            colorText: XMColors.light,
            duration: const Duration(seconds: 5),
          );
        }
      }
    } catch (error) {
      Get.back(closeOverlays: true);
      Get.snackbar("Error", "Unknown Error Occured, Try Again!");
      return printInfo(
        info: "Unknown Error Occured, Try Again!",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: XMColors.light,
      extendBody: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: TabPageTitle(
                    prefix: GestureDetector(
                      onTap: () => Navigator.pushNamed(
                        context,
                        routes.notifications,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            color: XMColors.dark,
                            width: 1.35,
                          ),
                        ),
                        padding: const EdgeInsets.all(6),
                        child: SvgPicture.asset(
                          "assets/icons/user.svg",
                          width: 22,
                          height: 22,
                          color: XMColors.primary,
                        ),
                      ),
                    ),
                    title: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        "Transfer Cash",
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ),
                    suffix: GestureDetector(
                      onTap: () => Navigator.pushNamed(
                        context,
                        routes.notifications,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            color: XMColors.dark,
                            width: 1.35,
                          ),
                        ),
                        padding: const EdgeInsets.all(6),
                        child: SvgPicture.asset(
                          "assets/icons/notification.svg",
                          width: 22,
                          height: 22,
                          color: XMColors.primary,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 34),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Autocomplete<User>(
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text.isEmpty) {
                        return [];
                      }
                      return shoeOptions
                          .where(
                            (User user) => user.name!.toLowerCase().startsWith(
                                  textEditingValue.text.toLowerCase(),
                                ),
                          )
                          .toList();
                    },
                    displayStringForOption: (User option) => option.name!,
                    fieldViewBuilder: (
                      BuildContext context,
                      TextEditingController fieldTextEditingController,
                      FocusNode fieldFocusNode,
                      VoidCallback onFieldSubmitted,
                    ) {
                      return FocusScope(
                        child: Focus(
                          onFocusChange: (focus) => _toggleSearch(),
                          child: TextFormField(
                            controller: fieldTextEditingController,
                            focusNode: fieldFocusNode,
                            onChanged: (value) {
                              setState(
                                () => {
                                  searchString = value.toLowerCase(),
                                },
                              );
                            },
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: XMColors.dark,
                                    ),
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: "Search Contacts",
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: XMColors.gray_50,
                                  ),
                              isDense: true,
                              suffixIconConstraints: const BoxConstraints(
                                minWidth: 22.5,
                                minHeight: 22.5,
                              ),
                              suffixIcon: Container(
                                padding: const EdgeInsets.only(right: 18),
                                child: (_isSearchList
                                    ? GestureDetector(
                                        onTap: () {
                                          FocusScopeNode currentFocus =
                                              FocusScope.of(context);
                                          if (!currentFocus.hasPrimaryFocus) {
                                            currentFocus.unfocus();
                                          }
                                        },
                                        child: strongBody(
                                            "Cancel", XMColors.primary),
                                      )
                                    : SvgPicture.asset(
                                        "assets/icons/search.svg",
                                        color: XMColors.gray_50,
                                        height: 22,
                                        width: 22,
                                        semanticsLabel: "search icon",
                                      )),
                              ),
                              contentPadding:
                                  const EdgeInsets.fromLTRB(22, 20, 22, 20),
                              filled: true,
                              fillColor: Colors.transparent,
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: XMColors.primary,
                                  width: 1.2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: XMColors.gray_70,
                                  width: 1.2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    onSelected: (User selection) {
                      log('Selected: ${selection.name}');
                    },
                    optionsViewBuilder: (
                      BuildContext context,
                      AutocompleteOnSelected<User> onSelected,
                      Iterable<User> options,
                    ) {
                      return Align(
                        alignment: Alignment.topLeft,
                        child: Material(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            color: XMColors.primary,
                            child: ListView.builder(
                              padding: const EdgeInsets.all(10.0),
                              itemCount: options.length,
                              itemBuilder: (BuildContext context, int index) {
                                final User option = options.elementAt(index);
                                return GestureDetector(
                                  onTap: () {
                                    onSelected(option);
                                  },
                                  child: ListTile(
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 0,
                                    ),
                                    // leading: ClipRRect(
                                    //   borderRadius: BorderRadius.circular(8.0),
                                    //   child: Image.network(
                                    //     option.image!,
                                    //     fit: BoxFit.cover,
                                    //     width: 42,
                                    //     height: 42,
                                    //   ),
                                    // ),
                                    title: strongBody(
                                      option.name!,
                                      XMColors.primary,
                                      FontWeight.w500,
                                    ),
                                    subtitle: strongCaption(
                                      '\$${option.phone}',
                                      XMColors.primary,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                // tab bar
                // TabBar(
                //   tabs: myTabs,
                //   controller: _tabController,
                //   indicatorColor: XMColors.primary,
                //   unselectedLabelColor: XMColors.lightGray,
                //   labelColor: XMColors.primary,
                //   labelStyle: const TextStyle(
                //     fontFamily: "TTFirsNeue",
                //     fontSize: 16,
                //     fontWeight: FontWeight.w600,
                //   ),
                //   onTap: (index) {
                //     print(index);
                //     setState(() {
                //       _selectedTabBar = index;
                //     });
                //   },
                // ),
                // Builder(
                //   builder: (context) {
                //     if (_selectedTabBar == 0) {
                //       return const RecipientsTab();
                //     } else {
                //       return const FavourtitesTab();
                //     }
                //   },
                // ),
                const SizedBox(height: 24),
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 50,
                                horizontal: 22,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  GestureDetector(
                                    child: Text(
                                      "Add from Contacts",
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const Divider(),
                                  const SizedBox(height: 14),
                                  GestureDetector(
                                    onTap: () => {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Wrap(
                                            crossAxisAlignment:
                                                WrapCrossAlignment.center,
                                            alignment: WrapAlignment.center,
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 12,
                                                  vertical: 38,
                                                ),
                                                color: XMColors.light,
                                                child: Form(
                                                  key: formKey,
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        "Enter the Beneficiary Details",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .subtitle1!
                                                            .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                      ),
                                                      const SizedBox(height: 8),
                                                      Text(
                                                        "Enter beneficiary's details to add to your list",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1!
                                                            .copyWith(
                                                              color:
                                                                  XMColors.gray,
                                                            ),
                                                      ),
                                                      const SizedBox(
                                                          height: 24),
                                                      // TextInput(
                                                      //   label: "Date of Birth",
                                                      //   hintText:
                                                      //       "30th June 2022",
                                                      //   borderRadius:
                                                      //       BorderRadius.circular(
                                                      //           10),
                                                      //   controller: dobController,
                                                      //   readOnly: true,
                                                      //   onTap: () async {
                                                      //     DateTime? pickDob =
                                                      //         await showDatePicker(
                                                      //       context: context,
                                                      //       initialDate:
                                                      //           DateTime.now(),
                                                      //       firstDate: DateTime(
                                                      //         2000,
                                                      //       ),
                                                      //       lastDate:
                                                      //           DateTime(2101),
                                                      //     );

                                                      //     if (pickDob != null) {
                                                      //       String formattedDate =
                                                      //           DateFormat(
                                                      //                   'yyyy-MM-dd')
                                                      //               .format(
                                                      //                   pickDob);
                                                      //       setState(
                                                      //         () {
                                                      //           dobController
                                                      //                   .text =
                                                      //               formattedDate;
                                                      //         },
                                                      //       );
                                                      //     } else {
                                                      //       return null;
                                                      //     }
                                                      //   },
                                                      //   onSaved: (value) =>
                                                      //       data["dob"] = value!,
                                                      //   validator: (value) {
                                                      //     return validateDob(
                                                      //         value!);
                                                      //   },
                                                      // ),
                                                      const SizedBox(
                                                          height: 25),
                                                      TextInput(
                                                        readOnly: false,
                                                        label:
                                                            "Beneficiary Name",
                                                        hintText: "John Wick",
                                                        inputType:
                                                            TextInputType.name,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        controller: name,
                                                        onSaved: (value) =>
                                                            beneficiaryData[
                                                                    "name"] =
                                                                value!,
                                                        validator: (value) {
                                                          return validateName(
                                                            value!,
                                                          );
                                                        },
                                                      ),
                                                      const SizedBox(
                                                          height: 25),
                                                      FutureBuilder<
                                                          List<CountryModel>>(
                                                        future: futureCountry,
                                                        builder: (context,
                                                            snapshot) {
                                                          if (snapshot
                                                              .hasData) {
                                                            return DropdownInput<
                                                                CountryModel>(
                                                              label:
                                                                  "Country of Residence",
                                                              hintText:
                                                                  "Venezuela",
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              items: snapshot
                                                                  .data
                                                                  ?.map(
                                                                      (country) {
                                                                return DropdownMenuItem<
                                                                    CountryModel>(
                                                                  child: body(
                                                                    "(${country.dialCode}) ${country.country}",
                                                                    XMColors
                                                                        .primary,
                                                                    16,
                                                                  ),
                                                                  value:
                                                                      country,
                                                                );
                                                              }).toList(),
                                                              action:
                                                                  (CountryModel?
                                                                      value) {
                                                                setState(() {
                                                                  countryCodeSelected =
                                                                      value!;
                                                                });
                                                              },
                                                              onSaved: (value) =>
                                                                  beneficiaryData[
                                                                          "country"] =
                                                                      value?.country ??
                                                                          "",
                                                              validator:
                                                                  (value) {
                                                                return validateCountry(
                                                                    value);
                                                              },
                                                            );
                                                          } else if (snapshot
                                                              .hasError) {
                                                            return Text(
                                                                "${snapshot.error}");
                                                          }
                                                          return const Center(
                                                            child:
                                                                CupertinoActivityIndicator(),
                                                          );
                                                        },
                                                      ),
                                                      const SizedBox(
                                                          height: 25),
                                                      TextInput(
                                                        readOnly: false,
                                                        label: "Phone Number",
                                                        prefixIcon: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            left: 17,
                                                            right: 0,
                                                          ),
                                                          child: body(
                                                            "+${countryCodeSelected?.country ?? ''}",
                                                            XMColors.gray,
                                                            16,
                                                            TextAlign.center,
                                                            FontWeight.w500,
                                                          ),
                                                        ),
                                                        hintText: "9045637294",
                                                        inputType:
                                                            TextInputType.phone,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        controller: phoneNo,
                                                        onSaved: (value) {
                                                          printInfo(
                                                              info:
                                                                  value ?? '');
                                                          beneficiaryData[
                                                                  "phoneNo"] =
                                                              '+${countryCodeSelected!.dialCode! + value!}';
                                                        },
                                                        validator: (value) {
                                                          return validatePhone(
                                                              value!);
                                                        },
                                                      ),
                                                      // TextInput(
                                                      //   readOnly: false,
                                                      //   label: "Phone Number",
                                                      //   prefixIcon: Padding(
                                                      //     padding:
                                                      //         const EdgeInsets
                                                      //             .only(
                                                      //       left: 17,
                                                      //       right: 0,
                                                      //     ),
                                                      //     child: body(
                                                      //       "+${countrySelected?.dialCode ?? ''}",
                                                      //       XMColors.gray,
                                                      //       16,
                                                      //       TextAlign.center,
                                                      //       FontWeight.w500,
                                                      //     ),
                                                      //   ),
                                                      //   hintText: "9045637294",
                                                      //   inputType:
                                                      //       TextInputType.phone,
                                                      //   borderRadius:
                                                      //       BorderRadius.circular(
                                                      //           10),
                                                      //   controller:
                                                      //       phoneController,
                                                      //   onSaved: (value) {
                                                      //     printInfo(
                                                      //         info: value ?? '');
                                                      //     data["phoneNo"] =
                                                      //         '+${countrySelected!.dialCode! + value!}';
                                                      //   },
                                                      //   validator: (value) {
                                                      //     return validatePhone(
                                                      //         value!);
                                                      //   },
                                                      // ),
                                                      const SizedBox(
                                                          height: 50),
                                                      SolidButton(
                                                        text:
                                                            "Create Beneficiary",
                                                        textColor:
                                                            XMColors.light,
                                                        buttonColor:
                                                            XMColors.primary,
                                                        action: () {
                                                          addBeneficiary();
                                                        },
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    },
                                    child: Text(
                                      "Add Manually",
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Text(
                      "New Beneficiary +",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ),
                const SizedBox(height: 24.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "CONTACTS",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontWeight: FontWeight.w700,
                          color: XMColors.gray_50,
                          letterSpacing: 1.5,
                        ),
                  ),
                ),
                const SizedBox(height: 8),
                _isLoading
                    ? const Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 48.0),
                          child: SizedBox(
                            height: 50.0,
                            width: 50.0,
                            child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(
                              XMColors.primary,
                            )),
                          ),
                        ),
                      )
                    : _beneficiaries.isEmpty
                        ? Center(
                            child: Column(
                              children: [
                                const SizedBox(height: 16.0),
                                const Icon(
                                  FlutterRemix.user_5_line,
                                  size: 80.0,
                                ),
                                const SizedBox(height: 16.0),
                                Text(
                                  "No beneficiaries yet!",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: XMColors.primary,
                                      ),
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  "When you add them, they all appear here",
                                  style: TextStyle(
                                      color: XMColors.dark.withOpacity(.4),
                                      fontSize: 16.0),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _beneficiaries.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: const CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    "https://www.pngitem.com/pimgs/m/22-224351_avatar-user-icon-hd-png-download.png",
                                  ),
                                  radius: 30,
                                ),
                                horizontalTitleGap: 14,
                                title: Text(
                                  _beneficiaries[index].displayName!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 2),
                                  child: Text(
                                    _getPhoneNumber(
                                        _beneficiaries[index].phoneNo!),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: XMColors.gray_50,
                                        ),
                                  ),
                                ),
                                trailing: GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return CustomBottomSheet(
                                          child: Column(
                                            children: [
                                              Align(
                                                alignment: Alignment.topRight,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Get.back();
                                                  },
                                                  child: SvgPicture.asset(
                                                    "assets/icons/close-circle.svg",
                                                    width: 28,
                                                    height: 28,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 26,
                                              ),
                                              Text(
                                                "Remove this Beneficiary",
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1!
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                              ),
                                              const SizedBox(height: 12),
                                              Text(
                                                "Are you sure you'd like to remove this beneficiary?",
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(
                                                      color: XMColors.gray,
                                                    ),
                                              ),
                                              const SizedBox(height: 26),
                                              ElevatedButton(
                                                onPressed: () {
                                                  Get.back(closeOverlays: true);
                                                  deleteBeneficiary(
                                                    _beneficiaries[index].id,
                                                  );
                                                },
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                    XMColors.red,
                                                  ),
                                                ),
                                                child: Text(
                                                  "Delete Beneficiary",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .copyWith(
                                                        color: Colors.white,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: SvgPicture.asset(
                                    "assets/icons/more.svg",
                                  ),
                                ),
                                onTap: () {
                                  Get.toNamed(
                                    routes.sendMoney,
                                    arguments: _beneficiaries[index],
                                  );
                                },
                              );
                            },
                          ),

                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getPhoneNumber(String phoneNumber) {
    final String firstPart = phoneNumber.substring(0, 7);
    final String lastPart = phoneNumber.substring(phoneNumber.length - 2);
    return firstPart + ' ***** ' + lastPart;
  }
}

class User {
  const User({
    @required this.name,
    @required this.phone,
    @required this.image,
  });
  final String? name;
  final int? phone;
  final String? image;

  @override
  String toString() {
    return '$name ($phone)';
  }
}
