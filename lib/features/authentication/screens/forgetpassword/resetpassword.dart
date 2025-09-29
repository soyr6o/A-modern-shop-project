import 'package:appwrite2/features/authentication/screens/login/login.dart';
import 'package:appwrite2/utils/constants/images.dart';
import 'package:appwrite2/utils/constants/texts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: ()=>Get.offAll(LoginScreens()), icon: Icon(Icons.clear))
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(30),
          children: [
            Image.asset(MImage.mailSentImage,height: 250,),
            SizedBox(height: 32,),
            Center(child: Text(MText.resetPasswordTitle,style: Theme.of(context).textTheme.headlineMedium,)),
            SizedBox(height: 6,),
            Center(child: Text("email.com")),
            SizedBox(height: 10,),
            Center(child: Text(MText.resetPasswordSubTitle,textAlign: TextAlign.center,style: Theme.of(context).textTheme.bodyMedium,)),
            SizedBox(height: 50,),
            ElevatedButton(onPressed: ()=>Get.to(LoginScreens()), child: Text("Done")),
            TextButton(onPressed: (){}, child: Text("Resent Email",style: TextStyle(color: Colors.blueAccent,fontSize: 15),))
          ],
        ),
      ),
    );
  }
}
