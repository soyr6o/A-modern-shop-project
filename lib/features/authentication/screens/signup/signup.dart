import 'package:appwrite2/features/authentication/controllers/signup/signup_controller.dart';
import 'package:appwrite2/features/authentication/screens/signup/success/success.dart';
import 'package:appwrite2/features/authentication/screens/signup/verify/verify.dart';
import 'package:appwrite2/utils/constants/color.dart';
import 'package:appwrite2/utils/constants/images.dart';
import 'package:appwrite2/utils/constants/sizes.dart';
import 'package:appwrite2/utils/constants/texts.dart';
import 'package:appwrite2/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: ListView(
              padding: EdgeInsets.only(top: 50),
              children: [
                Form(
                  key: controller.signUpFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(MText.signupTitle,style: Theme.of(context).textTheme.headlineMedium,),
                      SizedBox(height: 30,),
                      Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 160,
                                  child: TextFormField(
                                    controller: controller.firstName,
                                    validator: (value)=> MValidator.validateEmptyText("First Name", value),
                                    decoration: InputDecoration(
                                      labelText: MText.firstName,
                                      prefixIcon: Icon(Iconsax.user)
                                    ),
                                  )),
                              Spacer(),
                              SizedBox(
                                width: 160,
                                  child: TextFormField(
                                    controller: controller.lastName,
                                    validator: (value)=>MValidator.validateEmptyText("Last name", value),
                                    decoration: InputDecoration(
                                      labelText: MText.lastName,
                                        prefixIcon: Icon(Iconsax.user)
                                    ),
                                  )),
                            ],
                          ),
                          SizedBox(height: 15,),
                          TextFormField(
                            controller: controller.email,
                            validator: (value)=>MValidator.validateEmail(value),
                            decoration: InputDecoration(
                              prefixIcon: Icon(Iconsax.direct_right),
                              labelText: MText.email,
                            ),
                          ),
                          SizedBox(height: 15,),
                          TextFormField(
                            controller: controller.phoneNumber,
                            validator: (value)=>MValidator.validatePhoneNumber(value),
                            decoration: InputDecoration(
                              prefixIcon: Icon(Iconsax.call),
                              labelText: MText.phoneNumber,
                            ),
                          ),
                          SizedBox(height: 15,),
                          Obx(
                            ()=> TextFormField(
                              obscureText: !controller.isPasswordVisible.value,
                              controller: controller.password,
                              validator: (value)=>MValidator.validatePassword(value),
                              decoration: InputDecoration(
                                prefixIcon: Icon(Iconsax.password_check),
                                suffixIcon: IconButton(onPressed: ()=> controller.isPasswordVisible.value = !controller.isPasswordVisible.value, icon: Icon(controller.isPasswordVisible.value ? Iconsax.eye_slash : Iconsax.eye),),
                                labelText: MText.password,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Obx(
                          ()=> Checkbox(
                                value: controller.isPrivacyPolicy.value, onChanged: (value)=> controller.isPrivacyPolicy.value = !controller.isPrivacyPolicy.value),
                          ),
                          RichText(text: TextSpan(
                            children:[
                              TextSpan(text: MText.iAgreeTo,style: TextStyle(color: Colors.grey),),
                              TextSpan(text: " ",),
                              TextSpan(text: MText.privacyPolicy,style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.blueAccent,decoration: TextDecoration.underline,decorationColor: Colors.blueAccent)),
                              TextSpan(text: " ",),
                              TextSpan(text: MText.and,style: TextStyle(color:Colors.grey),),
                              TextSpan(text: " ",),
                              TextSpan(text: MText.termsOfUse,style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.blueAccent,decoration: TextDecoration.underline,decorationColor: Colors.blueAccent)),
                            ]
                          ),)
                        ],
                      ),
                      SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.all(1),
                        child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(onPressed: controller.registerUser, child: Text("Sign up"))),
                      ),
                      SizedBox(height: 5,),
                      Row(
                        children: [
                          Expanded(child: Divider(indent: 10,)),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                            child: Text(MText.orSignInWith,style: TextStyle(fontSize: 10),),
                          ),
                          Expanded(child: Divider(endIndent: 10,)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade900),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: IconButton(onPressed: (){}, icon: Image.asset(MImage.google,height: MSizes.iconMd,)),
                          ),
                          SizedBox(width: 10,),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade900),
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.white
                            ),
                            child: IconButton(onPressed: (){}, icon: Image.asset(MImage.facebook,height: MSizes.iconMd,)),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
      ),
    );
  }
}
