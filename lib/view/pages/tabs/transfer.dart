import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/dynamic_extensions.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:xendly_mobile/controller/core/beneficiary_auth.dart';
import 'package:xendly_mobile/controller/core/public_auth.dart';
import 'package:xendly_mobile/model/country_model.dart';
import 'package:xendly_mobile/view/pages/tabs/transfer_tabs/favourites.dart';
import 'package:xendly_mobile/view/pages/tabs/transfer_tabs/recipients.dart';
import 'package:xendly_mobile/view/shared/colors.dart';
import 'package:xendly_mobile/view/shared/widgets.dart';
import 'package:xendly_mobile/view/shared/widgets/dropdown_input.dart';
import 'package:xendly_mobile/view/shared/widgets/solid_button.dart';
import 'package:xendly_mobile/view/shared/widgets/tabPage_title.dart';
import 'package:xendly_mobile/view/shared/widgets/text_input.dart';
import 'package:xendly_mobile/view/shared/routes.dart' as routes;

class Transfer extends StatefulWidget {
  const Transfer({Key? key}) : super(key: key);
  @override
  State<Transfer> createState() => _TransferState();
}

class _TransferState extends State<Transfer>
    with SingleTickerProviderStateMixin {
  final List<User> shoeOptions = const [
    User(
      name: 'Air Zoom Pegasus',
      phone: 130,
      // image:
      //     'https://static.nike.com/a/images/t_PDP_1728_v1/f_auto,b_rgb:f5f5f5/b5d338dd-58b5-4134-8951-692c89477116/air-zoom-pegasus-39-mens-road-running-shoes-d4dvtm.png',
    ),
    User(
      name: 'Air Force 1 \'07',
      phone: 234123567890,
      // image:
      //     'https://static.nike.com/a/images/t_PDP_1728_v1/f_auto,b_rgb:f5f5f5/fc4622c4-2769-4665-aa6e-42c974a7705e/air-force-1-07-mens-shoes-5QFp5Z.png',
    ),
    User(
      name: 'Air VaporMax Plus',
      phone: 234123567890,
      // image:
      //     'https://static.nike.com/a/images/t_PDP_1728_v1/f_auto,b_rgb:f5f5f5/b5d338dd-58b5-4134-8951-692c89477116/air-zoom-pegasus-39-mens-road-running-shoes-d4dvtm.png',
    ),
    User(
      name: 'KD 15',
      phone: 234123567890,
      // image:
      //     'https://static.nike.com/a/images/t_PDP_1728_v1/f_auto,b_rgb:f5f5f5/b9ced701-5231-400f-a924-94240d83765e/kd15-basketball-shoes-6Kf3ck.png',
    ),
    User(
      name: 'Air Max 270',
      phone: 234123567890,
      // image:
      //     'https://static.nike.com/a/images/t_PDP_1728_v1/f_auto,b_rgb:f5f5f5/8f0d8f71-66ae-4ba1-8096-aa63ee44bdf3/air-max-270-mens-shoes-KkLcGR.png',
    ),
  ];

  // === tab bar stuff === //
  int _selectedTabBar = 0;
  late TabController _tabController;
  static const List<Tab> myTabs = <Tab>[
    Tab(
      text: 'Recipients',
    ),
    Tab(
      text: 'Favourites',
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

  late Future<List<CountryModel>> futureCountry;
  final _publicAuth = PublicAuth();
  CountryModel? countryCodeSelected;

  final _beneficiaryAuth = BeneficiaryAuth();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController? name = TextEditingController();
  TextEditingController? phoneNo = TextEditingController();
  TextEditingController? country = TextEditingController();

  Map<String, dynamic> beneficiaryData = {
    "name": "",
    "phone": "",
    "country": "",
  };

  @override
  void initState() {
    super.initState();
    futureCountry = _publicAuth.getCountry();
    _tabController = TabController(vsync: this, length: myTabs.length);
    name;
    phoneNo;
    country;
  }

  @override
  void dispose() {
    _tabController.dispose();
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
      try {
        final result = await _beneficiaryAuth.addBeneficiary(beneficiaryData);
        if (result["statusCode"] == 200) {
          printInfo(info: "${result["statusCode"]}");
          Get.snackbar(
            result["status"],
            result["message"],
            backgroundColor: Colors.green,
            colorText: XMColors.light,
            duration: const Duration(seconds: 5),
          );
          return Get.back();
        } else {
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
        Get.snackbar("Error", "Unknown Error Occured, Try Again!");
        return printInfo(
          info: "Unknown Error Occured, Try Again!",
        );
      }
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
                    title: Text(
                      "Send Cash",
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: XMColors.dark,
                          ),
                    ),
                    suffix: [
                      SvgPicture.asset(
                        "assets/icons/notification.svg",
                        width: 24,
                        height: 24,
                        color: XMColors.dark,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
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
                                      showMaterialModalBottomSheet(
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
                                                        text: "Create Account",
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
                const SizedBox(height: 26),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Text(
                    "RECENTS",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontWeight: FontWeight.w700,
                          color: XMColors.gray_50,
                          letterSpacing: 1.5,
                        ),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 100,
                  child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    scrollDirection: Axis.horizontal,
                    children: [
                      GestureDetector(
                        onTap: () =>
                            Navigator.pushNamed(context, routes.sendMoney),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const CircleAvatar(
                              backgroundColor: XMColors.primary,
                              backgroundImage: NetworkImage(
                                "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80",
                              ),
                              radius: 28,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "David",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 34),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
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
                ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: XMColors.primary,
                    backgroundImage: NetworkImage(
                      "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80",
                    ),
                    radius: 32,
                  ),
                  horizontalTitleGap: 10,
                  title: Text(
                    "David Bannerman",
                    style: Theme.of(context).textTheme.subtitle2!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 1),
                    child: Text(
                      "davebanner@xend.com",
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: XMColors.gray_50,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
