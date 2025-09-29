import 'package:appwrite2/utils/constants/color.dart';
import 'package:appwrite2/utils/constants/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
class MFullScreenLoader {
  static void openLoadingDialog(String text) {
    final ctx = Get.overlayContext ?? Get.context;
    if (ctx == null) return; // یا میتونی یک throw یا log بزنی

    showDialog(
      context: ctx,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: Container(
          color: Theme.of(ctx).brightness == Brightness.dark
              ? MColors.dark
              : MColors.white,
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset(MImage.loadingAnimation1, height: 350),
              Text( text,
                textAlign: TextAlign.center, // وسط‌چین شدن متن
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.grey, // رنگ خاکستری
                  decoration: TextDecoration.none, // حذف خط زیر
                  fontWeight: FontWeight.w500,)),
            ],
          ),
        ),
      ),
    );
  }

  static void stopLoading() {
    final ctx = Get.overlayContext ?? Get.context;
    if (ctx != null && Navigator.canPop(ctx)) {
      Navigator.of(ctx).pop();
    }
  }

}