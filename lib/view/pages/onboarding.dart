import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:xendly_mobile/view/shared/colors.dart';
import 'package:xendly_mobile/view/shared/widgets.dart';
import 'package:xendly_mobile/view/shared/widgets/solid_button.dart';
import 'package:xendly_mobile/view/shared/routes.dart' as routes;

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);
  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  int currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              XMColors.primary,
              XMColors.accent,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            const Spacer(),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _contentsList.length,
                onPageChanged: (int index) => {
                  setState(
                    () => {
                      currentIndex = index,
                    },
                  ),
                },
                itemBuilder: (_, i) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        heading1(_contentsList[i].title, XMColors.light,
                            TextAlign.center),
                        const SizedBox(height: 12),
                        strongBody(_contentsList[i].description, XMColors.gray,
                            FontWeight.w400, TextAlign.center),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _contentsList.length,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: buildDot(index, context),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SolidButton(
                text: (currentIndex == _contentsList.length - 1
                    ? 'Continue to Register'
                    : 'Continue'),
                action: () => {
                  if (currentIndex < _contentsList.length - 1)
                    {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      ),
                    }
                  else
                    {
                      Navigator.popAndPushNamed(context, routes.signUp),
                    }
                },
                buttonColor: XMColors.light,
                textColor: XMColors.accent,
              ),
            ),
            const SizedBox(height: 7),
            SolidButton(
              text: (currentIndex == _contentsList.length - 1
                  ? 'Proceed to Login'
                  : 'Ignore'),
              action: () => {
                if (currentIndex < _contentsList.length - 2)
                  {_pageController.jumpToPage(2)}
                else if (currentIndex < _contentsList.length - 1)
                  {_pageController.jumpToPage(2)}
                else
                  {
                    Navigator.popAndPushNamed(
                      context,
                      routes.signIn,
                    ),
                  }
              },
              buttonColor: XMColors.none,
              textColor: XMColors.light,
            ),
          ],
        ),
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 8,
      width: currentIndex == index ? 28 : 8,
      decoration: currentIndex == index
          ? (BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: XMColors.light,
            ))
          : (BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: XMColors.light),
              color: XMColors.none,
            )),
    );
  }
}

class OnboardingContent {
  String title, description;
  OnboardingContent({required this.title, required this.description});
}

List<OnboardingContent> _contentsList = [
  OnboardingContent(
    title: "Get access to secure, multicurrency accounts",
    description:
        "Get access to a digital wallet wey dey available in multiple currecncies and sharp security with kia kia payment.",
  ),
  OnboardingContent(
    title: "Transfer funds to users all around the world",
    description:
        "Get access to a digital wallet wey dey available in multiple currecncies and sharp security with kia kia payment.",
  ),
  OnboardingContent(
    title: "Hold money in more than 50+ currencies",
    description:
        "Get access to a digital wallet wey dey available in multiple currecncies and sharp security with kia kia payment.",
  ),
];
