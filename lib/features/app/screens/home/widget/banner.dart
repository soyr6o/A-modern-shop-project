import 'package:appwrite2/features/authentication/controllers/home/homecontroller.dart';
import 'package:appwrite2/utils/constants/images.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CarouselSlider(
          carouselController: controller.carouselController,
            items: [
              Image(image: AssetImage(MImage.homeBanner1),),
              Image(image: AssetImage(MImage.homeBanner2),),
              Image(image: AssetImage(MImage.homeBanner3),),
              Image(image: AssetImage(MImage.homeBanner4),),
              Image(image: AssetImage(MImage.homeBanner5),),
            ], options: CarouselOptions(
          viewportFraction: 1,
          onPageChanged: (index,reason)=> controller.onPageChanged(index),
        )),
      ),
    );
  }
}