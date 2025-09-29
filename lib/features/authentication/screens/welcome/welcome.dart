import 'package:appwrite2/features/authentication/controllers/onboarding/onboarding_controler.dart';
import 'package:appwrite2/features/authentication/screens/welcome/widget/Skipbutton.dart';
import 'package:appwrite2/features/authentication/screens/welcome/widget/elevatedbutton_widget.dart';
import 'package:appwrite2/features/authentication/screens/welcome/widget/welcomewidgetnav.dart';
import 'package:appwrite2/features/authentication/screens/welcome/widget/welcomewidgetpage.dart';
import 'package:appwrite2/utils/constants/images.dart';
import 'package:appwrite2/utils/constants/texts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class WelcomeScreens extends StatelessWidget {
   WelcomeScreens({super.key});
  final controller = Get.put(OnboardingController());


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(
              width: 20,
              height: 481,
              child: Stack(
                children: [
                  PageView(
                    controller: controller.pageController,
                    onPageChanged:  controller.updatePageIndicator,
                    children: [
                      welcomewidgetpage(animation: MImage.onboarding1Animation, title: MText.onBoardingTitle1, subtitle: MText.onBoardingSubTitle1,),
                      welcomewidgetpage(animation: MImage.onboarding2Animation, title: MText.onBoardingTitle2, subtitle: MText.onBoardingSubTitle2,),
                      welcomewidgetpage(animation: MImage.onboarding3Animation, title: MText.onBoardingTitle3, subtitle: MText.onBoardingSubTitle3,),
                    ]
                  ),
                  Skipbutton(),
                ],
              ),
            ),
            Center(child: welcomewidgetnav()),
            Padding(
              padding: const EdgeInsets.only(top: 170),
              child: UElevatedButton(),
            ),
          ],
        ),
      ),
    );
  }
}








