import 'package:appwrite2/features/authentication/controllers/onboarding/onboarding_controler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class UElevatedButton extends StatelessWidget {
  const UElevatedButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnboardingController.instance;
    return Column(mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(28.0),
          child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: controller.nextPage, child: Obx(()=> Text(controller.currentIndex.value == 2 ? 'GetStarted': 'next')))),
        ),
      ],
    );
  }
}