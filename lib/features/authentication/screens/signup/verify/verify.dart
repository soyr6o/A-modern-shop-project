import 'package:appwrite2/data/repositories/authentication_repositories.dart';
import 'package:appwrite2/features/authentication/controllers/signup/verify_email_controller.dart';
import 'package:appwrite2/features/authentication/screens/login/login.dart';
import 'package:appwrite2/utils/constants/images.dart';
import 'package:appwrite2/utils/constants/texts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Verify extends StatelessWidget {
  Verify({super.key,required this.email});
String? email;
  @override
  Widget build(BuildContext context) {
    final logot = Get.put(Authentication());
    final controller = Get.put(VerifyController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: logot.logout, icon: Icon(Icons.clear))
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(30),
          children: [
            Image.asset(MImage.mailSentImage,height: 250,),
            SizedBox(height: 32,),
            Center(child: Text(MText.verifyEmailTitle,style: Theme.of(context).textTheme.headlineMedium,)),
            SizedBox(height: 6,),
            Center(child: Text(email ?? '')),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left: 5,right: 5),
              child: Center(child: Text("We’ve sent a verification link to your email. Please check your inbox and click the link to verify your account",textAlign: TextAlign.center,style: Theme.of(context).textTheme.bodyMedium,)),
            ),
            SizedBox(height: 50,),
            ElevatedButton(onPressed: controller.checkEmailVerify, child: Text("Continue")),
            TextButton(onPressed: ()=>controller.sendEmailVerify(), child: Text("Resent Email",style: TextStyle(color: Colors.blueAccent,fontSize: 15),))
          ],
        ),
      ),
    );
  }
}
