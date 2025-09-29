import 'package:appwrite2/features/authentication/controllers/onboarding/onboarding_controler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class Skipbutton extends StatelessWidget {
  const Skipbutton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnboardingController.instance;
    return Obx(
        ()=> controller.currentIndex.value == 2 ? SizedBox() : Positioned(
          top: 10,
          right: 10,
          child: TextButton(onPressed: controller.skipPage, child: Text("Skip",style: TextStyle(color: Colors.white,fontSize: 15),))),
    );
  }
}