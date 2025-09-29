import 'package:appwrite2/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class welcomewidgetpage extends StatelessWidget {

  welcomewidgetpage({
    super.key, required this.animation,required this.title,required this.subtitle,
  });
  String animation;
  String title;
  String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
       padding: EdgeInsets.symmetric(horizontal: MSizes.defaultSpace),
      child: Column(
        children: [
          Lottie.asset(animation,height: 350),
          Text(title,style: Theme.of(context).textTheme.headlineMedium,),
          Text(subtitle,style: Theme.of(context).textTheme.headlineSmall,textAlign: TextAlign.center,),
        ],
      ),
    );
  }
}