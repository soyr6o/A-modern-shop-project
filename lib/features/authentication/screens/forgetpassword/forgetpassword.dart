import 'package:appwrite2/features/authentication/screens/forgetpassword/resetpassword.dart';
import 'package:appwrite2/utils/constants/texts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

class ForGetPassword extends StatelessWidget {
  const ForGetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 36,right: 35,top: 60,bottom: 35,),
          child: ListView(
            children: [
              Text(MText.forgetPassword,style: Theme.of(context).textTheme.headlineLarge,),
              SizedBox(height: 7,),
              Text(MText.forgetPasswordSubTitle,style: Theme.of(context).textTheme.bodyMedium,),
              SizedBox(height: 50,),
              SizedBox(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: MText.email,
                    prefixIcon: Icon(Iconsax.direct_right)
                  ),
                ),
              ),
              SizedBox(height: 24,),
              SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  child: ElevatedButton(onPressed: ()=>Get.to(ResetPasswordScreen()), child: Text("Submit")))
            ],
          ),
        ),
      ),
    );
  }
}
