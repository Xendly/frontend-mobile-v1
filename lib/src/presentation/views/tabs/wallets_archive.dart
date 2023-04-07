// import 'package:flutter/material.dart';
// import 'package:xendly_mobile/view/shared/colors.dart';
// import 'package:xendly_mobile/view/shared/widgets.dart';
// import 'package:xendly_mobile/view/shared/widgets/solid_button.dart';

// class Wallets extends StatefulWidget {
//   const Wallets({Key? key}) : super(key: key);
//   @override
//   State<Wallets> createState() => _WalletsState();
// }

// class _WalletsState extends State<Wallets> {
//   late PageController _pageController;
//   int currentCard = 0;
//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController(
//       viewportFraction: 0.85,
//       initialPage: 0,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     List<Widget> walletCards = [
//       walletCard(context),
//       walletCard(context),
//       walletCard(context),
//       walletCard(context),
//     ];
//     AnimatedContainer cardSlider(images, index, active) {
//       double margin = active ? 8.5 : 8.5;
//       return AnimatedContainer(
//         duration: const Duration(milliseconds: 500),
//         curve: Curves.easeInOutCubic,
//         margin: EdgeInsets.all(margin),
//         child: Center(
//           child: walletCards[index],
//         ),
//       );
//     }

//     return Scaffold(
//       backgroundColor: XMColors.light,
//       extendBody: true,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 10),
//             child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 18,
//                   ),
//                   child: rowTitleBar(),
//                 ),
//                 const SizedBox(height: 34),
//                 SizedBox(
//                   height: 200,
//                   child: PageView.builder(
//                     itemCount: walletCards.length,
//                     pageSnapping: true,
//                     scrollDirection: Axis.horizontal,
//                     controller: _pageController,
//                     physics: const BouncingScrollPhysics(),
//                     onPageChanged: (page) {
//                       setState(() {
//                         currentCard = page;
//                       });
//                     },
//                     itemBuilder: (context, index) {
//                       bool active = index == currentCard;
//                       return cardSlider(walletCards, index, active);
//                     },
//                   ),
//                 ),
//                 const SizedBox(height: 34),
//                 SizedBox(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: List.generate(
//                       walletCards.length,
//                       (index) => Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 5),
//                         child: buildDot(index, context),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 34),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 18,
//                   ),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: SolidButton(
//                           text: "Add Money",
//                           action: () => {},
//                           buttonColor: XMColors.primary,
//                         ),
//                       ),
//                       const SizedBox(width: 15),
//                       Expanded(
//                         child: SolidButton(
//                             text: "Transfer",
//                             action: () => {},
//                             buttonColor: XMColors.primary),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 40),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 18,
//                   ),
//                   child: sectionTitle(),
//                 ),
//                 const SizedBox(height: 10),
//                 listItem(),
//                 listItem(),
//                 listItem(),
//                 listItem(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Container buildDot(int index, BuildContext context) {
//     return Container(
//       height: 8,
//       width: currentCard == index ? 28 : 8,
//       decoration: currentCard == index
//           ? (BoxDecoration(
//               borderRadius: BorderRadius.circular(20),
//               color: XMColors.primary,
//             ))
//           : (BoxDecoration(
//               borderRadius: BorderRadius.circular(20),
//               border: Border.all(color: XMColors.primary),
//               color: XMColors.none,
//             )),
//     );
//   }
// }
