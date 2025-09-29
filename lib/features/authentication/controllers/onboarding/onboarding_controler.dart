import 'package:appwrite2/features/authentication/screens/login/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class OnboardingController extends GetxController {
  static OnboardingController get instance => Get.find();

  final pageController = PageController();
  RxInt currentIndex = 0.obs;
  final storage = GetStorage();

  void updatePageIndicator(index){
    currentIndex.value = index;

  }

  void dotNavigationClick(index){
    currentIndex.value = index;
    pageController.jumpToPage(index);
  }

  void nextPage(){
    if (currentIndex.value == 2) {
      storage.write("isFirstTime", false);
      Get.offAll(()=>LoginScreens());
      return ;
    }
    currentIndex.value++;
    pageController.animateToPage(
      currentIndex.value,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

  }

  void skipPage(){
    currentIndex.value = 2;
    pageController.animateToPage(
      currentIndex.value,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

}