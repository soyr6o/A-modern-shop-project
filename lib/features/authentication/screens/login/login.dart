import 'package:appwrite2/features/authentication/controllers/login/login_controller.dart';
import 'package:appwrite2/features/authentication/screens/forgetpassword/forgetpassword.dart';
import 'package:appwrite2/features/authentication/screens/signup/signup.dart';
import 'package:appwrite2/features/button/buttomnavigation.dart';
import 'package:appwrite2/utils/constants/images.dart';
import 'package:appwrite2/utils/constants/sizes.dart';
import 'package:appwrite2/utils/constants/texts.dart';
import 'package:appwrite2/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

class LoginScreens extends StatelessWidget {
  const LoginScreens({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: ListView(
            padding: EdgeInsets.only(top: 100),
            children: [
              Form(
                key: controller.loginFormKy,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(MText.loginTitle,style: Theme.of(context).textTheme.headlineMedium,),
                    SizedBox(height: 10,),
                    Text(MText.loginSubTitle,style: Theme.of(context).textTheme.bodySmall,),
                    SizedBox(height: 30,),
                    TextFormField(
                      validator: (value)=>MValidator.validateEmail(value),
                      controller: controller.email,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Iconsax.direct_right),
                          labelText: MText.email,
                        ),
                      ),
                    SizedBox(height: 15,),
                    Obx(
                        ()=> TextFormField(
                        validator: (value)=>MValidator.validateEmptyText("Password",value),
                        controller: controller.password,
                          obscureText: controller.isPasswordVisible.value,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Iconsax.password_check),
                            labelText: MText.password,
                            suffixIcon: IconButton(onPressed: controller.isPasswordVisible.toggle, icon: controller.isPasswordVisible.value ? Icon(Iconsax.eye_slash): Icon(Iconsax.eye))
                          ),
                        ),
                    ),
                    Row(
                      children: [
                        Obx(()=> Checkbox(value: controller.isCheckBox.value, onChanged: (value)=>controller.isCheckBox.toggle())),
                        Text(MText.rememberMe),
                        Spacer(),
                        TextButton(onPressed: ()=>Get.to(ForGetPassword()), child: Text(MText.forgetPassword,style: TextStyle(color: Colors.blueAccent.shade700),)),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.all(1),
                      child: SizedBox(
                        width: double.infinity,
                          child: ElevatedButton(onPressed: controller.loginWithEmailAndPassword, child: Text(MText.signIn))),
                    ),
                    SizedBox(height: 5,),
                    Padding(
                      padding: const EdgeInsets.all(1),
                      child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(onPressed: ()=> Get.to(()=>Signup()), child: Text(MText.createAccount))),
                    ),
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
                          child: IconButton(onPressed: controller.googleSignin, icon: Image.asset(MImage.google,height: MSizes.iconMd,)),
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
