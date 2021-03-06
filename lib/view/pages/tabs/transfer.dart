import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xendly_mobile/view/pages/tabs/transfer_tabs/favourites.dart';
import 'package:xendly_mobile/view/pages/tabs/transfer_tabs/recipients.dart';
import 'package:xendly_mobile/view/shared/colors.dart';
import 'package:xendly_mobile/view/shared/widgets.dart';
import 'package:xendly_mobile/view/shared/widgets/text_input.dart';

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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                  ),
                  child: pageLabel("Select a Recipient", context),
                ),
                const SizedBox(height: 34),
                Autocomplete<User>(
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
                          style: const TextStyle(
                            color: XMColors.primary,
                            fontSize: 16,
                          ),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: "Search by Product, Brand or Vendor",
                            hintStyle: const TextStyle(
                              color: Color(0XFF9AA4BC),
                              fontSize: 14,
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
                                      "assets/icons/notification.svg",
                                      color: XMColors.primary,
                                      height: 22,
                                      width: 22,
                                      semanticsLabel: "search icon",
                                    )),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 22,
                              vertical: 20,
                            ),
                            filled: true,
                            fillColor: Colors.transparent,
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: XMColors.primary,
                                width: 1.2,
                              ),
                              borderRadius: BorderRadius.circular(14.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                                width: 1.2,
                              ),
                              borderRadius: BorderRadius.circular(14.0),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  onSelected: (User selection) {
                    print('Selected: ${selection.name}');
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
                const SizedBox(height: 10),
                // tab bar
                TabBar(
                  tabs: myTabs,
                  controller: _tabController,
                  indicatorColor: XMColors.primary,
                  unselectedLabelColor: XMColors.lightGray,
                  labelColor: XMColors.primary,
                  labelStyle: const TextStyle(
                    fontFamily: "TTFirsNeue",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  onTap: (index) {
                    print(index);
                    setState(() {
                      _selectedTabBar = index;
                    });
                  },
                ),
                Builder(
                  builder: (context) {
                    if (_selectedTabBar == 0) {
                      return const RecipientsTab();
                    } else {
                      return const FavourtitesTab();
                    }
                  },
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
