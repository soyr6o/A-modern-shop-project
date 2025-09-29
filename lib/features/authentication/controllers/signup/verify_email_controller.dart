import 'dart:async';

import 'package:appwrite2/appwrite.dart';
import 'package:appwrite2/data/repositories/authentication_repositories.dart';
import 'package:appwrite2/features/authentication/screens/signup/success/success.dart';
import 'package:appwrite2/utils/constants/images.dart';
import 'package:appwrite2/utils/constants/texts.dart';
import 'package:appwrite2/utils/popups/snackbar.dart';
import 'package:get/get.dart';

class VerifyController extends GetxController{
  static VerifyController get instance => Get.find();
  
  final _auth = Get.find<AppwriteService>().account;

  @override
  void onInit() {
    sendEmailVerify();
    setTimerForAuthentication();
    super.onInit();
  }


  Future<void> sendEmailVerify() async{
    try{
      await _auth.get();
      Authentication.instance.sendEmailVerify();
      MSnackBarHelpers.successSnackBar(title: "Email Send",message: "Please check your inbox and click the link to verify your account");
    }catch(e){
      MSnackBarHelpers.errorSnackBar(title: "Error",message: e.toString());
    }
  }

  void setTimerForAuthentication(){
    Timer.periodic(Duration(seconds: 1),(timer) async{
      final user = await _auth.get();
      if (user.emailVerification == true) {
        timer.cancel();
        Get.off(SuccessScreen(
          image: MImage.successfulPaymentIcon,
          title: MText.verifyEmailTitle,
          subTitle: MText.verifyEmailSubTitle,
          onPressed: ()=>Authentication.instance.screenRedirect(),
        ));
      }
    });
  }

  Future<void> checkEmailVerify() async{
    try{
      final user = await _auth.get();
      if (user != null && user.emailVerification) {
        Get.off(SuccessScreen(
          image: MImage.successfulPaymentIcon,
          title: MText.verifyEmailTitle,
          subTitle: MText.verifyEmailSubTitle,
          onPressed: ()=>Authentication.instance.screenRedirect(),
        ));
      }  
    }catch(e){
      MSnackBarHelpers.errorSnackBar(title: "Error",message: e.toString());
    }
  }
}