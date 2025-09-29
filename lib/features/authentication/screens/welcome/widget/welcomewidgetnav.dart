import 'package:appwrite2/features/authentication/controllers/onboarding/onboarding_controler.dart';
import 'package:appwrite2/utils/helpers/dvise_helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class welcomewidgetnav extends StatelessWidget {
  welcomewidgetnav({
    super.key,
  });

  final controller = OnboardingController.instance;
  @override
  Widget build(BuildContext context) {
    return Positioned(
        child: SmoothPageIndicator(
          controller: controller.pageController,
          onDotClicked: controller.dotNavigationClick,
          count: 3,
          effect: ExpandingDotsEffect(
            dotHeight: 10,
          ),
        )
    );
  }
}