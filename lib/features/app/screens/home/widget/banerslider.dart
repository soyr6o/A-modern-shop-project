import 'package:appwrite2/features/authentication/controllers/home/homecontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Banersliderwidgetpage extends StatelessWidget {

  Banersliderwidgetpage({
    super.key,
  });
  final controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    final controller = HomeController.instance;
    return Obx(
        ()=> SmoothPageIndicator(
            controller: PageController(initialPage: controller.currentIndex.value),
            count: 5,
            effect: ExpandingDotsEffect(
              dotHeight: 10,
            ),
          ),
    );
  }

}