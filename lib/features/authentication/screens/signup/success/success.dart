import 'package:appwrite2/data/repositories/authentication_repositories.dart';
import 'package:appwrite2/utils/constants/images.dart';
import 'package:appwrite2/utils/constants/texts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key, this.title, this.subTitle, this.image, required this.onPressed});

  final String? title,subTitle,image;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(30),
          children: [
            Image.asset(image ?? "",height: 250,),
            SizedBox(height: 32,),
            Center(child: Text(title ??"",style: Theme.of(context).textTheme.headlineMedium,textAlign: TextAlign.center,)),
            SizedBox(height: 6,),
            Padding(
              padding: const EdgeInsets.only(left: 5,right: 5),
              child: Center(child: Text(subTitle ?? "",textAlign: TextAlign.center,style: Theme.of(context).textTheme.bodyMedium,)),
            ),
            SizedBox(height: 50,),
            ElevatedButton(onPressed: onPressed, child: Text("Continue")),
          ],
        ),
      ),
    );
  }
}
