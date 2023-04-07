// /* == default files == */
// import 'dart:developer';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// /* == imported packages == */
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// /* == custom files == */
// import 'package:xendly_mobile/src/config/colors.dart';
// import 'package:xendly_mobile/src/config/utilities.dart';
// import 'package:xendly_mobile/src/core/utilities/interfaces/iconsax_icons.dart';
// import 'package:xendly_mobile/src/presentation/widgets/new_title_bar.dart';
// import 'package:xendly_mobile/src/presentation/widgets/transaction_list_item.dart';
// import 'package:xendly_mobile/src/data/models/transaction_model.dart';
// import 'package:xendly_mobile/src/data/models/wallet_model.dart';
// import 'package:xendly_mobile/src/data/services/transaction_service.dart';
// import 'package:xendly_mobile/src/data/services/wallet_auth.dart';
// import 'package:xendly_mobile/src/presentation/widgets/widgets.dart';
// import '../../../config/routes.dart' as routes;

// /* == wallets tab == */
// class Wallets extends StatefulWidget {
//   const Wallets({Key? key}) : super(key: key);
//   @override
//   State<Wallets> createState() => _WalletsState();
// }

// class _WalletsState extends State<Wallets> {
//   late PageController _pageController;
//   int currentWallet = 0;

//   // === General Variables === //
//   final formatCurrency = NumberFormat.currency();

//   // === User Wallets === //
//   late String _selectedWallet;

//   _userWallets() {
//     showModalBottomSheet(
//       context: context,
//       builder: (context) {
//         return Wrap(
//           children: [
//             Container(
//               padding: const EdgeInsets.fromLTRB(4, 32, 4, 22),
//               color: XMColors.shade6,
//               width: MediaQuery.of(context).size.width,
//               child: Column(
//                 children: [
//                   Text(
//                     "Virtual Wallets",
//                     style: Theme.of(context).textTheme.headline6?.copyWith(
//                           fontWeight: FontWeight.w700,
//                         ),
//                   ),
//                   const SizedBox(height: 18),
//                   for (var wallet in _userWallet)
//                     ListTile(
//                       onTap: () {
//                         setState(() {
//                           _selectedWallet = wallet.currency.toString();
//                         });

//                         Navigator.pop(context);
//                       },
//                       leading: CircleAvatar(
//                         backgroundImage: NetworkImage(
//                           wallet.currency == "NGN"
//                               ? "https://cdn.britannica.com/68/5068-004-72A3F250/Flag-Nigeria.jpg"
//                               : "https://upload.wikimedia.org/wikipedia/en/thumb/a/ae/Flag_of_the_United_Kingdom.svg/640px-Flag_of_the_United_Kingdom.svg.png",
//                         ),
//                         backgroundColor: XMColors.shade3,
//                       ),
//                       title: Text(
//                         wallet.currency == "NGN"
//                             ? "Nigerian Naira"
//                             : "United States Dollars",
//                         style: Theme.of(context).textTheme.bodyText1!.copyWith(
//                               fontWeight: FontWeight.w600,
//                             ),
//                       ),
//                       subtitle: Padding(
//                         padding: const EdgeInsets.only(top: 4),
//                         child: Text(
//                           wallet.currency!,
//                           style:
//                               Theme.of(context).textTheme.bodyText2!.copyWith(
//                                     fontWeight: FontWeight.w600,
//                                     color: XMColors.shade3,
//                                   ),
//                         ),
//                       ),
//                       trailing: Text(
//                         wallet.currency == "NGN"
//                             ? NumberFormat.currency(
//                                 locale: "en_NG",
//                                 symbol: "\u20A6",
//                               ).format(
//                                 double.parse(wallet.balance!),
//                               )
//                             : NumberFormat.currency(
//                                 locale: "en_US",
//                                 symbol: "\u0024",
//                               ).format(
//                                 double.parse(wallet.balance!),
//                               ),
//                         style: Theme.of(context).textTheme.bodyText1!.copyWith(
//                               fontWeight: FontWeight.w600,
//                               color: XMColors.shade0,
//                             ),
//                       ),
//                     ),
//                 ],
//               ),
//             )
//           ],
//         );
//       },
//     );
//   }

//   // === User Transactions === //
//   bool _isLoadingTransactions = true;
//   late List<Wallet> _userWallet = [];
//   late List<TransactionModel> _transactions = [];

//   @override
//   void initState() {
//     super.initState();
//     // === User Wallets === //
//     _selectedWallet = "NGN";

//     _pageController = PageController(
//       viewportFraction: 0.85,
//       initialPage: 0,
//     );

//     // if (_userWallet.isEmpty) {
//     //   _getData();
//     // }
//     // _loadTransactions();
//   }

//   @override
//   void dispose() {
//     // === User Wallets === //
//     _selectedWallet;

//     super.dispose();
//   }

//   // void _getData() async {
//   //   _userWallet = (await WalletAuth().getWallets());
//   //   Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
//   // }

//   // void _loadTransactions() async {
//   //   try {
//   //     _transactions = await TransactionService().getTransactionsSummary();
//   //     setState(() {
//   //       _isLoadingTransactions = false;
//   //     });
//   //   } catch (e) {
//   //     snackBar(
//   //       context,
//   //       'An error occured, please check your connection or try again',
//   //     );
//   //     setState(() {
//   //       _isLoadingTransactions = false;
//   //     });
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     final textTheme = Theme.of(context).textTheme;

//     return Scaffold(
//       backgroundColor: XMColors.shade6,
//       extendBody: true,
//       appBar: const TitleBar(),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               color: XMColors.shade6,
//               padding: const EdgeInsets.fromLTRB(18, 14, 18, 26),
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           _userWallet.isEmpty
//                               ? Text(
//                                   "0.00",
//                                   style: textTheme.headline2,
//                                 )
//                               : Text(
//                                   _selectedWallet == "NGN"
//                                       ? _userWallet[0].balance.toString()
//                                       : "\$${_userWallet[1].balance.toString()}",
//                                   style: textTheme.headline2,
//                                 ),
//                           const SizedBox(height: 3),
//                           Row(
//                             children: [
//                               const Icon(
//                                 Iconsax.eye_slash,
//                                 color: XMColors.shade3,
//                                 size: 18,
//                               ),
//                               const SizedBox(width: 6),
//                               Text(
//                                 // "United States Dollars",
//                                 _selectedWallet == "NGN"
//                                     ? "Nigerian Naira"
//                                     : "United States Dollars",
//                                 style: textTheme.bodyText1?.copyWith(
//                                   color: XMColors.shade3,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                       GestureDetector(
//                         onTap: () => _userWallets(),
//                         child: Chip(
//                           backgroundColor: XMColors.shade4,
//                           label: Padding(
//                             padding: const EdgeInsets.only(left: 2),
//                             child: Row(
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.only(top: 2),
//                                   child: Text(
//                                     _selectedWallet,
//                                     style: textTheme.bodyText2?.copyWith(
//                                       color: XMColors.shade0,
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(width: 4),
//                                 const Icon(
//                                   Iconsax.arrow_down_1,
//                                   color: XMColors.shade0,
//                                   size: 16,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 26),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: ElevatedButton(
//                           onPressed: () => Get.toNamed(
//                             routes.fundMethods,
//                             arguments: _userWallet[currentWallet],
//                           ),
//                           child: Text(
//                             "Add Funds",
//                             style: textTheme.bodyText1?.copyWith(
//                               color: XMColors.shade6,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 16),
//                       Expanded(
//                         child: OutlinedButton(
//                           onPressed: () {},
//                           child: Text(
//                             "Send Funds",
//                             style: textTheme.bodyText1?.copyWith(
//                               color: XMColors.primary0,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 10),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 18),
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         "TRANSACTIONS",
//                         style: textTheme.subtitle1?.copyWith(
//                           color: XMColors.shade3,
//                           fontWeight: FontWeight.w600,
//                           letterSpacing: 1.4,
//                         ),
//                       ),
//                       Container(
//                         margin: const EdgeInsets.only(top: 2),
//                         child: Text(
//                           "All Transactions",
//                           style: textTheme.bodyText1?.copyWith(
//                             color: XMColors.primary0,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 16),
//                   userTransactions(
//                     _isLoadingTransactions,
//                     _transactions,
//                     context,
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 22),
//           ],
//         ),
//       ),

//       // body: SafeArea(
//       //   child: SingleChildScrollView(
//       //     child: Column(
//       //       children: [
//       //         Column(
//       //           children: [
//       //             Padding(
//       //               padding: const EdgeInsets.fromLTRB(18, 24, 18, 24),
//       //               child: TabPageTitle(
//       //                 prefix: GestureDetector(
//       //                   onTap: () => Navigator.pushNamed(
//       //                     context,
//       //                     routes.notifications,
//       //                   ),
//       //                   child: Container(
//       //                     decoration: BoxDecoration(
//       //                       borderRadius: BorderRadius.circular(100),
//       //                       border: Border.all(
//       //                         color: XMColors.dark,
//       //                         width: 1.35,
//       //                       ),
//       //                     ),
//       //                     padding: const EdgeInsets.all(6),
//       //                     child: SvgPicture.asset(
//       //                       "assets/icons/user.svg",
//       //                       width: 22,
//       //                       height: 22,
//       //                       color: XMColors.primary,
//       //                     ),
//       //                   ),
//       //                 ),
//       //                 title: Padding(
//       //                   padding: const EdgeInsets.only(top: 4),
//       //                   child: Text(
//       //                     "My Wallets",
//       //                     style:
//       //                         Theme.of(context).textTheme.subtitle2!.copyWith(
//       //                               fontWeight: FontWeight.w700,
//       //                             ),
//       //                   ),
//       //                 ),
//       //                 suffix: GestureDetector(
//       //                   onTap: () => Navigator.pushNamed(
//       //                     context,
//       //                     routes.notifications,
//       //                   ),
//       //                   child: Container(
//       //                     decoration: BoxDecoration(
//       //                       borderRadius: BorderRadius.circular(100),
//       //                       border: Border.all(
//       //                         color: XMColors.dark,
//       //                         width: 1.35,
//       //                       ),
//       //                     ),
//       //                     padding: const EdgeInsets.all(6),
//       //                     child: SvgPicture.asset(
//       //                       "assets/icons/notification.svg",
//       //                       width: 22,
//       //                       height: 22,
//       //                       color: XMColors.primary,
//       //                     ),
//       //                   ),
//       //                 ),
//       //               ),
//       //             ),
//       //             const SizedBox(height: 10),
//       //             // wallet balance
//       //             SizedBox(
//       //               height: 100,
//       //               child: Align(
//       //                 alignment: Alignment.center,
//       //                 child: _userWallet.isEmpty
//       //                     ? const Center(
//       //                         child: CupertinoActivityIndicator(),
//       //                       )
//       //                     : PageView.builder(
//       //                         pageSnapping: true,
//       //                         scrollDirection: Axis.horizontal,
//       //                         controller: _pageController,
//       //                         physics: const BouncingScrollPhysics(),
//       //                         itemCount: _userWallet.length,
//       //                         onPageChanged: (page) {
//       //                           setState(() {
//       //                             currentWallet = page;
//       //                           });
//       //                         },
//       //                         itemBuilder: (context, index) {
//       //                           return GestureDetector(
//       //                             onTap: () => {
//       //                               Navigator.pushNamed(
//       //                                 context,
//       //                                 routes.walletDetails,
//       //                               )
//       //                             },
//       //                             child: WalletsItem(
//       //                               currency:
//       //                                   _userWallet[index].currency ?? 'GHX',
//       //                               balance:
//       //                                   _userWallet[index].balance.toString(),
//       //                             ),
//       //                           );
//       //                         },
//       //                       ),
//       //               ),
//       //             ),
//       //             SizedBox(
//       //               child: Row(
//       //                 mainAxisAlignment: MainAxisAlignment.center,
//       //                 children: List.generate(
//       //                   _userWallet.length,
//       //                   (index) => Padding(
//       //                     padding: const EdgeInsets.symmetric(horizontal: 5),
//       //                     child: buildDot(index, context),
//       //                   ),
//       //                 ),
//       //               ),
//       //             ),
//       //             const SizedBox(height: 2),
//       //             if (_userWallet.isNotEmpty)
//       //               Padding(
//       //                 padding: const EdgeInsets.symmetric(
//       //                   vertical: 32,
//       //                 ),
//       //                 child: Row(
//       //                   mainAxisAlignment: MainAxisAlignment.center,
//       //                   children: [
//       //                     GestureDetector(
//       //                       onTap: () => Get.toNamed(
//       //                         routes.fundMethods,
//       //                         arguments: _userWallet[currentWallet],
//       //                       ),
//       //                       child: Column(
//       //                         children: [
//       //                           Container(
//       //                             decoration: BoxDecoration(
//       //                               color: XMColors.primary_10,
//       //                               borderRadius: BorderRadius.circular(100),
//       //                             ),
//       //                             padding: const EdgeInsets.all(14),
//       //                             child: SvgPicture.asset(
//       //                               "assets/icons/add.svg",
//       //                               width: 30,
//       //                               height: 30,
//       //                               color: XMColors.light,
//       //                             ),
//       //                           ),
//       //                           const SizedBox(height: 14),
//       //                           Text(
//       //                             "Add Cash",
//       //                             style: Theme.of(context)
//       //                                 .textTheme
//       //                                 .bodyText1
//       //                                 ?.copyWith(
//       //                                   fontWeight: FontWeight.w600,
//       //                                 ),
//       //                           ),
//       //                         ],
//       //                       ),
//       //                     ),
//       //                     const SizedBox(width: 38),
//       //                     GestureDetector(
//       //                       onTap: () async {
//       //                         var data = await Get.toNamed(routes.exchangeCash,
//       //                             arguments: {
//       //                               'from_currency':
//       //                                   _userWallet[currentWallet].currency,
//       //                               'to_currency':
//       //                                   _userWallet[currentWallet].currency ==
//       //                                           'NGN'
//       //                                       ? 'USD'
//       //                                       : 'NGN',
//       //                             });
//       //                         if (data is bool && data) {
//       //                           _getData();
//       //                         }
//       //                       },
//       //                       child: Column(
//       //                         children: [
//       //                           Container(
//       //                             decoration: BoxDecoration(
//       //                               color: XMColors.primary_10,
//       //                               borderRadius: BorderRadius.circular(100),
//       //                             ),
//       //                             padding: const EdgeInsets.all(14),
//       //                             child: SvgPicture.asset(
//       //                               "assets/icons/convert.svg",
//       //                               width: 30,
//       //                               height: 30,
//       //                               color: XMColors.light,
//       //                             ),
//       //                           ),
//       //                           const SizedBox(height: 14),
//       //                           Text(
//       //                             "Exchange",
//       //                             style: Theme.of(context)
//       //                                 .textTheme
//       //                                 .bodyText1
//       //                                 ?.copyWith(
//       //                                   fontWeight: FontWeight.w600,
//       //                                 ),
//       //                           ),
//       //                         ],
//       //                       ),
//       //                     ),
//       //                     if (_userWallet[currentWallet].currency == 'NGN') ...[
//       //                       const SizedBox(width: 38),
//       //                       GestureDetector(
//       //                         onTap: () => Get.toNamed(
//       //                           routes.withdraw,
//       //                           arguments: _userWallet[currentWallet],
//       //                         ),
//       //                         child: Column(
//       //                           children: [
//       //                             Container(
//       //                               decoration: BoxDecoration(
//       //                                 color: XMColors.primary_10,
//       //                                 borderRadius: BorderRadius.circular(100),
//       //                               ),
//       //                               padding: const EdgeInsets.all(14),
//       //                               child: SvgPicture.asset(
//       //                                 "assets/icons/arrow-down.svg",
//       //                                 width: 30,
//       //                                 height: 30,
//       //                                 color: XMColors.light,
//       //                               ),
//       //                             ),
//       //                             const SizedBox(height: 14),
//       //                             Text(
//       //                               "Withdraw",
//       //                               style: Theme.of(context)
//       //                                   .textTheme
//       //                                   .bodyText1
//       //                                   ?.copyWith(
//       //                                     fontWeight: FontWeight.w600,
//       //                                   ),
//       //                             ),
//       //                           ],
//       //                         ),
//       //                       ),
//       //                     ]
//       //                   ],
//       //                 ),
//       //               ),
//       //           ],
//       //         ),
//       //         Container(
//       //           padding: const EdgeInsets.fromLTRB(18, 20, 18, 20),
//       //           child: Column(
//       //             children: [
//       //               Row(
//       //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       //                 crossAxisAlignment: CrossAxisAlignment.center,
//       //                 children: [
//       //                   Text(
//       //                     "Recent Transactions",
//       //                     style:
//       //                         Theme.of(context).textTheme.subtitle1!.copyWith(
//       //                               fontWeight: FontWeight.w600,
//       //                             ),
//       //                   ),
//       //                   Padding(
//       //                     padding: const EdgeInsets.only(top: 5),
//       //                     child: GestureDetector(
//       //                       onTap: () => Get.toNamed(routes.transactions),
//       //                       child: Text(
//       //                         "View More",
//       //                         style: Theme.of(context)
//       //                             .textTheme
//       //                             .bodyText1!
//       //                             .copyWith(
//       //                               color: XMColors.primary_10,
//       //                               fontWeight: FontWeight.w600,
//       //                             ),
//       //                       ),
//       //                     ),
//       //                   ),
//       //                 ],
//       //               ),
//       //               const SizedBox(height: 16),
//       //               showTransactions(_isLoadingTransactions, _transactions),
//       //             ],
//       //           ),
//       //         ),
//       //       ],
//       //     ),
//       //   ),
//       // ),
//     );
//   }

//   // indicator widget
//   Container buildDot(int index, BuildContext context) {
//     return Container(
//       height: 10,
//       width: currentWallet == index ? 36 : 10,
//       decoration: currentWallet == index
//           ? (BoxDecoration(
//               borderRadius: BorderRadius.circular(20),
//               color: XMColors.primary,
//             ))
//           : (BoxDecoration(
//               borderRadius: BorderRadius.circular(20),
//               border: Border.all(
//                 color: XMColors.primary,
//                 width: 1.5,
//               ),
//               color: XMColors.light,
//             )),
//     );
//   }
// }
